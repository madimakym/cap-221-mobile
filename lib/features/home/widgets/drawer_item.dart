import 'package:flutter/material.dart';

Widget buildDrawerItem(
    {required String libelle,
    required IconData icon,
    required dynamic onTap,
    required context}) {
  return ListTile(
    leading: Icon(icon, color: Colors.black),
    title: Text(
      libelle,
      style: const TextStyle(color: Colors.black, fontSize: 18),
    ),
    onTap: onTap,
  );
}
