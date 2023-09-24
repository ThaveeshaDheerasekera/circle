import 'package:circle/configs/custom_colors.dart';
import 'package:circle/repositories/auth_repository.dart';
import 'package:circle/widget/global_widgets/elevated_button_widget.dart';
import 'package:circle/widget/global_widgets/form_item_widget.dart';
import 'package:circle/widget/global_widgets/text_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signInWithEmailAndPassword() async {
    try {
      await AuthRepository().signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> _createUserWithEmailAndPassword() async {
    try {
      await AuthRepository().createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _errorMessage() {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(2),
      ),
      width: double.infinity,
      child: Text(
        'Error: $errorMessage',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget _submitButton() {
    return ElevatedButtonWidget(
      child: Text(isLogin ? 'Login' : 'Sign Up'),
      width: 100,
      height: 40,
      borderRadius: 2,
      onPressed: isLogin
          ? _signInWithEmailAndPassword
          : _createUserWithEmailAndPassword,
    );
  }

  Widget _loginOrRegisterButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          isLogin = !isLogin;
          errorMessage = '';
        });
      },
      child: Text(isLogin ? 'Sign Up instead' : 'Login instead'),
    );
  } //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: CustomColors.olive,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FormItemWidget(
              title: isLogin ? 'Login' : 'Sign Up',
              onPressed: () {
                _emailController.clear();
                _passwordController.clear();
                setState(() {
                  errorMessage = '';
                });
              },
              child: Column(
                children: [
                  TextFieldWidget(
                    hintText: 'Email',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.none,
                  ),
                  TextFieldWidget(
                    hintText: 'Password',
                    obscureText: true,
                    controller: _passwordController,
                    // keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.none,
                  ),
                  const SizedBox(height: 20),
                  errorMessage == '' ? const SizedBox() : _errorMessage(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _loginOrRegisterButton(),
                      _submitButton(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
