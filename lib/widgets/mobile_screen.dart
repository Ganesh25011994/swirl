/*
  @author   : ganeshkumar.b  15/10/2025
  @desc     : Mobile Screen Widget used to render Application preview 
              in Device Preview for user to get Mobile Expereince
*/

import 'package:dashboard/pages/dashboard_page.dart';
import 'package:dashboard/pages/dynamic_form_builder.dart';
import 'package:dashboard/pages/inbox_page_builder.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dashboard/bloc/bpwidgets/model/bpwidget.dart';
import 'package:device_preview/device_preview.dart';

class MobileScreen extends StatefulWidget {
  final List<BPWidget> pageData;
  const MobileScreen({super.key, required this.pageData});

  @override
  State<MobileScreen> createState() => MobileScreenState();
}

class MobileScreenState extends State<MobileScreen> {

  List<BPWidget> pageRenderData = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      pageRenderData = widget.pageData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DevicePreview(
      // enabled: !kReleaseMode,
      builder: (context) => MaterialApp(
        useInheritedMediaQuery: true, // Required for DevicePreview
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        title: 'Device Preview Navigation Demo',
        home: DynamicForm(widgetSchema: pageRenderData),
        // home: InboxPageBuilder(widgetSchema: pageRenderData),
        routes: {
          '/second': (context) => const DashboardPage(),
        },
      )
    );
  }
  
}