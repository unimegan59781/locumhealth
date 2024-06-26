import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fyp/pages/worker/workerNav.dart';
import 'package:fyp/templates/displayText.dart';
import 'package:fyp/templates/profileView.dart';

class WorkerProfile extends StatefulWidget {
  final String workerId;

  const WorkerProfile({super.key, required this.workerId});

  @override
  State createState() => WorkerProfileState();
}

class WorkerProfileState extends State<WorkerProfile> {
  DatabaseReference dbhandler = FirebaseDatabase.instance.ref();
  // Default values if the profile is empty
  String name = " First Last Name ";
  String imgPath = "default";
  int experience = 0;
  String description = "No Description";

  @override
  void initState() {
    // This function is called when the state is initialized
    super.initState();
    setState(() {
      getProfile();
    });
  }

  // Get the profile of the worker from db
  void getProfile() async {
    await dbhandler
        .child('Profiles')
        .orderByChild('user_id')
        .equalTo(widget.workerId)
        .onValue
        .first
        .then((event) async {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic>? data =
            event.snapshot.value as Map<dynamic, dynamic>?;
        if (data != null) {
          var pKey = data.keys.first;
          var pData = data[pKey];
          setState(() {
            name = pData['name'];
            imgPath = pData['img'];
            experience = pData['experience'];
            description = pData['description'];
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffFCFAFC),
        appBar: AppBar(
          backgroundColor: const Color(0xffFCFAFC),
          title: const Padding(
            padding: EdgeInsets.only(top: 20), // Add padding above the title
            child: Center(
              child: DisplayText(
                  text: "Your Profile", fontSize: 36, colour: Colors.black),
            ),
          ),
          automaticallyImplyLeading: false, // Remove the back button
        ),
        body: SafeArea(
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
              const SizedBox(height: 10),
              ProfileView(
                // Display the profile
                name: name,
                imgPath: imgPath,
                experience: '$experience Years Experience',
                description: description,
                scale: 1, // default scale
              ),
              const SizedBox(height: 40),
              TextButton(
                onPressed: () {
                  // Navigate user to the settings page to edit the profile
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          // Navigate to the settings page
                          builder: (context) => WorkerNavigationBar(
                              workerId: widget.workerId, setIndex: 4)));
                },
                child: const DisplayText(
                    // Display the text
                    text: "To edit the profile go to settings",
                    fontSize: 18,
                    colour: Colors.deepPurple),
              ),
            ]))));
  }
}
