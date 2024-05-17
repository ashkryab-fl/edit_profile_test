import 'dart:io';

import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    super.key,
    required this.localPath,
    required this.text,
  });

  final String localPath;
  final String text;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.black12,
      foregroundImage: localPath.isNotEmpty? FileImage(File(localPath)) : null,
      radius: 60,
      child:  Text(
       text.isEmpty?'Hi':text,
        style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );
  }


}
