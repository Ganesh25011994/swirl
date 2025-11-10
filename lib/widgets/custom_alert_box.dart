import 'package:flutter/material.dart';

class CustomAlertBox extends StatefulWidget {
  final List<Widget>? widgets;
  final String? title;
  final String? content;
  final List<Widget> buttons;

  const CustomAlertBox({
    super.key,
    this.widgets,
    this.title,
    this.content,
    required this.buttons,
  });

  @override
  State<CustomAlertBox> createState() => _CustomAlertBoxState();
}

class _CustomAlertBoxState extends State<CustomAlertBox> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("${widget.title}"),
      content: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 600),
        child: SingleChildScrollView(child: Column(
          children: widget.widgets??[],
        )),
      ),
      actions: widget.buttons,
    );
  }
}
