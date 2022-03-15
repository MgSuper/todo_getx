import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_learn/constants/style.dart';
import 'package:getx_learn/controllers/controllers.dart';
import 'package:getx_learn/core/utils/extensions.dart';

class BuildStatus extends StatelessWidget {
  int number;
  String title;
  Icon icon;
  BuildStatus(
    this.number,
    this.title,
    this.icon,
  );

  @override
  Widget build(BuildContext context) {
    final _locale = Get.find<LocaleController>();
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,
            SizedBox(
              width: 2.0.wp,
            ),
            Padding(
              padding: EdgeInsets.only(top: 1.0.wp),
              child: Text(
                '$number',
                style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0.sp),
              ),
            ),
          ],
        ),
        SizedBox(
          height: _locale.getLocale() == 'MM' ? 0.0.wp : 2.0.wp,
        ),
        Text(
          title,
          style:
              _locale.getLocale() == 'MM' ? mStatusTextStyle : eStatusTextStyle,
        ),
      ],
    );
  }
}
