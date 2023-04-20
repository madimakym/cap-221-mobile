import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget customCircularProgress() {
  return Center(
    child: Platform.isIOS
        ? const CupertinoActivityIndicator()
        : const CircularProgressIndicator(),
  );
}
