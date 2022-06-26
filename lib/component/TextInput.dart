
import 'package:flutter/material.dart';
import 'package:pizza/Styles.dart';

import '../Config.dart';

class TextInput extends StatefulWidget {
  const TextInput({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      cursorColor: Config.textColor,
      cursorWidth: 1,
      decoration: InputDecoration(
        isDense: true,
        labelStyle: Styles.textLabelStyle,
        contentPadding: EdgeInsets.symmetric(
          vertical: Config.mediumPadding / 4,
          horizontal: Config.mediumPadding / 2,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Config.textColor,),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Config.titleColor,),
        ),
        // suffixIconConstraints: BoxConstraints(maxHeight: 14, maxWidth: 14),
        suffix: InkWell(
          child: const Icon(Icons.close, color: Config.textColor, size: 16,),
          onTap: () {
            widget.controller.clear();
          },
        ),
      ),
    );
  }
}
