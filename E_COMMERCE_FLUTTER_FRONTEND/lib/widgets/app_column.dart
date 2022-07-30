
import 'package:flutter/material.dart';


import '../utils/dimension.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text,style: TextStyle(fontSize:Dimensions.font16*1.5,),),
        SizedBox(
          height: Dimensions.height10,
        ),
        Row(
          children: [
            Wrap(
              children: List.generate(
                5,
                    (index) => const Icon(
                  Icons.star,
                  color: Colors.pink,
                  size: 15,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text('4.5'),
            SizedBox(
              width: 10,
            ),
            Text( '1287'),
            SizedBox(
              width: 10,
            ),
            Text( 'Comments'),
          ],
        ),
        SizedBox(
          height: Dimensions.height20,
        ),
      ],
    );
  }
}
