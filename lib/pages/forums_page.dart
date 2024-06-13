import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rythu_mithra/components/drawer.dart';
import 'package:rythu_mithra/components/forum_post.dart';
import 'package:rythu_mithra/components/my_textfield.dart';
import 'package:rythu_mithra/helper/time_helper_methods.dart';
import 'package:rythu_mithra/pages/profile.dart';
import 'package:rythu_mithra/theme/green.dart';

class ForumPage extends StatefulWidget {
  const ForumPage({super.key});

  @override
  State<ForumPage> createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  final currentUser = FirebaseAuth.instance.currentUser;
  final TextEditingController textController = TextEditingController();

  void postMessage() {
    if (textController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection("User Posts").add({
        'UserEmail': currentUser?.email,
        'UserName': currentUser?.displayName,
        'Message': textController.text,
        'TimeStamp': Timestamp.now(),
        'Likes': [],
      });
      textController.clear();
    }
  }

  void goToProfilePage() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfilePage()),
    );
  }

  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Center(
          child: Padding(
            padding: EdgeInsets.only(right: 50.0),
            child: Text(
              " F O R U M S ",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        backgroundColor: greenColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: MyDrawer(
        onLogoutTap: logout,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("User Posts")
                    .orderBy("TimeStamp", descending: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final post = snapshot.data!.docs[index];
                        return ForumPosts(
                          message: post['Message'],
                          user: post['UserEmail'],
                          time: formatDate(post['TimeStamp']),
                          postId: post.id,
                          likes: List<String>.from(post['Likes'] ?? []),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Row(
                children: [
                  Expanded(
                    child: MyTextField(
                      controller: textController,
                      hintText: 'Write something to ask the community..',
                      obscureText: false,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_circle_up_rounded,
                      size: 30,
                    ),
                    onPressed: postMessage,
                  ),
                ],
              ),
            ),
            Text(
              "Logged in as: ${currentUser?.email ?? 'Guest'}",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
