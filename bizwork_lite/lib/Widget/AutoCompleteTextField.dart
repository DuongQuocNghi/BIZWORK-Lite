import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class AutoCompleteTextField<T> extends StatefulWidget {
  const AutoCompleteTextField({
    this.labelText,
    this.controller,
    this.suggestionsCallback,
    this.itemBuilder,
    this.transitionBuilder,
    this.onSuggestionSelected,
  });

  final String labelText;
  final TextEditingController controller;
  final SuggestionsCallback<T> suggestionsCallback;
  final ItemBuilder<T> itemBuilder;
  final AnimationTransitionBuilder transitionBuilder;
  final SuggestionSelectionCallback<T> onSuggestionSelected;

  @override
  _AutoCompleteTextFieldState createState() => _AutoCompleteTextFieldState();
}

class _AutoCompleteTextFieldState extends State<AutoCompleteTextField> {
  FocusNode _focusNodeTextField = new FocusNode();
  Icon _iconWidget = Icon(null);
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  set iconWidget(Icon value) {
    setState(() {
      print(value);
      _iconWidget = value;
    });
  }

  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(_textChange);
    _focusNodeTextField.addListener(() {
      updateIconClear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: null,
      child: TypeAheadFormField(
          hideOnLoading: true,
          hideOnEmpty: true,
          hideOnError: true,
          getImmediateSuggestions: true,
          textFieldConfiguration: TextFieldConfiguration(
              focusNode: _focusNodeTextField,
              controller: widget.controller,
              decoration: InputDecoration(
                labelText: widget.labelText,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      Future.delayed(Duration.zero).then((_) {
                        widget.controller.clear();
                      });
                    });
                  },
                  child: _iconWidget,
                ),
              )),
          suggestionsCallback: widget.suggestionsCallback,
          itemBuilder: widget.itemBuilder,
          transitionBuilder: widget.transitionBuilder,
          onSuggestionSelected: widget.onSuggestionSelected),
    );
  }

  void _textChange() {
    updateIconClear();
  }

  updateIconClear() {
    try {
      if (_focusNodeTextField.hasFocus) {
        iconWidget = Icon(
          widget.controller.text.isEmpty ? null : Icons.clear,
        );
      } else {
        iconWidget = Icon(null);
      }
    } catch (ex) {
      print(ex);
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller?.removeListener(_textChange);
  }
}
