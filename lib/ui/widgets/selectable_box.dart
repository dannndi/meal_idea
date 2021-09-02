import 'package:flutter/material.dart';

class SelectableBox extends StatelessWidget {
  final double height;
  final double width;
  final String title;
  final bool isSelected;
  final Function onTap;
  EdgeInsetsGeometry? margin;

  SelectableBox({
    this.height = 50,
    this.width = 70,
    this.margin,
    required this.title,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: height,
        width: width,
        margin: margin,
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).primaryColor
              : Theme.of(context).primaryColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white.withOpacity(0.9),
            ),
          ),
        ),
      ),
    );
  }
}
