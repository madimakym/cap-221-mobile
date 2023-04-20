import 'dart:convert';

import 'package:cap221_app/utils/app_colors.dart';
import 'package:cap221_app/utils/global_vars.dart';
import 'package:cap221_app/utils/validations.dart';
import 'package:cap221_app/widgets/custom_auth_input.dart';
import 'package:cap221_app/widgets/custom_button.dart';
import 'package:cap221_app/widgets/custom_select_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Register2Page extends StatefulWidget {
  late String user;
  Register2Page({Key? key, required this.user}) : super(key: key);

  @override
  State<Register2Page> createState() => _Register2PageState();
}

class _Register2PageState extends State<Register2Page> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Validations validations = Validations();
  late final TextEditingController _regionCtlr = TextEditingController();
  late final TextEditingController _numeroCNICtlr = TextEditingController();
  late final TextEditingController _lastnameCtlr = TextEditingController();
  late final TextEditingController _metierCtlr = TextEditingController();
  late final TextEditingController _secteurCtlr = TextEditingController();
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
    // print("user: ${widget.user}");
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
                const SizedBox(height: 100),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Row(
                    children: const [
                      Icon(Icons.chevron_left, size: 25),
                      Text(
                        "Page précedente",
                        style: TextStyle(color: AppColors.black, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text("Créez votre compte",
                    style: TextStyle(
                        color: AppColors.black,
                        fontSize: 40.0,
                        fontWeight: FontWeight.w800)),
                const SizedBox(height: 20),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: IgnorePointer(
                          child: Row(
                            children: [
                              Expanded(
                                child: CustomAuthInput(
                                    labelText: "Region",
                                    obscureText: false,
                                    textInputType: TextInputType.text,
                                    isNumeric: false,
                                    readOnly: false,
                                    bottomMargin: 20.0,
                                    validator: validations.validateInput,
                                    controller: _regionCtlr),
                              ),
                            ],
                          ),
                        ),
                        onTap: () => {
                          selectDialog(context, "Sélèctionner une region",
                                  regionItem)
                              .then((value) {
                            setState(() => _regionCtlr.text = value);
                          }),
                        },
                      ),
                      CustomAuthInput(
                          labelText: "Numéro CNI",
                          obscureText: false,
                          textInputType: TextInputType.text,
                          isNumeric: false,
                          readOnly: false,
                          bottomMargin: 20.0,
                          validator: validations.validateInput,
                          controller: _numeroCNICtlr),
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: IgnorePointer(
                          child: Row(
                            children: [
                              Expanded(
                                child: CustomAuthInput(
                                    labelText: "Secteur d'activités",
                                    obscureText: false,
                                    textInputType: TextInputType.text,
                                    isNumeric: false,
                                    readOnly: false,
                                    bottomMargin: 20.0,
                                    validator: validations.validateInput,
                                    controller: _secteurCtlr),
                              ),
                            ],
                          ),
                        ),
                        onTap: () => {
                          selectDialog(
                                  context,
                                  "Sélèctionner un secteur d'activités",
                                  secteurItem)
                              .then((value) {
                            setState(() => _secteurCtlr.text = value);
                          }),
                        },
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: IgnorePointer(
                          child: Row(
                            children: [
                              Expanded(
                                child: CustomAuthInput(
                                    labelText: "Metier",
                                    obscureText: false,
                                    textInputType: TextInputType.text,
                                    isNumeric: false,
                                    readOnly: false,
                                    bottomMargin: 20.0,
                                    validator: validations.validateInput,
                                    controller: _metierCtlr),
                              ),
                            ],
                          ),
                        ),
                        onTap: () => {
                          selectDialog(context, "Sélèctionner un metier",
                                  secteurItem)
                              .then((value) {
                            setState(() => _metierCtlr.text = value);
                          }),
                        },
                      ),
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
    final form = formKey.currentState;
    FocusScope.of(context).requestFocus(FocusNode());
    String data = jsonEncode({
      "firstname": _numeroCNICtlr.text,
      "lastname": _lastnameCtlr.text,
      "email": _emailCtlr.text,
      "password": _passwordCtlr.text,
    });
    if (form!.validate()) {
      // EasyLoading.show(status: 'Chargement...');
      // var response = await _authRepository.checkStatus(data);
      // var responseQrcode = await _authRepository.getQrcodeToken(data);
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setString('qrcode', responseQrcode['token']);
    } else {
      autovalidate = true;
    }
  }
}
