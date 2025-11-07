import 'dart:convert';

class BPAppBarConfig {
  final String title;
  final List<Map<String, dynamic>> actionButton;

  BPAppBarConfig({required this.title, required this.actionButton});

  factory BPAppBarConfig.fromJson(Map<String,dynamic> json){

     final rawButtons = json['actionButton'] ?? json['actionBUtton'];

    // Safely convert to List<Map<String, dynamic>>
    List<Map<String, dynamic>> parsedButtons = [];

    if (rawButtons is List) {
      parsedButtons = rawButtons
          .where((e) => e is Map) // filter non-map items
          .map((e) => Map<String, dynamic>.from(e as Map))
          .toList();
    }
    return BPAppBarConfig(
      title: json['title'],
      actionButton:parsedButtons,
      );
  }

  Map<String, dynamic> toJson() {
    return {
       'title': title, 'actionButton': actionButton
    };
  }
}
