import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final bool isReadOnly;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final bool enabled;
  final String? Function(String?)? validator;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.controller,
    this.onChanged,
    this.onTap,
    this.isReadOnly = false,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.maxLines = 1,
    this.enabled = true,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: validator,
      builder: (FormFieldState<String> field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: onTap != null && isReadOnly ? onTap : null,
              child: AbsorbPointer(
                absorbing: isReadOnly,
                child: TextField(
                  controller: controller,
                  readOnly: isReadOnly,
                  keyboardType: keyboardType,
                  inputFormatters: inputFormatters,
                  maxLines: maxLines,
                  enabled: enabled,
                  decoration: InputDecoration(
                    labelText: label,
                    border: const OutlineInputBorder(),
                    errorText: field.errorText,
                  ),
                  onChanged: (value) {
                    field.didChange(value);
                    if (onChanged != null) {
                      onChanged!(value);
                    }
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}


class CustomPasswordTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final bool isReadOnly;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final bool enabled;
  final String? Function(String?)? validator;

  const CustomPasswordTextField({
    Key? key,
    required this.label,
    required this.controller,
    this.onChanged,
    this.onTap,
    this.isReadOnly = false,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.maxLines = 1,
    this.enabled = true,
    this.validator,
  }) : super(key: key);

  @override
  _CustomPasswordTextFieldState createState() =>
      _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  bool isHide = true;

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: widget.validator,
      builder: (FormFieldState<String> field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: widget.controller,
              obscureText: isHide,
              readOnly: widget.isReadOnly,
              keyboardType: widget.keyboardType,
              inputFormatters: widget.inputFormatters,
              maxLines: widget.maxLines,
              enabled: widget.enabled,
              decoration: InputDecoration(
                labelText: widget.label,
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(isHide ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      isHide = !isHide;
                    });
                  },
                ),
                errorText: field.errorText,
              ),
              onChanged: (value) {
                field.didChange(value);
                if (widget.onChanged != null) {
                  widget.onChanged!(value);
                }
              },
            ),
          ],
        );
      },
    );
  }
}


class TextfieldPassword extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final bool isReadOnly;  // renamed from readOnly to isReadOnly
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final bool enabled;

  const TextfieldPassword({
    Key? key,
    required this.label,
    required this.controller,
    this.onChanged,
    this.onTap,
    this.isReadOnly = false,  // default is false for editable text field
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.maxLines = 1,
    this.enabled = true,
  }) : super(key: key);

  @override
  _TextFieldPasswordState createState() => _TextFieldPasswordState();
}

class _TextFieldPasswordState extends State<TextfieldPassword> {
  bool isHide = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: TextField(
        obscureText: isHide,
        controller: widget.controller,
        readOnly: widget.isReadOnly,  // makes the text field read-only
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
        maxLines: widget.maxLines,
        enabled: widget.enabled,
        decoration: InputDecoration(
          labelText: widget.label,
          border: OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: Icon(isHide ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                isHide = !isHide;
              });
            },
          ),
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}
