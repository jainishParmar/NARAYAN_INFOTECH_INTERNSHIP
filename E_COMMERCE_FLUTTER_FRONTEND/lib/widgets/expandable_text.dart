import 'package:flutter/material.dart';


import '../utils/dimension.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  const ExpandableText({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String seconfHalf;

  bool hiddenText = true;
  double textHeight = Dimensions.screenHeight / 4.63;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      seconfHalf = widget.text
          .substring(textHeight.toInt() + 1, widget.text.length.toInt());
    } else {
      firstHalf = widget.text;
      seconfHalf = '';
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: seconfHalf.isEmpty
          ? Text(firstHalf,style: TextStyle(fontSize: Dimensions.font16,color: Colors.black54,height: 1.5),) : Column(
        children: [
          Text( hiddenText
              ? (firstHalf + "...")
              : (firstHalf + seconfHalf),style: TextStyle(fontSize: Dimensions.font16,color: Colors.black54,height: 1.5),),
          InkWell(
            onTap: () {
              setState(() {
                hiddenText = !hiddenText;
              });
            },
            child: Row(
              children: [
                hiddenText
                    ? Row(
                  children: const [
                    Text("show more",style: TextStyle(
                      color: Colors.pink
                    ),),
                    Icon(Icons.arrow_drop_down,color: Colors.pink,),
                  ],
                )
                    : Row(
                  children: const [
                    Text("show less",style: TextStyle(
                        color: Colors.pink
                    ),),
                    Icon(
                      Icons.arrow_drop_up,
                      color: Colors.pink,
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
