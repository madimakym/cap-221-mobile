import 'package:cap221_app/features/auth/login/login_page.dart';
import 'package:cap221_app/features/home/home_page.dart';
import 'package:cap221_app/features/home/widgets/drawer_item.dart';
import 'package:cap221_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/global_vars.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.primary,
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: AppColors.primary),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.account_circle,
                    color: Colors.white,
                    size: 80,
                  ),
                  Text(
                    "${currentUser["lastname"]}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "${currentUser["firstname"]}",
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ],
              ),
            ),
            buildDrawerItem(
                libelle: "TOUS LES ARTICLE (${totalArticle.toInt()})",
                icon: Icons.select_all,
                context: context,
                onTap: () => {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(
                              url: "/wp-json/wp/v2/posts?&per_page=100",
                              title: 'CAP 221',
                            ),
                          ),
                          (route) => false)
                    }),
            for (var item in (existArticle))
              buildDrawerItem(
                  libelle: "${item["name"]}".toUpperCase(),
                  count: "${item["count"]}",
                  icon: Icons.article,
                  context: context,
                  onTap: () => {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(
                                url:
                                    "/wp-json/wp/v2/posts?categories=${item["id"]}&per_page=20",
                                title: '${item["name"]}'.toUpperCase(),
                              ),
                            ),
                            (route) => false)
                      }),
            buildDrawerItem(
                libelle: "Déconnexion",
                icon: Icons.logout,
                context: context,
                onTap: () => {
                      logout().then((value) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                            (route) => false);
                      })
                    }),
          ],
        ),
      ),
    );
  }
}

Future logout() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();
  // await DefaultCacheManager().emptyCache();
  return true;
}
