import 'package:ecommerce_app/src/features/authentication/auth/registration_screen.dart';
import 'package:ecommerce_app/src/repositories/app_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../../../../config/router.dart';
import '../../../../config/validations.dart';
import '../../../common_widgets/component_button.dart';
import '../../../common_widgets/component_form_fields.dart';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common_widgets/component_sized_box.dart';
import '../../../common_widgets/component_text_widgets.dart';
import '../../../constants/constants_colors.dart';


class LoginScreen extends StatelessWidget {
  static const id = 'LoginScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
          title: ComponentText.buildTextWidget(
              title: 'login'.toUpperCase(),
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      resizeToAvoidBottomInset: false,
         body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
             ),
          child: SafeArea(
            minimum: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(),
              child: _SignInForm(),
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
 
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  bool _autoValidate = false;

  bool passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Center(
          child: Form(
            key: _key,
            autovalidateMode: _autoValidate
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ComponentSizedBox.topMargin(size: 50),
                  // Image.asset('images/logo.png',width: 200,),
               
              
              

                  Column(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ComponentSizedBox.topMargin(size: 40),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 0,
                        ),
                        child: FormFieldComponent(
                          controller: _usernameController,
                          hint: 'E-mail'.toUpperCase(),
                          keyboardType: TextInputType.text,
                          iconField: Icons.person,
                          validator: (value) {
                            return Validation.validateValue(
                                value!,'E-mail'.toUpperCase(), false);
                          },
                        ),
                      ),
                      ComponentSizedBox.topMargin(size: 30),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 0,
                        ),
                        child: FormFieldComponent(
                          controller: _passwordController,
                          hint: 'Password'.toUpperCase(),
                          isObscure: passwordVisible ? false : true,
                          keyboardType: TextInputType.text,
                          iconField: Icons.lock,
                          suffixIcon: passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          onPasswordPressed: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                          validator: (value) {
                            return Validation.validateValue(
                                value!, 'Password'.toUpperCase(), false);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: Row(
                          children: [
                            ComponentText.buildTextWidget(
                                title: 'Forgot Password?'.toUpperCase(),
                                color: ConstantColor.titleTextColor,
                                fontSize: 16,
                                fontWeight: FontWeight.normal),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      ComponentButton.buildButton(
                          onPressed: () {
                              _onLoginButtonPressed();
                            //AppRouter.goToNextScreen(context, DashBoard());
                          },
                          title: 'Login'.toUpperCase(),
                          texColor: ConstantColor.white,
                          btnColor: ConstantColor.primaryColor,
                          width: MediaQuery.of(context).size.width,
                          height: 48),
                      const SizedBox(
                        height: 30,
                      ),
                      ComponentText.buildTextWidget(title: 'Don\'t have an account yet?'.toUpperCase(),fontSize: 16,fontWeight: FontWeight.bold ),
                         const SizedBox(
                        height: 20,
                      ),
                      ComponentText.buildTextWidget(title: 'Easily create an account for event better user experience'.toUpperCase(),fontSize: 14,fontWeight: FontWeight.normal,maxLines: 2,textAlign: TextAlign.center),
                    const SizedBox(
                        height: 30,
                      ),
                      ComponentButton.buildButton(
                          onPressed: () {
                            AppRouter.goToNextScreen(
                                context, RegistrationScreen());
                          },
                          title: 'create your account'.toUpperCase(),
                          texColor: ConstantColor.white,
                          btnColor: ConstantColor.primaryColor,
                          width: MediaQuery.of(context).size.width,
                          height: 48),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        
      ],
    );
  }

  _onLoginButtonPressed() async{
    if (_key.currentState!.validate()) {
   
      AppRepo().login(email: _usernameController.text, password: _passwordController.text, context: context);
     
      // Get.to(StaffProfileScreen());
      // _controller.login(_emailController.text, _passwordController.text);
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}

/* import 'package:flutter/material.dart';

import '../../components/component_button.dart';
import '../../constants/constants_colors.dart';

class LoginScreen extends StatefulWidget {
  static const id = 'LoginScreen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/login.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  right: 35,
                  left: 35,
                  top: MediaQuery.of(context).size.height * 0.5 - 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(children: [
                    TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Sign In',
                          style: TextStyle(
                            color: Color(0xff4c505b),
                            fontSize: 27,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: const Color(0xff4c505b),
                          child: IconButton(
                            color: Colors.white,
                            onPressed: () {},
                            icon: const Icon(Icons.arrow_forward),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, 'register');
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 18,
                                color: Color(0xff4c505b),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Forgot Password',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 18,
                                color: Color(0xff4c505b),
                              ),
                            ),
                          ),
                        ]),
                  ]),
                  
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
 */
/* import 'package:flutter/material.dart';

import '../../utils/fade_animation.dart';
class LoginScreen extends StatefulWidget {
  static const id = 'LoginScreen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var wid = MediaQuery.of(context).size.width;
    var hie = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
          height: hie,
          width: wid,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/back.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SafeArea(
                child: Column(
                  children: [
                    const SizedBox(height: 130),
                   
                    FadeAnimation(
                      2,
                      Container(
                        // color: const Color(0xfff96d34),
                        // color: const Color(0xFFC73800),
                     
                        margin: const EdgeInsets.only(right: 40),
                        child: Image.asset(
                          "images/logo.png",width: 200,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    FadeAnimation(
                      2,
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        padding: const EdgeInsets.only(left: 10),
                        decoration: const BoxDecoration(
                          color: Color(0xFFdedbed),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.person_outline),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: TextFormField(
                                  maxLines: 1,
                                  decoration: const InputDecoration(
                                    label: Text(" User-Name ..."),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    FadeAnimation(
                      2,
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        padding: const EdgeInsets.only(left: 10),
                        decoration: const BoxDecoration(
                          color: Color(0xFFdedbed),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.lock_outline),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: TextFormField(
                                  maxLines: 1,
                                  decoration: const InputDecoration(
                                    label: Text(" Pass-Word..."),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    FadeAnimation(
                      2,
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 20),
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        decoration: const BoxDecoration(
                          color: Color(0xFF536DFE),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Expanded(
                          child: Container(
                              child: const Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: const Text(
                        "SingUp if don't have account ",
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
 */