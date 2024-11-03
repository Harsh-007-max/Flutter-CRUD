import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    super.key,
    required this.controller,
    required this.name,
    this.leadIcon = Icons.verified_user_outlined,
    this.value = "",
    this.obsText = false,
    this.autoCorrect = true,
    this.enableSuggestions = true,
  });
  final dynamic controller, leadIcon;
  final String name, value;
  final bool obsText, enableSuggestions, autoCorrect;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (val) {
        if (val == null || val.isEmpty) {
          return "Please enter some text";
        } else {
          if (obsText &&
              !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                  .hasMatch(val)) {
            return "Please enter strong password";
          }
          null;
        }
        return null;
      },
      controller: controller,
      obscureText: obsText,
      autocorrect: autoCorrect,
      enableSuggestions: enableSuggestions,
      decoration: InputDecoration(
        labelText: name,
        prefixIcon: Icon(leadIcon),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
