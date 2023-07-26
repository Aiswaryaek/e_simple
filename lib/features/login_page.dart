// ignore_for_file: prefer_const_constructors

import 'package:e_simple/features/home_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../core/ui_state.dart';
import '../providers/login_provider.dart';
import '../repositories/auth_repository.dart';
import '../styles/colors.dart';
import '../styles/text_style.dart';
import '../widgets/green_button.dart';
import '../widgets/text_input_field.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginProvider loginProvider = LoginProvider(authRepository: AuthRepository());
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isHidden = true;

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void onLogin() async {
    final isValidEmail = validateEmail(emailController.text);
    final isValidPassword = validatePassword(passwordController.text);
    if (isValidEmail && isValidPassword) {
      await loginProvider.userLogin(
          emailController.text, passwordController.text);
    }
  }

  String emailErrorMessage = "";

  bool validateEmail(String value) {
    if (!(value.isNotEmpty)) {
      setState(() {
        emailErrorMessage = "Email can't be empty";
      });
      return false;
    } else {
      setState(() {
        emailErrorMessage = "";
      });
      return true;
    }
  }

  String passErrorMessage = "";

  bool validatePassword(String value) {
    if (!(value.isNotEmpty)) {
      setState(() {
        passErrorMessage = "Password can't be empty";
      });
      return false;
    } else {
      setState(() {
        passErrorMessage = "";
      });
      return true;
    }
  }

  @override
  void initState() {
    super.initState();
    loginProvider.initialState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(25, 60, 25, 20),
          child: loginWidget(context),
        ),
      ),
    );
  }

  Widget loginWidget(BuildContext context) {
    return ChangeNotifierProvider<LoginProvider>(create: (ctx) {
      return loginProvider;
    }, child: Consumer<LoginProvider>(
      builder: (ctx, data, _) {
        var state = data.getLoginLiveData().getValue();
        if (state is IsLoading) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 1.3,
            child: const Center(
              child: CircularProgressIndicator(color: richTextColor),
            ),
          );
        } else if (state is Initial) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  'https://img.freepik.com/premium-vector/pg-logo-design_695270-259.jpg',
                  height: 130,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Login',
                style: headText,
              ),
              const SizedBox(height: 36),
              buildTextFormField(
                  setState,
                  'Email',
                  'Enter Your Email',
                  emailErrorMessage,
                  false,
                  emailController),
              const SizedBox(height: 12),
              buildTextField("Enter Password"),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //             ForgotPassword()
                      //       // ForgotPassword()
                      //     ));
                    },
                    child: Text('Forgot Password?', style: normalText),
                  ),
                ],
              ),
              const SizedBox(height: 27),
              blueButton(context, 'Log In', false, onLogin),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                      text: TextSpan(
                          text: 'Don' 't have an account? ',
                          style: normalText,
                          children: <TextSpan>[
                        TextSpan(
                            text: 'Sign Up',
                            style: richText,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => SignUpPage(token)))
                                  })
                      ])),
                ],
              ),
              const SizedBox(height: 25),
              Center(
                child: Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/753px-Google_%22G%22_Logo.svg.png',
                  height: 42,
                  width: 42,
                ),
              ),
              const SizedBox(height: 25),
              Center(
                  child: Text(
                'By Continuing your confirm that you ',
                style: termsText,
              )),
              Center(
                  child: Text('agree with our Terms & Conditions',
                      style: termsText)),
            ],
          );
        } else if (state is Success) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const HomePage()));
          });
          return const SizedBox();
        }  else if (state is Failure) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage()));
            final snackBar = SnackBar(
              backgroundColor: headTextColor,
              content: Container(
                height: 30,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        'Invalid Credentials',
                        style:
                        btnTextStyle
                    )),
              ),
            );
            ScaffoldMessenger.of(context)
                .showSnackBar(snackBar);
          });
          return const SizedBox();
        } else {
          return Container();
        }
      },
    ));
  }

  Widget buildTextField(String hintText) {
    return TextField(
      controller: passwordController,
      style: textFieldInputStyle,
      cursorColor: grayColor,
      onChanged: (_) => setState(() {}),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(0),
        isDense: true,
        hintText: hintText,
        errorText: passwordController.text == '' ? passErrorMessage : '',
        hintStyle: placeholderTextStyle,
        labelText: 'Password',
        labelStyle: labelTextStyle,
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
        suffixIcon: hintText == "Enter Password"
            ? IconButton(
                onPressed: _toggleVisibility,
                icon: _isHidden
                    ? Icon(Icons.visibility_off, color: placeholderColor)
                    : Icon(Icons.visibility, color: placeholderColor),
              )
            : null,
      ),
      obscureText: hintText == "Enter Password" ? _isHidden : false,
    );
  }
}
