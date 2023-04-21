import 'dart:convert';

import 'package:cap221_app/features/auth/register/register_2_page.dart';
import 'package:cap221_app/features/paiement/paiement_confirm.dart';
import 'package:cap221_app/features/paiement/paiement_init.dart';
import 'package:cap221_app/utils/app_colors.dart';
import 'package:cap221_app/utils/validations.dart';
import 'package:cap221_app/widgets/custom_auth_input.dart';
import 'package:cap221_app/widgets/custom_button.dart';
import 'package:cap221_app/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../repository/auth_repository.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Validations validations = Validations();
  late final TextEditingController _firstnameCtlr = TextEditingController();
  late final TextEditingController _lastnameCtlr = TextEditingController();
  late final TextEditingController _oldCtlr = TextEditingController();
  late final TextEditingController _emailCtlr = TextEditingController();
  late final TextEditingController _phoneCtlr = TextEditingController();
  late final TextEditingController _passwordCtlr = TextEditingController();
  late final TextEditingController _passwordConfirmCtlr =
      TextEditingController();

  FocusNode phoneNode = FocusNode();
  FocusNode pinFocus = FocusNode();

  bool autovalidate = false;
  bool isActivated = true;
  bool isSetPin = true;
  bool show = false;
  final _authRepository = AuthRepository();
  dynamic _selectedValue;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                const Text("Créez votre compte",
                    style: TextStyle(
                        color: AppColors.black,
                        fontSize: 40.0,
                        fontWeight: FontWeight.w800)),
                const SizedBox(height: 15),
                const Text(
                    "Vous êtes 3.765.923 de jeunes garçons et filles hors main d’œuvre potentielle et inactifs. Aidez nous à vous recenser et à vous orienter.",
                    style: TextStyle(color: AppColors.black, fontSize: 16)),
                const SizedBox(height: 15),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      CustomAuthInput(
                          labelText: "Nom",
                          obscureText: false,
                          textInputType: TextInputType.text,
                          isNumeric: false,
                          readOnly: false,
                          bottomMargin: 15.0,
                          validator: validations.validateInput,
                          controller: _firstnameCtlr),
                      CustomAuthInput(
                          labelText: "Prénom",
                          obscureText: false,
                          textInputType: TextInputType.text,
                          isNumeric: false,
                          readOnly: false,
                          bottomMargin: 15.0,
                          validator: validations.validateInput,
                          controller: _lastnameCtlr),
                      CustomAuthInput(
                          labelText: "Numéro de téléphone",
                          obscureText: false,
                          textInputType: TextInputType.text,
                          isNumeric: true,
                          readOnly: false,
                          bottomMargin: 15.0,
                          validator: validations.validateInput,
                          controller: _phoneCtlr),
                      CustomAuthInput(
                          labelText: "Age",
                          obscureText: false,
                          textInputType: TextInputType.text,
                          isNumeric: true,
                          readOnly: false,
                          bottomMargin: 15.0,
                          validator: validations.validateInput,
                          controller: _oldCtlr),
                      CustomAuthInput(
                          labelText: "Email",
                          obscureText: false,
                          textInputType: TextInputType.text,
                          isNumeric: false,
                          readOnly: false,
                          bottomMargin: 15.0,
                          validator: validations.validateInputEmail,
                          controller: _emailCtlr),
                      Row(
                        children: <Widget>[
                          const Text("Genre:",
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 18.0)),
                          Expanded(
                            child: RadioListTile(
                              title: const Text('Homme'),
                              value: "Homme",
                              groupValue: _selectedValue,
                              onChanged: (value) {
                                setState(() => _selectedValue = value);
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile(
                              title: const Text('Femme'),
                              value: "Femme",
                              groupValue: _selectedValue,
                              onChanged: (value) {
                                setState(() => _selectedValue = value);
                              },
                            ),
                          ),
                        ],
                      ),
                      CustomAuthInput(
                          labelText: "Mot de passe",
                          obscureText: true,
                          textInputType: TextInputType.text,
                          isNumeric: false,
                          readOnly: false,
                          bottomMargin: 15.0,
                          validator: validations.validateInput,
                          controller: _passwordCtlr),
                      CustomAuthInput(
                          labelText: "Confirmer le nouveau mot de passe",
                          obscureText: true,
                          textInputType: TextInputType.text,
                          isNumeric: false,
                          readOnly: false,
                          bottomMargin: 15.0,
                          validator: validations.validateInput,
                          controller: _passwordConfirmCtlr),
                      const SizedBox(height: 20),
                      CustomButton(
                          title: "Continuer",
                          onPress: () => _handleCheckStatus(context),
                          color: AppColors.primary),
                      const SizedBox(height: 20)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _handleCheckStatus(context) async {
    if (_passwordCtlr.text != _passwordConfirmCtlr.text) {
      dialogError(context,
          code: "fomulaire",
          color: AppColors.red,
          message: "Les mots de passe doivent être les mêmes!");
      autovalidate = true;
    } else {
      final form = formKey.currentState;
      FocusScope.of(context).requestFocus(FocusNode());
      String data = jsonEncode({
        "firstname": _firstnameCtlr.text,
        "lastname": _lastnameCtlr.text,
        "phone": _phoneCtlr.text,
        "email": _emailCtlr.text,
        "age": _oldCtlr.text,
        "password": _passwordCtlr.text,
        "passwordConfirm": _passwordConfirmCtlr.text,
        "genre": _selectedValue,
      });
      if (form!.validate()) {
        try {
          EasyLoading.show(status: 'Chargement...');
          var response = await _authRepository.checkUser(data);
          EasyLoading.dismiss();
          if (response['status'] == 200) {
            dialogError(context,
                code: "Inscription",
                message: "L'utilisateur à déjà un compte !",
                color: AppColors.danger);
          }
        } catch (error) {
          error as Map;
          EasyLoading.dismiss();
          if (error['code'].toString() == "406") {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Register2Page(user: data)),
            );
          } else {
            dialogError(context,
                code: error['code'].toString(),
                message: error['message'] ?? "erreur lors de l'inscription",
                color: AppColors.danger);
          }
        }
      } else {
        autovalidate = true;
      }
    }
  }
}
