import 'package:cap221_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

selectDialog(BuildContext context, String title, List items,
    {Color color = AppColors.primary}) async {
  double cwidth = MediaQuery.of(context).size.width * 0.8;
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(22.0))),
        contentPadding: const EdgeInsets.only(top: 10.0, bottom: 0.0),
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0)),
          ),
          child: Container(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: Column(
              children: [
                Text(title,
                    style: const TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
        content: Container(
          padding:
              const EdgeInsets.only(top: 0, left: 15, right: 15, bottom: 20),
          width: cwidth,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var i in items)
                  InkWell(
                      child: Container(
                          padding: const EdgeInsets.all(8.0),
                          width: double.infinity,
                          child: Text(i['title'])),
                      onTap: () => Navigator.of(context).pop(i['value'])),
              ],
            ),
          ),
        ),
      );
    },
  );
}

selectDialogMetier(BuildContext context, String title, List items,
    {Color color = AppColors.primary}) async {
  double cwidth = MediaQuery.of(context).size.width * 0.8;
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(22.0))),
        contentPadding: const EdgeInsets.only(top: 10.0, bottom: 0.0),
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0)),
          ),
          child: Container(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: Column(
              children: [
                Text(title,
                    style: const TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
        content: Container(
          padding:
              const EdgeInsets.only(top: 0, left: 15, right: 15, bottom: 20),
          width: cwidth,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var i in items)
                  InkWell(
                      child: Container(
                          padding: const EdgeInsets.all(8.0),
                          width: double.infinity,
                          child: Text(i['libelle'])),
                      onTap: () => Navigator.of(context).pop(i['libelle'])),
              ],
            ),
          ),
        ),
      );
    },
  );
}
