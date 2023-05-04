import 'dart:convert';
import 'package:cap221_app/features/auth/register/register_page.dart';
import 'package:cap221_app/features/auth/repository/auth_repository.dart';
import 'package:cap221_app/features/home/home_page.dart';
import 'package:cap221_app/utils/app_colors.dart';
import 'package:cap221_app/utils/global_vars.dart';
import 'package:cap221_app/utils/validations.dart';
import 'package:cap221_app/widgets/custom_auth_input.dart';
import 'package:cap221_app/widgets/custom_button.dart';
import 'package:cap221_app/widgets/custom_dialog.dart';
import 'package:cap221_app/widgets/custom_dialog_gender.dart';
import 'package:cap221_app/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Validations validations = Validations();
  late final TextEditingController _emailCtlr = TextEditingController();
  late final TextEditingController _pwdCtlr = TextEditingController();
  final _authRepository = AuthRepository();

  FocusNode phoneNode = FocusNode();
  FocusNode pinFocus = FocusNode();

  bool autovalidate = false;
  bool isActivated = true;
  bool isSetPin = true;
  bool show = false;
  late String _countryId = "";

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
                const SizedBox(height: 150),
                const Text("Connexion",
                    style: TextStyle(
                        color: AppColors.black,
                        fontSize: 40.0,
                        fontWeight: FontWeight.w800)),
                const SizedBox(height: 20),
                const Text("Notre objectif: Un métier pour tous !",
                    style: TextStyle(color: AppColors.black, fontSize: 16),
                    textAlign: TextAlign.start),
                const SizedBox(height: 40),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      CustomAuthInput(
                          labelText: "Saisissez votre e-mail",
                          obscureText: false,
                          textInputType: TextInputType.text,
                          isNumeric: false,
                          readOnly: false,
                          bottomMargin: 20.0,
                          validator: validations.validateInput,
                          controller: _emailCtlr),
                      const SizedBox(height: 20),
                      CustomAuthInput(
                          labelText: "Tapez votre mot de passe",
                          obscureText: true,
                          textInputType: TextInputType.text,
                          isNumeric: false,
                          readOnly: false,
                          bottomMargin: 20.0,
                          validator: validations.validateInput,
                          controller: _pwdCtlr),
                      InkWell(
                        onTap: () => _launchInWebViewOrVC(Uri.parse(
                            "https://cap221.com/send-reset-password")),
                        child: Container(
                          padding: const EdgeInsets.only(top: 0.0),
                          width: double.infinity,
                          child: const Text(
                            "Mot de passe  oublié ?",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      CustomButton(
                        title: "Valider",
                        onPress: () => _handleCheckStatus(context),
                        color: AppColors.primary,
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterPage()),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          width: double.infinity,
                          child: const Text(
                            "Inscription",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500),
                          ),
                        ),
                      )
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

  Future<void> _launchInWebViewOrVC(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw Exception('Could not launch $url');
    }
  }

  getCat() async {
    try {
      var responseCat = await _authRepository.getCatHasArticle();
      existArticle = responseCat;
    } catch (error) {
      EasyLoading.dismiss();
      /* error as Map;
      dialogError(context,
          code: error['code'].toString(),
          message: error['message'],
          color: AppColors.danger);*/
    }
  }

  Future _handleCheckStatus(context) async {
    final form = formKey.currentState;
    FocusScope.of(context).requestFocus(FocusNode());
    String data =
        jsonEncode({"email": _emailCtlr.text, "password": _pwdCtlr.text});

    if (form!.validate()) {
      try {
        EasyLoading.show(status: 'Chargement...');
        var response = await _authRepository.login(data);
        EasyLoading.dismiss();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', jsonEncode(response));
        try {
          var responseUser = await _authRepository.checkUser(data);
          currentUser = responseUser['message'];
          prefs.setString('user', jsonEncode(responseUser['message']));
          getCat();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(
                      url: '/wp-json/wp/v2/posts?per_page=20',
                      title: 'CAP 221',
                    )),
          );
        } catch (error) {
          EasyLoading.dismiss();
          error as Map;
          dialogError(context,
              code: error['code'].toString(),
              message: error['message'],
              color: AppColors.danger);
        }
      } catch (error) {
        EasyLoading.dismiss();
        error as Map;
        dialogError(context,
            code: error['code'].toString(),
            message: error['message'],
            color: AppColors.danger);
      }
    } else {
      autovalidate = true;
    }
  }
}
