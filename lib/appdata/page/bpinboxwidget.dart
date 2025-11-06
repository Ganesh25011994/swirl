// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:dashboard/bloc/bpinbox/model/bpwiddgetinboxprops.dart';

class BPInboxWidget {
  final BPWidgetInboxProps bpInboxProps;
  final String id;
  final Map<String,dynamic> responseJson;
  BPInboxWidget({
    required this.bpInboxProps,
    required this.id,
    required this.responseJson,
  });

  BPInboxWidget copyWith({
    BPWidgetInboxProps? bpInboxProps,
    String? id,
    Map<String,dynamic>? responseJson,
  }) {
    return BPInboxWidget(
      bpInboxProps: bpInboxProps ?? this.bpInboxProps,
      id: id ?? this.id,
      responseJson: responseJson ?? this.responseJson,
    );
  }

  factory BPInboxWidget.init() => BPInboxWidget(
    bpInboxProps: BPWidgetInboxProps( 
      title: '', 
      subtitle: '',
      key1: '',
      key2: '',
      key3: ''
    ),
    id: '',
    responseJson: {}
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'bpInboxProps': bpInboxProps.toMap(),
      'id': id,
      'responseJson': responseJson,
    };
  }

  factory BPInboxWidget.fromMap(Map<String, dynamic> map) {
    return BPInboxWidget(
      bpInboxProps: BPWidgetInboxProps.fromMap(map['bpInboxProps'] as Map<String,dynamic>),
      id: map['id'] as String,
      responseJson: Map<String,dynamic>.from((map['responseJson'] as Map<String,dynamic>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory BPInboxWidget.fromJson(String source) => BPInboxWidget.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'BPInboxWidget(bpInboxProps: $bpInboxProps, id: $id, responseJson: $responseJson)';

  @override
  bool operator ==(covariant BPInboxWidget other) {
    if (identical(this, other)) return true;
  
    return 
      other.bpInboxProps == bpInboxProps &&
      other.id == id &&
      mapEquals(other.responseJson, responseJson);
  }

  @override
  int get hashCode => bpInboxProps.hashCode ^ id.hashCode ^ responseJson.hashCode;
}
