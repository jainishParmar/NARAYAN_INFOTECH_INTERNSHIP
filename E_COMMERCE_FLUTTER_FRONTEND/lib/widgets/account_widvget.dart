import 'package:flutter/material.dart';

import 'package:intern_final/utils/dimension.dart';
import 'package:intern_final/widgets/app_icon.dart';

class AccountWidget extends StatelessWidget {
  AppIcon appIcon;
  Text bigtext;
  AccountWidget({Key? key, required this.appIcon, required this.bigtext})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: Dimensions.width20,
          top: Dimensions.width10,
          bottom: Dimensions.width10),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            blurRadius: 1,
            offset: const Offset(0, 2),
            color: Colors.grey.withOpacity(0.2))
      ]),
      child: Row(
        children: [
          appIcon,
          SizedBox(
            width: Dimensions.width20,
          ),
          bigtext,
        ],
      ),
    );
  }
}
