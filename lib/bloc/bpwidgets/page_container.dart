import 'dart:convert';

import 'package:dashboard/appdata/forms/bpwidget_forms.dart';
import 'package:dashboard/appdata/page/action_icons.dart';
import 'package:dashboard/appdata/page/bpappbar.dart';
import 'package:dashboard/appdata/page/bppage_schema.dart';
import 'package:dashboard/appdata/page/page_global_constants.dart';
import 'package:dashboard/appstyles/global_colors.dart';
import 'package:dashboard/appstyles/global_styles.dart';
import 'package:dashboard/bloc/bpwidgetaction/model/action/bpwidget_action.dart';
import 'package:dashboard/bloc/bpwidgetaction/model/dataprovider/navigation_task_param.dart';
import 'package:dashboard/bloc/bpwidgetaction/model/jobs/bpwidget_job.dart';
import 'package:dashboard/bloc/bpwidgetaction/model/tasks/navigation_task.dart';
import 'package:dashboard/types/bpwidget_types.dart';
import 'package:dashboard/utils/math_utils.dart';
import 'package:dashboard/widgets/custom_alert_box.dart';
import 'package:dashboard/widgets/customcontrols/key_value_reactive_dropdown.dart';
import 'package:dashboard/widgets/customcontrols/key_value_reactive_textbox.dart';
import 'package:dashboard/widgets/customcontrols/key_value_textbox.dart';
import 'package:dashboard/widgets/rightpanels/panel_header.dart';
import 'package:dashboard/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reactive_forms/reactive_forms.dart';

class PageContainer extends StatefulWidget {
  final double width;
  final List<BpPagesSchema>? bpPageSchema;
  final BPPageController bpPageController;
  final Function(BpPagesSchema pageSchema) onPageDetailsSaved;
  final Function(BpPagesSchema? updatedPageID)? onPageClicked;
  final BpPagesSchema? newPageData;

  const   PageContainer({
    super.key,
    required this.width,
    required this.bpPageController,
    required this.onPageDetailsSaved,
    this.bpPageSchema,
   this.onPageClicked,
   this.newPageData,
  });

  @override
  State<PageContainer> createState() => _PageContainerState();
}

