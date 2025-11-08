import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
/*
  @author   :   karthick.d  13/10/2025
  @desc     :   configure action for formcontrol events which conprises of 
                actionid , and BPwidgetJob object

*/
import 'package:dashboard/bloc/bpwidgetaction/model/dataprovider/bpwidget_tasks_dataprovider.dart';
import 'package:dashboard/bloc/bpwidgetaction/model/jobs/bpwidget_job.dart';
import 'package:dashboard/bloc/bpwidgetaction/model/tasks/bpwidget_task.dart';

class BpwidgetAction {
  final String id;
  final String name;
  final BPwidgetJob? job;
  BpwidgetAction({required this.id, required this.name, required this.job});

  factory BpwidgetAction.initWithId({required String id}) => BpwidgetAction(
    id: id, 
    job: BPwidgetJob(
      type: '',
      id: id,
      name: '',
      taskDataprovider: BPTaskDataprovider(url: ''),
      tasks: <BPwidgetTask>[],
    ),
    name: '',
  );

  @override
  String toString() => 'BpwidgetAction(id: $id, name: $name, job: $job)';

  BpwidgetAction copyWith({String? id, String? name, BPwidgetJob? job}) {
    return BpwidgetAction(
      id: id ?? this.id,
      name: name ?? this.name,
      job: job ?? this.job,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'name': name, 'job': job!.toMap()};
  }

  factory BpwidgetAction.fromMap(Map<String, dynamic> map) {
    return BpwidgetAction(
      id: map['id'] as String,
      name: map['name'] as String,
      job: BPwidgetJob.fromMap(map['job'] as Map<String, dynamic>),
    );
  }

  // Map<String, dynamic> toJson() => toMap();
  String toJson() => json.encode(toMap());

  factory BpwidgetAction.fromJson(String source) =>
      BpwidgetAction.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant BpwidgetAction other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.job == job;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ job.hashCode;
}
