import 'package:dashboard/appdata/page/bpappbar.dart';
import 'package:dashboard/bloc/bpwidgets/model/bpwidget.dart';
import 'package:dashboard/bloc/bpwidgets/model/bpwidget_schema.dart';

class BpPagesSchema {
  final String? pageId;
  final String? pageName;
  final BPAppBarConfig? appBar;
  final BpwidgetSchema? bpWidgetList;
  BpPagesSchema({this.pageId,this.pageName,this.appBar,this.bpWidgetList});

factory BpPagesSchema.fromJson(Map<String,dynamic> json){
  return BpPagesSchema(
    pageId: json['pageId'],
    pageName: json['pageName'],
    appBar: json['appBar']!=null ? BPAppBarConfig.fromJson(json['appBar']):null,
    bpWidgetList: json['bpWidgetList']!=null ? BpwidgetSchema.fromJson(json['bpWidgetList']):null,
  );
}

  Map<String, dynamic> toJson(){
    return {
      'BpPagesSchema':[{
        'pageId':pageId,
        'pageName':pageName,
        'appBar':appBar,
        'bpWidgetList': bpWidgetList
      }]
    };
  }
}
