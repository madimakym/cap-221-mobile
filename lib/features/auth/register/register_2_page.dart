import 'dart:convert';
import 'dart:io';
import 'package:cap221_app/features/paiement/paiement_success.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:cap221_app/features/auth/repository/auth_repository.dart';
import 'package:cap221_app/utils/app_colors.dart';
import 'package:cap221_app/utils/global_vars.dart';
import 'package:cap221_app/utils/validations.dart';
import 'package:cap221_app/widgets/custom_auth_input.dart';
import 'package:cap221_app/widgets/custom_button.dart';
import 'package:cap221_app/widgets/custom_select_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../widgets/custom_dialog.dart';
import '../../paiement/paiement_confirm.dart';
import '../../paiement/paiement_init.dart';
import '../login/login_page.dart';

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
  late final TextEditingController _metierCtlr = TextEditingController();
  late final TextEditingController _secteurCtlr = TextEditingController();

  FocusNode phoneNode = FocusNode();
  FocusNode pinFocus = FocusNode();

  bool autovalidate = false;
  bool isActivated = true;
  bool isSetPin = true;
  bool show = false;
  dynamic _selectedMetier;
  final _authRepository = AuthRepository();
  File? cni;
  File? cv;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future getFileCNI(context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['pdf', 'doc', 'docx']);
    if (result != null) {
      setState(() {
        cni = File(result.files.single.path!);
      });
      print('Selected document path: ${cni!.path}');
      //sendImageUpdateData(cni, context);
      //uploadFile(cni!, context);
    } else {
      // User canceled the picker
    }
  }

  Future getFileCV(context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['pdf', 'doc', 'docx']);
    if (result != null) {
      setState(() {
        cv = File(result.files.single.path!);
      });
      print('Selected document path: ${cv!.path}');
      //sendImageUpdateData(cv, context);
      //uploadFile(cv!, context);
    } else {
      // User canceled the picker
    }
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
                const SizedBox(height: 40),
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
                const SizedBox(height: 15),
                const Text(
                    "Vous êtes 3.765.923 de jeunes garçons et filles hors main d’œuvre potentielle et inactifs. Aidez nous à vous recenser et à vous orienter.",
                    style: TextStyle(color: AppColors.black, fontSize: 16)),
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
                          selectDialog(context, "Sélectionner une region",
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
                        onTap: () {
                          selectDialog(
                                  context,
                                  "Sélèctionner un secteur d'activités",
                                  secteurItem)
                              .then((value) {
                            setState(() {
                              _secteurCtlr.text = value;
                              _metierCtlr.text = "";
                            });
                            _getMetier(context);
                          });
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
                        onTap: () {
                          if (_selectedMetier != null) {
                            selectDialogMetier(context,
                                    "Sélèctionner un metier", _selectedMetier)
                                .then((value) {
                              setState(() {
                                _metierCtlr.text = value;
                              });
                            });
                          } else {
                            dialogError(context,
                                code: "Metier",
                                message:
                                    "aucun metier associé au secteur ${_secteurCtlr.text}",
                                color: AppColors.danger);
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              child: Column(
                                children: [
                                  const Text("Fichier CNI"),
                                  cni != null
                                      ? const Icon(
                                          Icons.file_open_rounded,
                                          color: Colors.green,
                                          size: 120,
                                        )
                                      : const Icon(
                                          Icons.file_download,
                                          size: 120,
                                        ),
                                  cni != null
                                      ? Text(path.basename(cni!.path))
                                      : const Text(""),
                                ],
                              ),
                              onTap: () {
                                getFileCNI(context);
                              },
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              child: Column(
                                children: [
                                  const Text("Fichier CV"),
                                  cv != null
                                      ? const Icon(
                                          Icons.file_open_rounded,
                                          color: Colors.green,
                                          size: 120,
                                        )
                                      : const Icon(
                                          Icons.file_download,
                                          size: 120,
                                        ),
                                  cv != null
                                      ? Text(path.basename(cv!.path))
                                      : const Text(""),
                                ],
                              ),
                              onTap: () {
                                getFileCV(context);
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
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
    if (form!.validate() && cv != null && cni != null) {
      String dataForToken = jsonEncode({
        "username": "digitalubuntu",
        "grant_type": "password",
        "client_type": "public",
        "client_id": "AKOLWm5vf8GIX5o5KNstduNUlBtDLKR2cMjO6uex",
        "client_secret":
            "qN5xpN5EvIynwXIKoarW5yxysuFL9Si5qyQZAPuSt3KplrmUGdGiUBdRmOttQ0w5oUKXrMxK2RfRZ4hx15S856G3AEVoAM5Rq172yGeUt0nP6hZk2K0HOcpOrIswSiKv",
        "password": "256378dgubuntu798869",
        "country": "sn"
      });
      try {
        EasyLoading.show(status: 'Chargement...');
        var response = await _authRepository.initToken(dataForToken);
        EasyLoading.dismiss();
        paiementInit(context).then((value) async {
          askForOtp(value, response, context);
        });
      } catch (error) {
        error as Map;
        EasyLoading.dismiss();
        dialogError(context,
            code: error['code'].toString(),
            message: error['message'] ??
                error['error'] ??
                "Erreur de l'initialisation du paiement.",
            color: AppColors.danger);
      }
    } else {
      dialogError(context,
          code: "Inscription",
          message: "Formulaire incomplet.",
          color: AppColors.danger);
      autovalidate = true;
    }
  }

  askForOtp(number, response, context) async {
    String dataForOtp = jsonEncode({
      "msisdn": "$number",
      "merchant_msisdn": "777314929",
      "merchant_pin": "7314",
      "amount": "25",
      "country": "sn",
      "token": "${response["access_token"]}"
    });
    try {
      EasyLoading.show(status: 'Chargement...');
      var response2 = await _authRepository.initPaiement(
          dataForOtp, response["access_token"]);
      EasyLoading.dismiss();
      paiementConfirm(context).then((value) async {
        confirmPaiement(value, response, response2, context);
      });
    } catch (error) {
      error as Map;
      EasyLoading.dismiss();
      dialogError(context,
          code: error['code'].toString(),
          message: error['message'] ??
              error['error'] ??
              "Erreur de l'envoie de l'OTP.",
          color: AppColors.danger);
    }
  }

  confirmPaiement(otp, response, response2, context) async {
    String dataForPaiement = jsonEncode({
      "merchant_pin": "7314",
      "merchant_msisdn": "777314929",
      "transaction_id": "${response2["TransactionID"]}",
      "otp": "$otp",
      "country": "sn",
      "token": "${response["access_token"]}"
    });
    try {
      EasyLoading.show(status: 'Chargement...');
      var response3 = await _authRepository.confirmtPaiement(
          dataForPaiement, response["access_token"]);
      incription(context);
      EasyLoading.dismiss();
    } catch (error) {
      error as Map;
      EasyLoading.dismiss();
      print(error);
      dialogError(context,
          code: error['code'].toString(),
          message: error['message'] ??
              error['error'] ??
              "Erreur de l'envoie de l'OTP.",
          color: AppColors.danger);
    }
  }

  incription(context) async {
    String data = jsonEncode({
      "metier": _metierCtlr.text,
      "numero_cni": _numeroCNICtlr.text,
      "region": _regionCtlr.text,
      "secteur": _secteurCtlr.text,
      "cv": path.basename(cv!.path),
      "cni": path.basename(cni!.path),
    });
    Map<String, dynamic> userJson = jsonDecode(widget.user);
    Map<String, dynamic> dataJson = jsonDecode(data);
    dataJson.addAll(userJson);
    String finalData = jsonEncode(dataJson);

    try {
      EasyLoading.show(status: 'Chargement...');
      var response = await _authRepository.inscription(finalData);
      EasyLoading.dismiss();
      paiementSucces(context).then((value) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
      });
    } catch (error) {
      error as Map;
      EasyLoading.dismiss();
      print(error);
      dialogError(context,
          code: error['code'].toString(),
          message: error['message'] ?? error['error'] ?? "Inscription échoué",
          color: AppColors.danger);
    }
  }

  Future<void> uploadFile(File file, context) async {
    var url = Uri.parse('$wpay/api/v1/upload/');
    var request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath(
      'file',
      file.path,
      filename: path.basename(file.path),
      contentType: MediaType.parse(lookupMimeType(file.path)!),
    ));
    var response = await request.send();
    if (response.statusCode == 200) {
      print('File uploaded successfully');
    } else {
      dialogError(context,
          code: "Envoie de fichier",
          message: "Erreur lors de l'upload du fichier.",
          color: AppColors.danger);
    }
  }

  Future sendImageUpdateData(fileToSend, context) async {
    var request =
        http.MultipartRequest('POST', Uri.parse('$wpay/api/v1/upload/'));
    request.files
        .add(await http.MultipartFile.fromPath('file', fileToSend!.path));
    var res = await request.send();
    var stream = res.stream;
    var decodedStream = stream.transform(utf8.decoder);
    var responseBody = await decodedStream.join();
    print(responseBody);
    if (res.statusCode == 201) {
      print('reponse positive');
      String filename = await res.stream.bytesToString();
    } else {
      dialogError(context,
          code: "Envoie de fichier",
          message: "Erreur lors de l'upload du fichier.",
          color: AppColors.danger);
      return false;
    }
  }

  _getMetier(context) async {
    String data = jsonEncode({"groupe": _secteurCtlr.text});
    try {
      EasyLoading.show(status: 'Chargement...');
      var response = await _authRepository.getMetier(data);
      EasyLoading.dismiss();
      setState(() {
        _selectedMetier = response;
      });
    } catch (error) {
      error as Map;
      EasyLoading.dismiss();
      print(error);
      dialogError(context,
          code: error['code'].toString(),
          message: error['message'] ?? error['error'] ?? "Erreur de connexion.",
          color: AppColors.danger);
    }
  }
}
