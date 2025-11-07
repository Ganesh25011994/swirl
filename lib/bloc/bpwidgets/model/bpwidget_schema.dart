// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:dashboard/bloc/bpwidgets/model/bpwidget.dart';

class BpwidgetSchema {
  final List<BPWidget> schema;
  BpwidgetSchema({required this.schema});

  BpwidgetSchema copyWith({List<BPWidget>? schema}) {
    return BpwidgetSchema(schema: schema ?? this.schema);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'schema': schema.map((x) => x.toMap()).toList()};
  }

  factory BpwidgetSchema.fromMap(Map<String, dynamic> map, inbox) {
    return BpwidgetSchema(
      schema: List<BPWidget>.from(
        (map['schema'] as List<dynamic>).map<BPWidget>(
          (x) => BPWidget.fromMap(x as Map<String, dynamic>, inbox),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory BpwidgetSchema.fromJson(String source, inbox) =>
      BpwidgetSchema.fromMap(json.decode(source) as Map<String, dynamic>, inbox);

  @override
  String toString() => 'BpwidgetSchema(schema: $schema)';

  @override
  bool operator ==(covariant BpwidgetSchema other) {
    if (identical(this, other)) return true;

    return listEquals(other.schema, schema);
  }

  @override
  int get hashCode => schema.hashCode;
}
