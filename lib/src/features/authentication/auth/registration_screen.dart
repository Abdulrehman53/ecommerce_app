import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/models/register_model.dart';
import 'package:ecommerce_app/src/repositories/app_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../config/validations.dart';
import '../../../common_widgets/component_button.dart';
import '../../../common_widgets/component_form_fields.dart';
import '../../../common_widgets/component_sized_box.dart';
import '../../../common_widgets/component_text_widgets.dart';
import '../../../constants/constants_colors.dart';

class RegistrationScreen extends StatelessWidget {
  static const id = 'RegisterScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: ComponentText.buildTextWidget(
              title: 'create account'.toUpperCase(),
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(),
          child: SafeArea(
            minimum: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(),
                child: _SignInForm(),
              ),
            ),
          ),
        ));
  }
}

class _SignInForm extends StatefulWidget {
  @override
  __SignInFormState createState() => __SignInFormState();
}

class __SignInFormState extends State<_SignInForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _driverController = TextEditingController();
  final _vehicleController = TextEditingController();
  final _companyController = TextEditingController();
  bool _autoValidate = false;
  RegisterModel? registerModel;

  bool passwordVisible = false;
  String? email, password, confirmPassword, firstName, lastName;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      autovalidateMode:
          _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ComponentSizedBox.topMargin(size: 16),
            Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,

              children: <Widget>[
                ComponentSizedBox.topMargin(size: 30),
                FormFieldComponent(
                  hint: 'First Name'.toUpperCase(),
                  keyboardType: TextInputType.text,
                  iconField: Icons.person,
                  onSaved: (value) {
                    firstName = value;
                    setState(() {});
                  },
                  validator: (value) {
                    return Validation.validateValue(
                        value!, 'First Name', false);
                  },
                ),
                ComponentSizedBox.topMargin(size: 16),
                FormFieldComponent(
                  hint: 'Last Name'.toUpperCase(),
                  keyboardType: TextInputType.text,
                  iconField: Icons.person,
                  onSaved: (value) {
                    lastName = value;
                    setState(() {});
                  },
                  validator: (value) {
                    return Validation.validateValue(value!, 'Last Name', false);
                  },
                ),
                ComponentSizedBox.topMargin(size: 16),
                ComponentSizedBox.topMargin(size: 16),
                FormFieldComponent(
                  hint: 'Email'.toUpperCase(),
                  keyboardType: TextInputType.emailAddress,
                  iconField: Icons.email,
                  onSaved: (value) {
                    email = value;
                    setState(() {});
                  },
                  validator: (
                    value,
                  ) {
                    return Validation.validateValue(value!, 'Email', true);
                  },
                ),
                ComponentSizedBox.topMargin(size: 16),
                FormFieldComponent(
                  hint: 'Password'.toUpperCase(),
                  isObscure: passwordVisible ? false : true,
                  keyboardType: TextInputType.text,
                  iconField: Icons.lock,
                  suffixIcon:
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
                  onPasswordPressed: () {
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                  onSaved: (value) {
                    password = value;
                    setState(() {});
                  },
                  validator: (value) {
                    return Validation.validateValue(value!, 'Password', false);
                  },
                ),
                ComponentSizedBox.topMargin(size: 16),
                FormFieldComponent(
                  hint: 'confirm Password'.toUpperCase(),
                  isObscure: passwordVisible ? false : true,
                  keyboardType: TextInputType.text,
                  iconField: Icons.lock,
                  suffixIcon:
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
                  onSaved: (value) {
                    confirmPassword = value;
                    setState(() {});
                  },
                  onPasswordPressed: () {
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                  validator: (value) {
                    return Validation.validateValue(
                        value!, 'confirm Password', false);
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                ComponentButton.buildButton(
                  width: MediaQuery.of(context).size.width,
                  height: 48.0,
                  title: 'create account'.toUpperCase(),
                  btnColor: ConstantColor.primaryColor,
                  texColor: ConstantColor.white,
                  onPressed: _onLoginButtonPressed,
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _onLoginButtonPressed() {
    if (_key.currentState!.validate()) {
      _key.currentState!.save();
      if (password != confirmPassword) {
        Fluttertoast.showToast(msg: 'Password and confirm password should be same');
      } else {
        registerModel = RegisterModel(
            name: firstName! + ' ' + lastName!,
            email: email,
            password: password);
        AppRepo().signup(registerModel: registerModel, context: context);
      }
      // Get.to(StaffProfileScreen());
      // _controller.login(_emailController.text, _passwordController.text);
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}
