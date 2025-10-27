import 'dart:io';
import 'package:dashboard/pages/split_screen.dart';
import 'package:dashboard/widgets/mobile_build.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation App',
      theme: ThemeData.light(),
      home: kIsWeb ? SplitScreen() : MobileBuild(), 
      // home: MobileBuild(),
      debugShowCheckedModeBanner: false,
    );
  }
}
