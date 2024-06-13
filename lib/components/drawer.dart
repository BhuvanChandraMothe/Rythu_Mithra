import 'package:flutter/material.dart';
import 'package:rythu_mithra/components/my_list_tile.dart';
import 'package:rythu_mithra/pages/about.dart';
import 'package:rythu_mithra/pages/forum_intro.dart';
import 'package:rythu_mithra/pages/forums_page.dart';
import 'package:rythu_mithra/pages/home_page.dart';
import 'package:rythu_mithra/pages/market_home.dart';
import 'package:rythu_mithra/pages/market_intro_page.dart';
import 'package:rythu_mithra/pages/ml_model.dart';
import 'package:rythu_mithra/pages/ml_model_intro.dart';
import 'package:rythu_mithra/pages/profile.dart';

class MyDrawer extends StatelessWidget {
  //final void Function()? onProfileTap;
  final void Function()? onLogoutTap;

  const MyDrawer({
    super.key,
    required this.onLogoutTap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: const Color.fromARGB(255, 10, 124, 86),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                //header
                const DrawerHeader(
                  child: CircleAvatar(
                    backgroundImage: AssetImage('lib/images/logo.png'),
                    radius: 100,
                  ),
                ),

                //home list
                MyListTile(
                  icon: Icons.home,
                  text: 'H O M E',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  ),
                ),

                //CRS ML tile
                MyListTile(
                  icon: Icons.recommend,
                  text: 'C R O P  R E C O M M E N D E R',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CropRecommendationPage()),
                  ),
                ),

                //Marketplace tile
                MyListTile(
                  icon: Icons.store_rounded,
                  text: 'M A R K E T P L A C E',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MarketHomePage()),
                  ),
                ),

                //Forums tile
                MyListTile(
                  icon: Icons.message_rounded,
                  text: 'F O R U M S',
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ForumPage())),
                ),

                //profile tile
                MyListTile(
                  icon: Icons.person,
                  text: 'P R O F I L E',
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfilePage())),
                ),

                MyListTile(
                  icon: Icons.info_rounded,
                  text: 'A B O U T  U S',
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AboutPage())),
                ),
              ],
            ),
            //logout tile
            Padding(
              padding: const EdgeInsets.only(bottom: 25.0),
              child: MyListTile(
                  icon: Icons.logout_rounded,
                  text: 'L O G O U T',
                  onTap: onLogoutTap),
            ),
          ],
        ));
  }
}
