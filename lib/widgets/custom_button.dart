import 'dart:io';

import 'package:cap221_app/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final dynamic onPress;
  final Color color;
  final Color textColor;
  final double radiusSize;

  const CustomButton(
      {Key? key,
      required this.title,
      required this.onPress,
      this.color = AppColors.primary,
      this.textColor = AppColors.white,
      this.radiusSize = 10})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Platform.isIOS
            ? SizedBox(
                width: double.infinity,
                height: 45,
                child: CupertinoButton(
                  color: color,
                  onPressed: onPress,
                  borderRadius: BorderRadius.circular(radiusSize),
                  child: Text(
                    title,
                    style: TextStyle(
                        color: textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              )
            : SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: () => onPress(),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: color,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(radiusSize)),
                    textStyle: const TextStyle(fontSize: 15),
                  ),
                  child: Text(
                    title,
                    style: TextStyle(
                        color: textColor,
                        // fontSize: 17,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
      ],
    );
  }
}
