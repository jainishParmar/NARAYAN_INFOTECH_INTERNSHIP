import 'package:flutter/material.dart';
import 'package:intern_final/utils/dimension.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: Dimensions.height20*5,
        width: Dimensions.width20*5,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radius30*1.66),
            color: Colors.pink
        ),
        alignment: Alignment.center,
        child: const CircularProgressIndicator(color: Colors.white),
      ),
    );
  }
}
