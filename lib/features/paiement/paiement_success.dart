import 'package:cap221_app/utils/app_colors.dart';
import 'package:cap221_app/utils/validations.dart';
import 'package:cap221_app/widgets/custom_auth_input.dart';
import 'package:cap221_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';

paiementSucces(BuildContext context) async {
  Validations validations = Validations();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final TextEditingController phoneCtlr = TextEditingController();

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
            child: const Text("PAIEMENT ACCEPTE",
                style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center),
          ),
        ),
        content: Container(
          padding:
              const EdgeInsets.only(top: 0, left: 25, right: 25, bottom: 20),
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text("Félicitation, votre inscription est finalisé.",
                    style: TextStyle(color: AppColors.black),
                    textAlign: TextAlign.center),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      );
    },
  );
}
