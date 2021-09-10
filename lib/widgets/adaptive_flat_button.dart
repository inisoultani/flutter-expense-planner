import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class AdaptiveButton extends StatelessWidget {
  final String text;
  final Function handler;

  const AdaptiveButton({ Key? key, required this.text, required this.handler  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? 
      CupertinoButton(
        child: Text(
          'Choose Date',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ), 
        onPressed: () => this.handler(context)
      ) 
      :
      TextButton(
        onPressed: () => this.handler(context),
        child: Text(
          'Choose Date',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      );
  }
}