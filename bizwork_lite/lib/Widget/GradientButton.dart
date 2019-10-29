import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GradientButton extends StatefulWidget {
  const GradientButton({
    this.labelText,
    this.onPressed,
    this.colorLabelText,
    this.fontSizeLabelText,
    this.backroundColor,
    this.widthSize,
    this.heightSize,
    this.cornerRadius,
  });

  final String labelText;
  final Color colorLabelText;
  final double fontSizeLabelText;
  final VoidCallback onPressed;
  final List<Color> backroundColor;
  final double widthSize;
  final double heightSize;
  final double cornerRadius;

  @override
  _GradientButtonState createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: widget.onPressed,
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(widget.cornerRadius),
      ),
      child: Container(
        width: widget.widthSize,
        height: widget.heightSize,
        decoration: new BoxDecoration(
          gradient: LinearGradient(
            colors: widget.backroundColor,
          ),
        ),
        child: new Center(
          child: new Text(
            widget.labelText,
            style: new TextStyle(
                fontSize: widget.fontSizeLabelText,
                color: widget.colorLabelText),
          ),
        ),
      ),
    );
  }
}