class _PageContainerState extends State<PageContainer> {
 int? selectedIndex;
  bool searchOpt = false;
  String searchText = "";
  bool showIcon = false;
  late final FormGroup bpPageConfigurationFrom;
  Map<String, dynamic>? pageProps;
  Map<String, Widget>? actionIcons;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bpPageConfigurationFrom = BpwidgetForms.get_pageConfiguration_form();
    actionIcons = ActionIcons.getActionIcons();
    print("widget.bpPageSchema----------->${widget.bpPageSchema}");
    
  }

  BpPagesSchema? getBpPageSchemaByPageId(List<BpPagesSchema> data,String targetPageId,) {
    for (final item in data) {
      if (item.pageId == targetPageId) {
        return item;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 3,
        color: Colors.white,
        child: Column(
          children: [
            searchOpt == false
                ? Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                        child: PanelHeader(
                          panelWidth: widget.width,
                          title: 'Page List',
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            searchOpt = true;
                          });
                        },
                        icon: Icon(Icons.search),
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ReactiveForm(
                                formGroup: bpPageConfigurationFrom,
                                child: CustomAlertBox(
                                  title: "Fill Page Details",
                                  widgets: [
                                    SizedBox(
                                      child: KeyValueReactiveTextbox(
                                        width: 400,
                                        labeltext: "Page Title",
                                        formControlName: "title",
                                        // onChange: (control) => {
                                        //   page.pageName= control.value != null ? control.value : '';
                                        // },
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    SizedBox(
                                      child: KeyValueReactiveDropdown(
                                        width: 400,
                                        labeltext: "Action Button Icon",
                                        dropdownEntries:
                                            ActionIcons.getActionIcons(),
                                        formControlName: 'actionButton',
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    SizedBox(
                                      child: KeyValueReactiveDropdown(
                                        width: 400,
                                        labeltext: 'Action',
                                        dropdownEntries: [
                                          Job.go.name,
                                          Job.gowithdata.name,
                                          Job.saveandgo.name,
                                        ],
                                        formControlName: 'action',
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    SizedBox(
                                      child: KeyValueReactiveDropdown(
                                        width: 400,
                                        labeltext: 'GoTo',
                                        dropdownEntries: [
                                          'Home',
                                          'Dashboard',
                                          'Inbox',
                                          'NewLead',
                                        ],
                                        formControlName: 'pageUrl',
                                      ),
                                    ),
                                  ],
                                  buttons: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Cancel"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          String pageName =
                                              bpPageConfigurationFrom
                                                  .control('title')
                                                  .value
                                                  .trim()
                                                  .toLowerCase()
                                                  .replaceAll(' ', '_') ??
                                              '';
                                          final BPPageController newPage =
                                              BPPageController.createNewPage(
                                                pageName,
                                                null
                                              );
                                               widget.bpPageController.pagesRegistry
                                              .addEntries(
                                                newPage.pagesRegistry.entries,
                                              );
                                              final page = widget.bpPageController.pagesRegistry.entries.last;
                                              print("new page Id------------>${page.value.pageId}");
                                              print("new page name------------>${page.value.pageName}");
                                              
                                               final pageTitle =
                                                        bpPageConfigurationFrom
                                                                .controls['title']!
                                                                .value
                                                            as String;
                                                    final actionIcon =
                                                        bpPageConfigurationFrom
                                                                .controls['actionButton']!
                                                                .value
                                                            as String;
                                                    final eventName = "onClick";
                                                    final actionName =
                                                        bpPageConfigurationFrom
                                                                .controls['action']!
                                                                .value
                                                            as String;
                                                    final pageUrl =
                                                        bpPageConfigurationFrom
                                                                .controls['pageUrl']!
                                                                .value
                                                            as String;
                                                    final id =
                                                        MathUtils.generateUniqueID();

                                                    final taskDataProvider =
                                                        NavigationTaskDataProvider(
                                                          url: pageUrl,
                                                        );

                                                    final tasks = [
                                                      NavigationTask(
                                                        id:
                                                            MathUtils.generateUniqueID(),
                                                        name:
                                                            Task.checkUrl.name,
                                                      ),
                                                      NavigationTask(
                                                        id:
                                                            MathUtils.generateUniqueID(),
                                                        name:
                                                            Task
                                                                .navigation
                                                                .name,
                                                      ),
                                                    ];
                                                    final job = BPwidgetJob(
                                                      type:
                                                          BPActionJobTypes
                                                              .Navigation
                                                              .name,
                                                      id: id,
                                                      name: actionName,
                                                      taskDataprovider:
                                                          taskDataProvider,
                                                      tasks: tasks,
                                                    );

                                                    final actionObj =
                                                        BpwidgetAction(
                                                          name: eventName,
                                                          id: id,
                                                          job: job,
                                                        );

                                                    final appBar =
                                                        BPAppBarConfig(
                                                          title: pageTitle,
                                                          actionButton: [
                                                            {
                                                              'name':
                                                                  actionIcon,
                                                              'action':
                                                                  actionObj,
                                                            },
                                                          ],
                                                        );
                                                    final bpPagesSchema =
                                                        BpPagesSchema(
                                                          pageId:page.value.pageId,
                                                          pageName:
                                                              page.value.pageName,
                                                          appBar: appBar,
                                                        );
                                                    widget.onPageDetailsSaved(
                                                      bpPagesSchema,
                                                    );
                                        
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: Text("Save"),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                )
                : SearchBarWidget(
                  hintText: "Search Pages...",
                  onChanged: (value) {},
                  onPressed: (isCleared) {
                    setState(() {
                      searchOpt = false;
                    });
                  },
                ),

            Expanded(
              child: ListView.builder(
                itemCount: widget.bpPageController.pagesRegistry.entries.length,
                itemBuilder: (context, index) {
                  final page =
                      widget.bpPageController.pagesRegistry.entries
                          .elementAt(index)
                          .value;
                  print("page ${page}");
                  return ListTile(
                    selected: selectedIndex == index,
                    title: Text(page.pageName),
                    onTap: () {
                      
                      final pageObject = getBpPageSchemaByPageId(
                        widget.bpPageSchema!,
                        page.pageId,
                      );
                      if (pageObject != null) {
                        widget.onPageClicked!(pageObject);
                      }else{
                        widget.onPageClicked!(null);
                      }
                      setState(() {
                        showIcon = true;
                        selectedIndex=index;
                      });
                      
                    },
                    selectedTileColor: GlobalColors.navIndicatorColor,
                    trailing:
                        showIcon
                            ? IconButton(
                              onPressed:
                                  () => {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ReactiveForm(
                                          formGroup: bpPageConfigurationFrom,
                                          child: CustomAlertBox(
                                            title: "Fill Page Details",
                                            widgets: [
                                              SizedBox(
                                                child: KeyValueReactiveTextbox(
                                                  width: 400,
                                                  labeltext: "Page Title",
                                                  formControlName: "title",
                                                  // onChange: (control) => {
                                                  //   page.pageName= control.value != null ? control.value : '';
                                                  // },
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              SizedBox(
                                                child: KeyValueReactiveDropdown(
                                                  width: 400,
                                                  labeltext:
                                                      "Action Button Icon",
                                                  dropdownEntries:
                                                      ActionIcons.getActionIcons(),
                                                  formControlName:
                                                      'actionButton',
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              SizedBox(
                                                child: KeyValueReactiveDropdown(
                                                  width: 400,
                                                  labeltext: 'Action',
                                                  dropdownEntries: [
                                                    Job.go.name,
                                                    Job.gowithdata.name,
                                                    Job.saveandgo.name,
                                                  ],
                                                  formControlName: 'action',
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              SizedBox(
                                                child: KeyValueReactiveDropdown(
                                                  width: 400,
                                                  labeltext: 'GoTo',
                                                  dropdownEntries: [
                                                    'Home',
                                                    'Dashboard',
                                                    'Inbox',
                                                    'NewLead',
                                                  ],
                                                  formControlName: 'pageUrl',
                                                ),
                                              ),
                                            ],
                                            buttons: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Cancel"),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    String pageName =
                                                        bpPageConfigurationFrom
                                                            .control('title')
                                                            .value
                                                            .trim()
                                                            .toLowerCase()
                                                            .replaceAll(
                                                              ' ',
                                                              '_',
                                                            ) ??
                                                        '';
                                                    page.pageName = pageName;
                                                    final pageTitle =
                                                        bpPageConfigurationFrom
                                                                .controls['title']!
                                                                .value
                                                            as String;
                                                    final actionIcon =
                                                        bpPageConfigurationFrom
                                                                .controls['actionButton']!
                                                                .value
                                                            as String;
                                                    final eventName = "onClick";
                                                    final actionName =
                                                        bpPageConfigurationFrom
                                                                .controls['action']!
                                                                .value
                                                            as String;
                                                    final pageUrl =
                                                        bpPageConfigurationFrom
                                                                .controls['pageUrl']!
                                                                .value
                                                            as String;
                                                    final id =
                                                        MathUtils.generateUniqueID();

                                                    final taskDataProvider =
                                                        NavigationTaskDataProvider(
                                                          url: pageUrl,
                                                        );

                                                    final tasks = [
                                                      NavigationTask(
                                                        id:
                                                            MathUtils.generateUniqueID(),
                                                        name:
                                                            Task.checkUrl.name,
                                                      ),
                                                      NavigationTask(
                                                        id:
                                                            MathUtils.generateUniqueID(),
                                                        name:
                                                            Task
                                                                .navigation
                                                                .name,
                                                      ),
                                                    ];
                                                    final job = BPwidgetJob(
                                                      type:
                                                          BPActionJobTypes
                                                              .Navigation
                                                              .name,
                                                      id: id,
                                                      name: actionName,
                                                      taskDataprovider:
                                                          taskDataProvider,
                                                      tasks: tasks,
                                                    );

                                                    final actionObj =
                                                        BpwidgetAction(
                                                          name: eventName,
                                                          id: id,
                                                          job: job,
                                                        );

                                                    final appBar =
                                                        BPAppBarConfig(
                                                          title: pageTitle,
                                                          actionButton: [
                                                            {
                                                              'name':
                                                                  actionIcon,
                                                              'action':
                                                                  actionObj,
                                                            },
                                                          ],
                                                        );
                                                    final bpPagesSchema =
                                                        BpPagesSchema(
                                                          pageId: page.pageId,
                                                          pageName:
                                                              page.pageName,
                                                          appBar: appBar,
                                                        );
                                                    widget.onPageDetailsSaved(
                                                      bpPagesSchema,
                                                    );
                                                    Navigator.pop(context);
                                                  });
                                                },
                                                child: Text("Save"),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  },
                              icon: GlobalStyles.editIcon,
                            )
                            : null,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
