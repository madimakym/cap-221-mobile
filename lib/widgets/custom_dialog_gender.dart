import 'package:cap221_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

genderDialog(BuildContext context, {Color color = AppColors.primary}) async {
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
              children: const [
                Text("Sélectionner un genre",
                    style: TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
        content: Container(
          padding: const EdgeInsets.only(top: 0, left: 5, right: 5, bottom: 20),
          width: cwidth,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                child: ListTile(
                    title: const Text("Homme",
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    leading: const Card(
                      elevation: 0,
                      color: Color.fromARGB(240, 221, 250, 255),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop("Homme");
                    }),
              ),
              InkWell(
                child: ListTile(
                    title: const Text("Femme",
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    leading: const Card(
                      elevation: 0,
                      color: Color.fromARGB(240, 221, 250, 255),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop("Femme");
                    }),
              ),
              InkWell(
                child: ListTile(
                    title: const Text("Mali",
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    leading: const Card(
                      elevation: 0,
                      color: Color.fromARGB(240, 221, 250, 255),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: Image(
                        width: 30,
                        fit: BoxFit.cover,
                        image: AssetImage('lib/assets/img/ml.png'),
                      ),
                    ),
                    trailing: const Text("+223",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    onTap: () {
                      Navigator.of(context).pop("ml");
                    }),
              ),
              InkWell(
                child: ListTile(
                    title: const Text("Sénégal",
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    leading: const Card(
                      elevation: 0,
                      color: Color.fromARGB(240, 221, 250, 255),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: Image(
                        width: 30,
                        fit: BoxFit.cover,
                        image: AssetImage('lib/assets/img/sn.png'),
                      ),
                    ),
                    trailing: const Text("+221",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    onTap: () {
                      Navigator.of(context).pop("sn");
                    }),
              ),
            ],
          ),
        ),
      );
    },
  );
}
