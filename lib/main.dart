import 'package:flutter/material.dart';
import 'package:online_api/dashboard.dart';
import 'package:online_api/view.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "dashboard":(context) => dashboard(),
        "view":(context) => view(),
        },
      initialRoute: "dashboard",
    )
  );
}
