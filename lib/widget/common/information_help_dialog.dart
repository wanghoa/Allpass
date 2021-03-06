import 'package:flutter/material.dart';

class InformationHelpDialog extends StatefulWidget {

  final Widget title;
  final List<Widget> content;
  final List<Widget> actions;

  InformationHelpDialog({
    this.title = const Text("帮助"),
    this.content,
    this.actions
  }) : assert (content != null);

  @override
  State createState() {
    return _InformationHelpDialog();
  }
}

class _InformationHelpDialog extends State<InformationHelpDialog> {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: widget.title,
      content: SingleChildScrollView(
          child: ListBody(
            children: widget.content
          )
      ),
      actions: widget.actions,
    );
  }
}