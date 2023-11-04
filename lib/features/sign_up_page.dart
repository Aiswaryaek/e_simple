import 'package:e_simple/features/login_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/ui_state.dart';
import '../providers/signup_provider.dart';
import '../repositories/auth_repository.dart';
import '../styles/colors.dart';
import '../styles/text_style.dart';
import '../widgets/blue_button.dart';
import '../widgets/text_input_field.dart';
import 'home_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  SignUpProvider signUpProvider =
      SignUpProvider(authRepository: AuthRepository());
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  bool _isHidden = true;

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
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

  String firstNameErrorMessage = "";

  bool validateFirstName(String value) {
    if (!(value.isNotEmpty)) {
      setState(() {
        firstNameErrorMessage = "First Name can't be empty";
      });
      return false;
    } else {
      setState(() {
        firstNameErrorMessage = "";
      });
      return true;
    }
  }

  String lastNameErrorMessage = "";

  bool validateLastName(String value) {
    if (!(value.isNotEmpty)) {
      setState(() {
        lastNameErrorMessage = "Last name can't be empty";
      });
      return false;
    } else {
      setState(() {
        lastNameErrorMessage = "";
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
    signUpProvider.initialState();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(25, 60, 25, 20),
          child: signup(context),
        ),
      ),
    );
  }

  Widget signup(BuildContext context) {

    return ChangeNotifierProvider<SignUpProvider>(
      create: (ctx) {
        return signUpProvider;
      },
      child: Consumer<SignUpProvider>(
        builder: (ctx, data, _) {
          var state = data.getSignUpLiveData().getValue();
          print(state);
          if (state is IsLoading) {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 1.3,
              child: Center(
                child: CircularProgressIndicator(color: blackColor),
              ),
            );
          } else if (state is Initial) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.network(
                    'https://us.123rf.com/450wm/cidepix/cidepix1809/cidepix180900665/108935761-vector-illustration-of-grey-glossy-snake-shaped-letter-s-isolated-on-a-white-background.jpg?ver=6',
                    height: 130,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Register',
                  style: headText,
                ),
                const SizedBox(height: 36),
                buildTextFormField(setState, 'First Name', 'Enter Your First Name',
                    firstNameErrorMessage, false, firstNameController),
                const SizedBox(height: 12),
                buildTextFormField(setState, 'Last Name', 'Enter Your Last Name',
                    lastNameErrorMessage, false, lastNameController),
                const SizedBox(height: 12),
                buildTextFormField(setState, 'Email', 'Enter Your Email',
                    emailErrorMessage, false, emailController),
                const SizedBox(height: 12),
                buildTextField("Enter Password"),
                const SizedBox(height: 27),
                blueButton(context, 'Sign Up', false, onSignUp),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                        text: TextSpan(
                            text: 'Already have an account? ',
                            style: normalText,
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Log In',
                                  style: richText,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => LoginPage()))
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
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) =>HomePage()));
            });
            return SizedBox();
          } else if (state is Failure) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SignUpPage()));
              final snackBar = SnackBar(
                backgroundColor: headTextColor,
                content: Container(
                  height: 30,
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          'Something Went wrong!!',
                          style:
                          btnTextStyle
                      )),
                ),
              );
              ScaffoldMessenger.of(context)
                  .showSnackBar(snackBar);
            });
            return SizedBox();
          } else {
            return Container();
          }
        },
      ),
    );
  }

  onSignUp() async {
    final isValidEmail = validateEmail(emailController.text);
    final isValidPassword = validatePassword(passwordController.text);
    final isValidFirstName = validateFirstName(firstNameController.text);
    final isValidLastName = validateLastName(lastNameController.text);
    if (isValidEmail &&
        isValidPassword &&
        isValidFirstName &&
        isValidLastName) {
      await signUpProvider.signUp(emailController.text, passwordController.text,
          firstNameController.text, lastNameController.text);
    }
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
