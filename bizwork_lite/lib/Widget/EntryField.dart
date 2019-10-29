import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EntryField extends StatefulWidget {
  const EntryField({
    this.fieldKey,
    this.hintText,
    this.labelText,
    this.helperText,
    this.controller,
  });

  final Key fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final TextEditingController controller;

  @override
  _EntryFieldState createState() => _EntryFieldState();
}

class _EntryFieldState extends State<EntryField> {

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: widget.fieldKey,
      controller:  widget.controller,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        filled: false,
        hintText: widget.hintText,
        labelText: widget.labelText,
        helperText: widget.helperText,
      ),
    );
  }
}
