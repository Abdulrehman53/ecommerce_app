import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/constants_colors.dart';
import 'component_text_widgets.dart';
class FormFieldComponent extends StatefulWidget {
  String? hint;
  IconData? iconField;
  IconData? suffixIcon;
  void Function(String)? onChange;
  String? Function(String?)? validator;
  void Function(String?)? onSaved;
  void Function()? onPasswordPressed;
  bool? isObscure = false;
  void Function(String)? onSubmitted;
  TextInputType? keyboardType = TextInputType.text;
  TextEditingController? controller;
  bool? autoValidate = false;
  FormFieldComponent(
      {this.autoValidate,
      this.controller,
      this.hint,
      this.iconField,
      this.isObscure,
      this.keyboardType,
      this.onChange,
      this.onPasswordPressed,
      this.onSaved,
      this.onSubmitted,
      this.suffixIcon,
      this.validator,
      Key? key})
      : super(key: key);

  @override
  State<FormFieldComponent> createState() => _FormFieldComponentState();
}

class _FormFieldComponentState extends State<FormFieldComponent> {
  FocusNode _focusNode = new FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _requestFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          primaryColor: ConstantColor.primaryColor,
          hintColor: Colors.grey,
          primarySwatch: Colors.grey),
      child: TextFormField(
        onTap: _requestFocus,
        focusNode: _focusNode,
        style: TextStyle(fontSize: 16.0, color: Colors.black),
        controller: widget.controller,
        obscureText: widget.isObscure ?? false,
        autocorrect: false,
        enableSuggestions: true,
        autofocus: true,
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ConstantColor.primaryColor),
          ),
          enabled: true,
          suffixIcon: IconButton(
            icon: Icon(
              widget.suffixIcon,
              color: Colors.white,
              size: 20,
            ),
            onPressed: widget.onPasswordPressed,
          ),
          hintText: widget.hint,
          labelStyle: TextStyle(color: Colors.black, fontSize: 16.0),
          hintStyle: TextStyle(fontSize: 16.0),
        ),
        onChanged: widget.onChange,
        onFieldSubmitted: widget.onSubmitted,
        validator: widget.validator,
        onSaved: widget.onSaved,
        keyboardType: widget.keyboardType,
      ),
    );
  }
}

class ProfileFormFieldComponent extends StatefulWidget {
  String? hint;
  String? title;
  IconData? iconField;
  IconData? suffixIcon;
  void Function(String)? onChange;
  String? Function(String?)? validator;
  void Function(String?)? onSaved;
  void Function()? onPasswordPressed;
  bool? isObscure = false;
  void Function(String)? onSubmitted;
  TextInputType? keyboardType = TextInputType.text;
  TextEditingController? controller;
  bool? autoValidate = false;
  ProfileFormFieldComponent(
      {this.autoValidate,
      this.controller,
      this.hint,
      this.iconField,
      this.isObscure,
      this.keyboardType,
      this.onChange,
      this.onPasswordPressed,
      this.onSaved,
      this.onSubmitted,
      this.suffixIcon,
      this.validator,
      this.title,
      Key? key})
      : super(key: key);

  @override
  State<ProfileFormFieldComponent> createState() =>
      _ProfileFormFieldComponentState();
}

class _ProfileFormFieldComponentState extends State<ProfileFormFieldComponent> {
  FocusNode _focusNode = new FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _requestFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ComponentText.buildTextWidget(
            title: widget.title??'',
            color: ConstantColor.primaryColor,
            fontSize: 18),
        Container(
          height: 35,
          child: Theme(
            data: ThemeData(
                primaryColor: Colors.grey,
                hintColor: Colors.grey,
                primarySwatch: Colors.grey),
            child: TextFormField(
              initialValue: widget.hint ?? '',
              onTap: _requestFocus,
              focusNode: _focusNode,
              style:const TextStyle(fontSize: 16.0, color: Colors.grey),
              controller: widget.controller,
              obscureText: widget.isObscure ?? false,
              autocorrect: false,
              autofocus: true,
              
              decoration:const InputDecoration(
               
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabled: true,
                labelStyle: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              onChanged: widget.onChange,
              onFieldSubmitted: widget.onSubmitted,
              validator: widget.validator,
              onSaved: widget.onSaved,
              keyboardType: widget.keyboardType,
            ),
          ),
        ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }
}


