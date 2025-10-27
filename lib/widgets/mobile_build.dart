import 'package:dashboard/api_call/json_server_api_call.dart';
import 'package:dashboard/bloc/bpwidgets/model/bpwidget.dart';
import 'package:dashboard/pages/dynamic_form_builder.dart';
import 'package:flutter/material.dart';

class MobileBuild extends StatefulWidget{
  const MobileBuild({super.key});

  @override
  State<MobileBuild> createState() => MobileBuildState();
}

class MobileBuildState extends State<MobileBuild> {
  List<BPWidget>? widgetSchema;

  @override
  void initState() {
    super.initState();
    getBPWidgetFromAPI();
  }

  Future<List<BPWidget>?> getBPWidgetFromAPI() async {
    try {
      List<BPWidget>? getData = await JsonServerApiCall().getBPWidget();
      setState(() {
        widgetSchema = getData;
      });
      return widgetSchema;
    } catch(error) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widgetSchema != null ? DynamicForm(widgetSchema: widgetSchema!) : SizedBox(child: Text('Loading Widget'),);
  }
}