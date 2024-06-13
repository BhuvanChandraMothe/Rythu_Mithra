import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rythu_mithra/pages/webview.dart';
import 'package:rythu_mithra/theme/green.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final String _name = "Bhuvan Chandra Mothe";
  final String _address = "Hyderabad, India";
  final String _email = "bhuvanchandramothe@gmail.com";
  final String _linkedinUrl =
      "https://www.linkedin.com/in/bhuvan-chandra-mothe-ba346a201/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: greenColor,
        title: const Center(
          child: Padding(
            padding: EdgeInsets.only(right: 70),
            child: Text(
              ' M E E T    T H E    D E V  ',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Hey there! I am',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 5),
              Text(
                _name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                _address,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Reach out to me at:',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 5),
              Text(
                _email,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WebviewPage(url: _linkedinUrl),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: greenColor,
                ),
                child: const Text('Contact me on LinkedIn'),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(right: 55),
                child: Lottie.asset(
                  'lib/images/dev5.json',
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
