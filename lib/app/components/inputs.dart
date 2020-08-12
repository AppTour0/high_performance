import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum ConfirmAction { CANCEL, ACCEPT }

class CustomInput extends StatelessWidget {
  final TextEditingController editingController;
  final TextInputType inputType;
  final Function change;
  final String hintText;
  final String labelText;
  final Function validator;
  final maxLines;
  final Widget icon;
  final bool readOnly;
  final Function onTap;
  final Widget suffixIcon;
  final textCapitalization;
  final TextStyle hintStyle;
  final TextStyle labelStyle;
  final BorderSide borderSide;

  const CustomInput({
    Key key,
    @required this.editingController,
    @required this.inputType,
    this.change,
    @required this.hintText,
    @required this.labelText,
    this.validator,
    this.maxLines,
    this.icon,
    this.readOnly = false,
    this.onTap,
    this.suffixIcon,
    this.textCapitalization = TextCapitalization.none,
    this.hintStyle,
    this.labelStyle,
    this.borderSide = const BorderSide(color: Colors.black, width: 1),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
        child: TextFormField(
          controller: editingController,
          keyboardType: inputType,
          onChanged: change,
          maxLines: maxLines,
          readOnly: readOnly,
          textCapitalization: textCapitalization,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: hintStyle,
            labelText: labelText,
            labelStyle: labelStyle,
            icon: icon != null ? icon : null,
            suffixIcon: suffixIcon,
            focusedBorder: OutlineInputBorder(
              borderSide: borderSide,
            ),
            enabledBorder: OutlineInputBorder(
              //borderSide: BorderSide(color: Colors.teal, width: 1),
              borderSide: borderSide,
            ),
          ),
          validator: (val) {
            return validator(val);
          },
          onTap: onTap,
        ));
  }
}

class InputForm extends StatelessWidget {
  final TextEditingController editingController;
  final TextInputType inputType;
  final String hintText;
  final String labelText;
  final int maxLines;
  final formatter;
  final String validator;
  final int validatorCond;
  final String validatorText;

  InputForm({
    @required this.editingController,
    @required this.inputType,
    @required this.hintText,
    @required this.labelText,
    this.maxLines,
    this.formatter,
    this.validator,
    this.validatorCond,
    this.validatorText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: TextFormField(
        controller: editingController,
        keyboardType: inputType,
        maxLines: maxLines ?? maxLines,
        inputFormatters: [formatter],
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
        ),
        validator: (val) => val.length > 3 ? validatorText : null,
        onSaved: (val) => editingController.text = val,
      ),
    );
  }
}

class InputStreamNum extends StatelessWidget {
  final stream;
  final TextEditingController editingController;
  final TextInputType inputType;
  final change;
  final String hintText;
  final String labelText;
  final formater;
  final maxLength;

  InputStreamNum({
    @required this.stream,
    @required this.editingController,
    @required this.inputType,
    @required this.change,
    @required this.hintText,
    @required this.labelText,
    @required this.formater,
    @required this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: stream,
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: TextFormField(
              controller: formater,
              keyboardType: inputType,
              onChanged: change,
              maxLength: maxLength,
              /* inputFormatters: [
                  formater,
                ], */
              decoration: InputDecoration(
                hintText: hintText,
                labelText: labelText,
                errorText: snapshot.error,
              ),
            ),
          );
        });
  }
}
