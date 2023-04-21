import 'package:flutter/material.dart';
import 'app.dart';
import 'route/router.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App(router: AppRouter()));
}
