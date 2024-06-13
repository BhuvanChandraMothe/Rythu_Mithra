import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:rythu_mithra/pages/login_or_register.dart';

class IntroPage extends StatelessWidget {
  final List<PageViewModel> pages = [
    PageViewModel(
      title: "Welcome to Rythu Mithra",
      body: "Your companion in agricultural success.",
      image: Image.asset('lib/images/logo.png'),
      decoration: PageDecoration(
        titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontSize: 16),
      ),
    ),
    PageViewModel(
      title: "Crop Recommendation",
      body: "Get the best crop recommendations based on your conditions.",
      image: Lottie.asset(
        'lib/images/mlmodelintro1.json',
        width: 200,
        height: 200,
        fit: BoxFit.cover,
      ),
      decoration: PageDecoration(
        titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontSize: 16),
      ),
    ),
    PageViewModel(
      title: "Community Forums",
      body: "Connect with fellow farmers and share knowledge.",
      image: Lottie.asset(
        'lib/images/forum.json',
        width: 200,
        height: 200,
        fit: BoxFit.cover,
      ),
      decoration: PageDecoration(
        titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontSize: 16),
      ),
    ),
    PageViewModel(
      title: "Marketplace",
      body: "Buy fresh farm products directly from the farmers.",
      image: Lottie.asset(
        'lib/images/shoppingbag.json',
        width: 200,
        height: 200,
        fit: BoxFit.cover,
      ),
      decoration: PageDecoration(
        titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontSize: 16),
      ),

      // footer: ElevatedButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => LoginOrRegisterPage()),
      //     );
      //   },
      //   child: Text('Get Started'),
      // ),
    ),
    PageViewModel(
      title: "Harness the power of AI",
      body: "AI powered chat bot to answer all your queries.",
      image: Lottie.asset(
        'lib/images/chat bot.json',
        width: 200,
        height: 200,
        fit: BoxFit.cover,
      ),
      decoration: PageDecoration(
        titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontSize: 16),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: pages,
      onDone: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginOrRegisterPage()),
        );
      },
      onSkip: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginOrRegisterPage()),
        );
      },
      showSkipButton: true,
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: DotsDecorator(
        size: const Size.square(10.0),
        activeSize: const Size(20.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );
  }
}
