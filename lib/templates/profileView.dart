import 'package:flutter/material.dart';
import 'package:fyp/templates/displayText.dart';

class ProfileView extends StatelessWidget {
  final String name;
  final String imgPath;
  final String experience;
  final String description;
  final int scale;

  ProfileView(
      {required this.name,
      required this.imgPath,
      required this.experience,
      required this.description,
      required this.scale});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 100/scale,
          backgroundImage: AssetImage('lib/images/$imgPath.png'),
        ),
        const SizedBox(height: 20),
        DisplayText(text: name, fontSize: 30/scale, colour: Colors.black),
        const SizedBox(height: 10),
        if (experience != "")
          DisplayText(text: experience, fontSize: 30/scale, colour: Colors.black),
        const SizedBox(height: 20),
        Container(
            height: 200/scale,
            width: 350/scale,
            padding:
                const EdgeInsets.symmetric(horizontal: 2.0, vertical: 10.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2)),
            child: DisplayText(
                text: description, fontSize: 20/scale, colour: Colors.black)),
      ],
    );
  }
}
