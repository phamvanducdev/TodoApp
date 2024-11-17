import 'package:flutter/material.dart';
import 'package:todo_plugin/config/app_assets.dart';
import 'package:todo_plugin/config/app_colors.dart';
import 'package:todo_plugin/config/app_text_styles.dart';
import 'package:todo_plugin/presentation/screens/update_profile/update_profile_viewmodel.dart';
import 'package:todo_plugin/utils/date_time_utils.dart';
import 'package:todo_plugin/utils/widget_utils.dart';

class InputDateOfBirth extends StatelessWidget {
  final UpdateProfileViewModel viewModel;

  const InputDateOfBirth({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date of birth',
          style: AppTextStyle.textSMMedium.copyWith(color: AppColors.brandColor),
        ),
        const SizedBox(height: 8),
        StreamBuilder<DateTime?>(
          stream: viewModel.dateOfBirthStream,
          builder: (context, snapshot) {
            final DateTime currentDate = snapshot.data ?? DateTime.now();
            return GestureDetector(
              onTap: () async {
                final DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: currentDate,
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null && pickedDate != currentDate) {
                  viewModel.onDateOfBirthChanged(pickedDate);
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.brandColor.withOpacity(0.08)),
                ),
                child: Row(
                  children: [
                    WidgetUtils.svgPicture(AppAssets.iconCalendar),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        DateTimeUtils.format(currentDate, DateTimeUtils.formatMMMddyyyy),
                        style: AppTextStyle.textSMRegular.copyWith(color: AppColors.textColor),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
