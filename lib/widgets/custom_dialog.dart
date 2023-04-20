import 'package:cap221_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'custom_button.dart';

Future<Future> dialogSuccess(BuildContext context,
    {required String code,
    required String message,
    required String route,
    Color color = AppColors.primary}) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        contentPadding: const EdgeInsets.only(top: 10.0, bottom: 0.0),
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          color: color,
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: Text(
              code,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        content: Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(message),
              ],
            )),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: CustomButton(
                  title: "OK",
                  onPress: () => Navigator.pushNamed(context, route),
                  color: AppColors.green,
                )),
              ],
            ),
          ),
        ],
      );
    },
  );
}

Future<Future> dialogError(BuildContext context,
    {required String code,
    required String message,
    Color color = AppColors.primary}) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      // Vibration.vibrate();
      return AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        contentPadding: const EdgeInsets.only(top: 10.0, bottom: 0.0),
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: Text(
              "Erreur $code",
              style: const TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        content: Container(
            padding: const EdgeInsets.all(20.0),
            child: Text(message)),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: CustomButton(
                  title: "Fermer",
                  onPress: () => Navigator.pop(context),
                  color: AppColors.danger,
                )),
              ],
            ),
          ),
        ],
      );
    },
  );
}

Future<Future> dialogError2(BuildContext context,
    {required String code,
    required String message,
    required final Function onPress,
    String validLabel = "Fermer",
    Color color = AppColors.primary,
    Color colorButton = AppColors.danger}) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(0.0))),
        contentPadding: const EdgeInsets.only(top: 10.0, bottom: 0.0),
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          color: color,
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: Text(
              "Erreur $code",
              style: const TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        content: Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(message),
              ],
            )),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: CustomButton(
                  title: validLabel,
                  onPress: onPress,
                  color: colorButton,
                )),
              ],
            ),
          ),
        ],
      );
    },
  );
}

Future<Future> agreementDialog(BuildContext context,
    {required String code,
    required String message,
    required final Function onPressAccepted,
    required final Function onPressCanceled,
    Color color = AppColors.primary}) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(0.0))),
        contentPadding: const EdgeInsets.only(top: 10.0, bottom: 0.0),
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          color: color,
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: Text(
              code,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        content: SingleChildScrollView(
          child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: Text(message)),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: CustomButton(
                  title: "Accepter",
                  onPress: onPressAccepted,
                  color: AppColors.primary,
                )),
                const SizedBox(width: 20),
                Expanded(
                    child: CustomButton(
                  title: "Annuler",
                  onPress: onPressCanceled,
                  color: AppColors.secondary,
                )),
              ],
            ),
          ),
        ],
      );
    },
  );
}
