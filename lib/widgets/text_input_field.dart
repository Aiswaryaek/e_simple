// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../styles/colors.dart';
import '../styles/text_style.dart';

  TextField buildTextFormField(StateSetter setState, String _labelText,
      String _hintText, String _errorText, bool _isObscure,TextEditingController _controller){

    String labelText = "";
    return TextField(
      controller: _controller,
      style: textFieldInputStyle,
      cursorColor: grayColor,
      obscureText: _isObscure,
      onChanged: (v) {
        setState(() {
          _labelText = v.isNotEmpty ? labelText : "";
        });
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(0),
        isDense: true,
        errorText: _controller.text == '' ? _errorText : '',
        labelText: _labelText,
        labelStyle: labelTextStyle,
        hintText: _hintText,
        hintStyle: placeholderTextStyle,
        fillColor: blackColor,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: buildTextFormColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: buildTextFormColor, width: 1),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: buildTextFormColor, width: 1),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: buildTextFormColor, width: 1),
        ),
      ),
    );
  }

