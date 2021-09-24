import 'package:flutter/material.dart';
import '../SizeConfig.dart';

class TEXT extends StatelessWidget {
  final String title;
  final double fontsize;
  final Color color;
  final FontWeight fontWeight;

  const TEXT({Key key, this.title, this.fontsize, this.color, this.fontWeight}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(title,style: TextStyle(fontSize: fontsize*SizeConfig.textMultiplier,fontWeight: fontWeight,color: color)
    );
  }
}

