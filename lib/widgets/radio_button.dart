import 'package:flutter/material.dart';

class RadioButton extends StatefulWidget {
  final bool active;
  final Function(bool) onChanged;
  final Color activeColor;
  final Color inactiveColor;
  final double size;
  final double borderWidth;

  const RadioButton({
    super.key,
    required this.active,
    required this.onChanged,
    required this.activeColor,
    required this.inactiveColor,
    this.size = 24.0,
    this.borderWidth = 2.0,
  });

  @override
  State<RadioButton> createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onChanged(!widget.active),
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: widget.active ? widget.activeColor : widget.inactiveColor,
                  width: widget.borderWidth,
                ),
              ),
            ),
            if (widget.active)
              Container(
                width: widget.size - (widget.borderWidth * 2) - 2,
                height: widget.size - (widget.borderWidth * 2) - 2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.activeColor,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
