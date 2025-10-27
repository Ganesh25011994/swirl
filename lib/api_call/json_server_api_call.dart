import 'dart:convert';

import 'package:dashboard/bloc/bpwidgets/model/bpwidget.dart';
import 'package:http/http.dart' as http;

class JsonServerApiCall {
  static const String baseUrl = 'http://172.30.1.116:3000/data';

  // POST: Save a new item
  Future<bool> saveBPWidget(jsonData) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonData,
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      throw Exception('Failed to create item: $error');
    }
  }

  // GET: Fetch all items
  Future<List<BPWidget>?> getBPWidget() async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        List<BPWidget> bpWidgetList = jsonList.map((e) => BPWidget.fromMap(e as Map<String, dynamic>)).toList();
        return bpWidgetList;
      } else {
        return null;
      }
    } catch (error) {
      throw Exception('Failed to create item: $error');
    }
    
  }
}