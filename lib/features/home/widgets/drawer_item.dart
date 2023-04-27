import 'package:flutter/material.dart';

import '../../../utils/global_vars.dart';

Widget buildDrawerItem(
    {required String libelle,
    String count = "0",
    required IconData icon,
    required dynamic onTap,
    required context}) {
  return ListTile(
    leading: Icon(icon, color: Colors.black),
    title: Text(
      "$libelle ${count == "0" ? "" : "($count)"}",
      style: const TextStyle(color: Colors.black, fontSize: 15),
    ),
    onTap: onTap,
  );
}
