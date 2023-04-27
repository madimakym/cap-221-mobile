import 'package:cap221_app/features/home/widgets/drawer_item.dart';
import 'package:cap221_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                children: const [
                  Icon(
                    Icons.account_circle,
                    color: Colors.white,
                    size: 80,
                  ),
                  Text(
                    "ssss",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "rrrr",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ],
              ),
            ),
            buildDrawerItem(
                libelle: "Mon compte",
                icon: Icons.account_circle_outlined,
                context: context,
                onTap: () => {Navigator.pushNamed(context, "/profile")}),
            buildDrawerItem(
                libelle: "Transaction en attente",
                icon: Icons.warning,
                context: context,
                onTap: null),
            buildDrawerItem(
                libelle: "Service Client",
                icon: Icons.info,
                context: context,
                onTap: () => {}),
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
