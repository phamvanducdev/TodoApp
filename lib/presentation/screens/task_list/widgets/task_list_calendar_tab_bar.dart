import 'package:flutter/material.dart';
import 'package:todo_plugin/config/app_colors.dart';
import 'package:todo_plugin/config/app_text_styles.dart';
import 'package:todo_plugin/utils/date_time_utils.dart';
import 'package:todo_plugin/utils/extensions/date_time_extension.dart';

class TaskListCalendarTabBar extends StatefulWidget {
  final DateTime dateTime;
  final Function(DateTime) onDateTimeChanged;

  const TaskListCalendarTabBar({
    super.key,
    required this.dateTime,
    required this.onDateTimeChanged,
  });

  @override
  State<TaskListCalendarTabBar> createState() => _TaskListCalendarTabBarState();
}

class _TaskListCalendarTabBarState extends State<TaskListCalendarTabBar> with TickerProviderStateMixin {
  static const double itemSelectedHeight = 64;
  static const double itemUnSelectedHeight = 54;
  static const double padding = 4;

  late TabController _tabController;
  late List<DateTime> _daysInMonth;
  late int _curentIndex;

  @override
  void initState() {
    super.initState();
    _initializeTabController(widget.dateTime); // Initial setup
  }

  @override
  void didUpdateWidget(covariant TaskListCalendarTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.dateTime != oldWidget.dateTime) {
      _initializeTabController(widget.dateTime);
    }
  }

  void _initializeTabController(DateTime dateTime) {
    _daysInMonth = dateTime.daysInMonth;
    _curentIndex = _daysInMonth.indexWhere((day) => day.isSameDate(dateTime));

    _tabController = TabController(
      initialIndex: _curentIndex,
      length: _daysInMonth.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: padding),
      height: itemSelectedHeight + padding * 2,
      child: DefaultTabController(
        length: _daysInMonth.length,
        child: TabBar(
          tabs: List.generate(
            _daysInMonth.length,
            (index) => _buildDateTimeItem(
              context,
              dateTime: _daysInMonth[index],
              selected: _curentIndex == index,
            ),
          ),
          onTap: (index) {
            if (index != _curentIndex) {
              widget.onDateTimeChanged(_daysInMonth[index]);
              setState(() {
                _curentIndex = index;
              });
            }
          },
          isScrollable: true,
          controller: _tabController,
          tabAlignment: TabAlignment.center,
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          dividerHeight: 0,
          indicatorPadding: EdgeInsets.zero,
          indicatorColor: Colors.transparent,
          labelPadding: EdgeInsets.zero,
        ),
      ),
    );
  }

  _buildDateTimeItem(
    BuildContext context, {
    required DateTime dateTime,
    required bool selected,
  }) {
    return Container(
      width: selected ? itemSelectedHeight : itemUnSelectedHeight,
      height: selected ? itemSelectedHeight : itemUnSelectedHeight,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: selected ? AppColors.subBrandColor : const Color(0xFFEBF2FF),
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            DateTimeUtils.format(dateTime, DateTimeUtils.formatEEE),
            style: AppTextStyle.text2XSMedium.copyWith(
              color: selected ? Colors.white : AppColors.brandColor,
            ),
          ),
          Text(
            DateTimeUtils.format(dateTime, DateTimeUtils.formatdd),
            style: selected
                ? AppTextStyle.textLGSemiBold.copyWith(color: Colors.white)
                : AppTextStyle.textSMSemiBold.copyWith(color: AppColors.brandColor),
          ),
        ],
      ),
    );
  }
}