  /* static Widget buildPhoneformField({
    String? hint,
    IconData? iconField,
    IconData? suffixIcon,
    void Function(String)? onChange,
    String? Function(String?)? validator,
    void Function(String?)? onSaved,
    void Function()? onPasswordPressed,
    isObscure = false,
    void Function(String)? onSubmitted,
    TextInputType keyboardType = TextInputType.text,
    TextEditingController? controller,
    bool autoValidate = false,
  }) {
    return Container(
      child: Theme(
        data: ThemeData(
          primaryColor: ConstantColor.APP_COLOR,
          hintColor: Colors.grey,
        ),
        child: TextFormField(
          inputFormatters: <TextInputFormatter>[
            LengthLimitingTextInputFormatter(12),
          ],
          obscureText: isObscure,
          decoration: InputDecoration(
            prefixIcon: Icon(
              iconField,
              color: ConstantColor.APP_COLOR,
            ),
            hintText: hint,
            labelStyle: TextStyle(color: Colors.black),
            hintStyle: TextStyle(),
          ),
          onChanged: onChange,
          onFieldSubmitted: onSubmitted,
          validator: validator,
          onSaved: onSaved,
          keyboardType: keyboardType,
        ),
      ),
    );
  }

  static Widget buildPhoneformFieldWithoutIcon({
    String? hint,
    IconData? iconField,
    IconData? suffixIcon,
    void Function(String)? onChange,
    String? Function(String?)? validator,
    void Function(String?)? onSaved,
    void Function()? onPasswordPressed,
    isObscure = false,
    void Function(String)? onSubmitted,
    TextInputType keyboardType = TextInputType.text,
    TextEditingController? controller,
    bool autoValidate = false,
  }) {
    return Container(
      child: Theme(
        data: ThemeData(
          primaryColor: ConstantColor.APP_COLOR,
          hintColor: Colors.grey,
        ),
        child: TextFormField(
          inputFormatters: <TextInputFormatter>[
            LengthLimitingTextInputFormatter(12),
          ],
          obscureText: isObscure,
          decoration: InputDecoration(
            hintText: hint,
            labelStyle: TextStyle(color: Colors.black),
            hintStyle: TextStyle(),
          ),
          onChanged: onChange,
          onFieldSubmitted: onSubmitted,
          validator: validator,
          onSaved: onSaved,
          keyboardType: keyboardType,
        ),
      ),
    );
  }

  static Widget formFieldWithoutIcon({
    String? hint,
    IconData? iconField,
    IconData? suffixIcon,
    void Function(String)? onChange,
    String? Function(String?)? validator,
    void Function(String?)? onSaved,
    void Function()? onPasswordPressed,
    isObscure = false,
    void Function(String)? onSubmitted,
    TextInputType keyboardType = TextInputType.text,
    TextEditingController? controller,
    bool autoValidate = false,
    isEmail = false,
    bool enabled = true,
    String? lableText,
  }) {
    return Container(
      child: Theme(
        data: ThemeData(
          primaryColor: ConstantColor.APP_COLOR,
          hintColor: Colors.grey,
        ),
        child: TextFormField(
          enabled: enabled,
          obscureText: isObscure,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(
                suffixIcon,
                color: ConstantColor.APP_COLOR,
              ),
              onPressed: onPasswordPressed,
            ),
            hintText: hint,
            labelText: lableText,
            labelStyle: TextStyle(color: Colors.black),
            hintStyle: TextStyle(),
          ),
          onChanged: onChange,
          onFieldSubmitted: onSubmitted,
          validator: (value) {
            return Validation.validateValue(value ?? '', hint ?? '', isEmail);
          },
          onSaved: onSaved,
          keyboardType: keyboardType,
        ),
      ),
    );
  }
} */
