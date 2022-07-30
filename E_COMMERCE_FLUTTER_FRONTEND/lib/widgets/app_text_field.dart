import 'package:flutter/material.dart';

import '../utils/dimension.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData icon;
  bool isObscure;
  bool pass;
  AppTextField(
      {Key? key,
      required this.textController,
      required this.hintText,
      required this.icon,
      this.isObscure = false,
      this.pass = false})
      : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.maxFinite,
      margin: EdgeInsets.only(
          left: Dimensions.height20, right: Dimensions.height20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.radius15),
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              spreadRadius: 1,
              offset: Offset(1, 1),
              color: Colors.grey.withOpacity(0.2),
            )
          ]),
      child: TextField(
        obscureText:widget.pass ? widget.isObscure?true:false:false ,
        controller: widget.textController,
        decoration: InputDecoration(
          hintText: widget.hintText,
          prefixIcon: Icon(
            widget.icon,
            color: Colors.pink,
          ),
          suffixIcon:widget.pass?widget.isObscure ? IconButton(onPressed: (){setState((){widget.isObscure=false;});},icon:const Icon(Icons.lock,),color: Colors.pink,):IconButton(onPressed: (){setState((){widget.isObscure=true;});},icon:const Icon(Icons.lock_open,),color: Colors.pink,):null,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius15),
              borderSide: const BorderSide(width: 1.0, color: Colors.white)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius15),
              borderSide: const BorderSide(width: 1.0, color: Colors.white)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius15),
          ),
        ),
      ),
    );
  }
}
