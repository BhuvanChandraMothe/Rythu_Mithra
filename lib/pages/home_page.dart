import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:rythu_mithra/components/drawer.dart';
import 'package:rythu_mithra/pages/forums_page.dart';
import 'package:rythu_mithra/pages/gemini_chat_bot.dart';
import 'package:rythu_mithra/pages/login_or_register.dart';
import 'package:rythu_mithra/pages/market_intro_page.dart';
import 'package:rythu_mithra/pages/profile.dart';
import 'package:rythu_mithra/pages/tips_widget.dart';
import 'package:rythu_mithra/pages/weatherwidget.dart';
import 'package:rythu_mithra/theme/green.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  final currentUser = FirebaseAuth.instance.currentUser!;

  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut().then((value) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginOrRegisterPage()),
        (Route<dynamic> route) => false,
      );
    });
  }

  String getGreeting() {
    var hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good morning 🌄 ,';
    } else if (hour < 17) {
      return 'Good afternoon 🌇 ,';
    } else {
      return 'Good evening 🌃 ,';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: greenColor,
        title: const Center(
          child: Text(
            ' R Y T H U  M I T H R A ',
            style: TextStyle(color: Colors.white),
          ),
        ),
        elevation: 0,
        toolbarHeight: 80,
        iconTheme: IconThemeData(
          color: Colors.white, // Change drawer icon color to white
        ),
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          )
        ],
      ),
      drawer: MyDrawer(
        onLogoutTap: signUserOut,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const ChatBotPage();
            },
          ),
        ),
        child: const Icon(Icons.chat_rounded),
      ),
      body: Column(
        mainAxisAlignment:
            MainAxisAlignment.center, // Center everything vertically
        children: [
          const SizedBox(height: 10),
          StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Users")
                .doc(currentUser.email)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final userData = snapshot.data!.data() as Map<String, dynamic>;
                return Container(
                  height: 100,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Greeting and "Hi" message
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              getGreeting(),
                              style: GoogleFonts.openSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Hi ${userData['username']} ! ',
                              style: GoogleFonts.openSans(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                          width: 16), // Add spacing between text and animation
                      // Lottie animation
                      Lottie.asset(
                        'lib/images/s.json',
                        width: 200,
                        height: 220,
                      ),
                    ],
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
          const SizedBox(height: 10),
          Container(
            height: 150,
            color: const Color.fromARGB(255, 180, 194, 180),
            child: WeatherContainer(),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: TipsWidget(), // Add TipsWidget here
            ),
          ),
        ],
      ),
    );
  }
}
