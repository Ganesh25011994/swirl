import 'package:dashboard/appdata/page/bpappbar.dart';
import 'package:dashboard/appdata/page/bpinboxwidget.dart';
import 'package:dashboard/bloc/bpwidgets/model/bpwidget.dart';

class BpPagesSchema {
  final String pageId;
  final String pageName;
  final BPAppBarConfig appBar;
  final List<BPWidget>? bpWidgetList;
  final BPInboxWidget? bpInboxWidget;
  BpPagesSchema({required this.pageId,required this.pageName, required this.appBar, this.bpWidgetList, this.bpInboxWidget});

  Map<String, dynamic> toJson(){
    return {
      'BpPagesSchema':[{
        'pageId':pageId,
        'pageName':pageName,
        'appBar':appBar,
        'bpWidgetList': bpWidgetList,
        'bpInboxWidget': bpInboxWidget
      }]
    };
  }
}
