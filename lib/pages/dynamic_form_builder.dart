import 'package:dashboard/bloc/bpwidgetaction/model/action/bpwidget_action.dart';
import 'package:dashboard/bloc/bpwidgetaction/model/dataprovider/bpwidget_tasks_dataprovider.dart';
import 'package:dashboard/bloc/bpwidgetaction/model/jobs/bpwidget_job.dart';
import 'package:dashboard/bloc/bpwidgets/model/bpwidget.dart';
import 'package:dashboard/bloc/bpwidgets/model/bpwidget_schema.dart';
import 'package:dashboard/pages/dashboard_page.dart';
import 'package:dashboard/types/drag_drop_types.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'dart:convert';

class DynamicForm extends StatelessWidget {
  final List<BPWidget> widgetSchema;

  const DynamicForm({Key? key, required this.widgetSchema}) : super(key: key);

  FormGroup buildFormGroup(List<BPWidget> widgets) {
    final controls = <String, AbstractControl<dynamic>>{};

    for (var widget in widgets) {
      if (widget.widgetType == PlaceholderWidgets.Textfield) {
        controls[widget.bpwidgetProps!.controlName] = FormControl<String>(
          validators: [
            if (widget.bpwidgetProps!.isRequired == 'true') Validators.required,
            if (widget.bpwidgetProps!.max != null)
              Validators.maxLength(int.parse(widget.bpwidgetProps!.max!)),
          ],
        );
      } else if (widget.widgetType == PlaceholderWidgets.Dropdown) {
        controls[widget.bpwidgetProps!.controlName] = FormControl<String>(
          validators: [
            if (widget.bpwidgetProps!.isRequired == 'true') Validators.required,
          ],
        );
      }
    }

    return FormGroup(controls);
  }

  List<Widget> buildFormWidgets(List<BPWidget> widgets) {
    return widgets.map((widget) {
      if (widget.widgetType == PlaceholderWidgets.Textfield) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ReactiveTextField(
            formControlName: widget.bpwidgetProps!.controlName,
            decoration: InputDecoration(
              labelText: widget.bpwidgetProps!.label,
              border: const OutlineInputBorder(),
            ),
            validationMessages: {
              ValidationMessage.required:
                  (_) => '${widget.bpwidgetProps!.label} is required',
              ValidationMessage.maxLength:
                  (_) => 'Maximum length is ${widget.bpwidgetProps!.max}',
            },
          ),
        );
      } else if (widget.widgetType == PlaceholderWidgets.Dropdown) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ReactiveDropdownField<String>(
            formControlName: widget.bpwidgetProps!.controlName,
            decoration: InputDecoration(
              labelText: widget.bpwidgetProps!.label,
              border: const OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: 'male', child: Text('Male')),
              DropdownMenuItem(value: 'female', child: Text('Female')),
              DropdownMenuItem(value: 'other', child: Text('Other')),
            ],
            validationMessages: {
              ValidationMessage.required:
                  (_) => '${widget.bpwidgetProps!.label} is required',
            },
          ),
        );
      } else if (widget.widgetType == PlaceholderWidgets.Button) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ReactiveFormConsumer(
            builder: (context, form, child) {
              return ElevatedButton(
                onPressed: () {
                  print("elevated button clicked");
                  if (form.valid ) {
                    final action = widget.bpwidgetAction?.firstWhere(
                      (action) => action.name == 'onclick',
                      orElse: () => BpwidgetAction(
                                  id: '',
                                  name: '',
                                  job: BPwidgetJob(
                                    type: '',
                                    id: '',
                                    name: '',
                                    taskDataprovider: BPTaskDataprovider(
                                      url: '',
                                    ),
                                    tasks: [],
                                  ),
                                ),
                    );
                    if (action?.job!.type == 'Navigation') {
                      // Placeholder for navigation logic
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Navigating to ${action?.job?.taskDataprovider.url}',
                          ),
                        ),
                      );
                      if (action?.job!.taskDataprovider.url
                              .toLowerCase() ==
                          'dashboard') {
                            Navigator.pushNamed(context, '/second');
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     // builder: (context) => DevicePreview(
                        //       builder:  (context) =>
                        //         // MaterialApp(
                        //         //   useInheritedMediaQuery: true,
                        //         //   locale: DevicePreview.locale(context),
                        //         //   builder: DevicePreview.appBuilder,
                        //         //   theme: ThemeData.light(),
                        //         //   darkTheme: ThemeData.dark(),
                        //           // home: 
                        //           DashboardPage(),
                        //         // )
                        //     // ),
                        //   ),
                        // );
                      }
                    }
                  } else {
                    form.markAllAsTouched();
                  }
                },
                child: Text(widget.bpwidgetProps!.label),
              );
            },
          ),
        );
      }
      return const SizedBox.shrink();
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // final schema = BpwidgetSchema.fromJson(jsonSchema);
    final widgets = widgetSchema;
    final formGroup = buildFormGroup(widgets);

    return Scaffold(
      appBar: AppBar(title: Text('HomePage')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ReactiveForm(
            formGroup: formGroup,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                // child: Container(
                //   width: 300,
                //   height: 800,
                //   decoration: BoxDecoration(
                //     border: Border.all(
                //       color: Colors.black,
                //       width: 5,
                //       style: BorderStyle.solid,
                //     ),
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...buildFormWidgets(widgets),
                        const SizedBox(height: 16),
                        // ReactiveFormConsumer(
                        //   builder: (context, form, child) {
                        //     return ElevatedButton(
                        //       onPressed: form.valid ? () {} : null,
                        //       child: const Text('Submit'),
                        //     );
                        //   },
                        // ),
                      ],
                    ),
                  ),
                // ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
