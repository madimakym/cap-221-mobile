import 'dart:convert';
import 'package:cap221_app/features/auth/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'features/auth/repository/auth_repository.dart';
import 'features/home/home_page.dart';
import 'route/router.dart';
import 'utils/app_theme.dart';
import 'utils/global_vars.dart';

class App extends StatefulWidget {
  final AppRouter router;

  const App({Key? key, required this.router}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _authRepository = AuthRepository();

  @override
  void initState() {
    _configLoading();
    checkIfIsLog();
    super.initState();
  }

  _configLoading() {
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.dark
      ..radius = 10.0
      ..userInteractions = false
      ..dismissOnTap = false;
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      theme: WizallTheme.lightTheme,
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('fr', 'FR')],
      onGenerateRoute: widget.router.generateRoute,
      home: FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, AsyncSnapshot<SharedPreferences> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              var prefs = snapshot.data;
              var jsonData = prefs?.getString("user");
              if (jsonData != null) {
                var user = json.decode(jsonData);
                currentUser = user;
                return const HomePage(
                    url: '/wp-json/wp/v2/posts?per_page=100', title: "CAP 221");
              } else {
                return const LoginPage();
              }
            } else {
              // return const HomePage();
              return const LoginPage();
            }
          }
          // return Container(
          //   color: AppColors.primary,
          //   alignment: Alignment.center,
          //   child: Image.asset(
          //     'lib/assets/img/logo.png',
          //     width: 240.0,
          //   ),
          // );
          return const LoginPage();
        },
      ),
    );
  }

  checkIfIsLog() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var user = prefs.getString("user");
    if (user != null && token != null) {
      getCat();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(
              url: '/wp-json/wp/v2/posts?per_page=100', title: "CAP 221"),
        ),
      );
    }
  }
}
