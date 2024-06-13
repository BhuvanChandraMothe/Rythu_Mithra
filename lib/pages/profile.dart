import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rythu_mithra/components/text_box.dart';
import 'package:rythu_mithra/theme/green.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //user
  final currentUser = FirebaseAuth.instance.currentUser!;

  //all users
  final usersCollection = FirebaseFirestore.instance.collection('Users');

  //edit field
  Future<void> editField(String field) async {
    String newValue = '';
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          'Edit  $field',
          style: const TextStyle(color: Colors.white),
        ),
        content: TextField(
          autofocus: true,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Enter new $field",
            hintStyle: const TextStyle(color: Colors.grey),
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          //cancel button
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              )),

          //save button
          TextButton(
            onPressed: () => Navigator.of(context).pop(newValue),
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
    //update in firestore
    if (newValue.trim().length > 0) {
      //only update if therer is something in the field
      await usersCollection.doc(currentUser.email).update({field: newValue});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(left: 90.0),
            child: Text(
              "Profile Page",
              style: TextStyle(color: Colors.white),
            ),
          ),
          backgroundColor: greenColor,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Users")
                .doc(currentUser.email)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final userData = snapshot.data!.data() as Map<String, dynamic>;
                // Return a Widget based on userData
                return ListView(children: [
                  const SizedBox(
                    height: 50,
                  ),
                  //profile pic
                  const Icon(
                    Icons.person,
                    size: 72,
                  ),

                  const SizedBox(height: 10),

                  //user mail
                  Text(
                    currentUser.email!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.grey[700], fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(
                    height: 50,
                  ),

                  //user details
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text('My details',
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),

                  //user name
                  MyTextBox(
                    text: userData['username'],
                    sectionName: 'User Name',
                    onPressed: () => editField('username'),
                  ),

                  //bio
                  MyTextBox(
                      text: userData['bio'],
                      sectionName: 'Bio',
                      onPressed: () => editField('bio')),

                  const SizedBox(
                    height: 30,
                  ),

                  //user posts

                  // Padding(
                  //   padding: const EdgeInsets.only(left: 25),
                  //   child: Text('My Posts',
                  //       style: TextStyle(color: Colors.grey[600])),
                  // ),

                  // const SizedBox(
                  //   height: 50,
                  // ),
                ]);
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}
