import 'package:circle/configs/custom_colors.dart';
import 'package:circle/repositories/auth_repository.dart';
import 'package:circle/widget/global_widgets/elevated_button_widget.dart';
import 'package:circle/widget/global_widgets/text_field_widget.dart';
import 'package:circle/widget/global_widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? errorMessage = '';
  String? succMessage = '';
  bool isLogin = true;
  // var user = Provider.of<AuthRepository>(context, listen: false)

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  Widget _message() {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(2),
      ),
      width: double.infinity,
      child: Text(
        Provider.of<AuthRepository>(context, listen: false).getMessage,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget _submitButton() {
    var user = Provider.of<AuthRepository>(context, listen: false);
    return ElevatedButtonWidget(
      child: Text(isLogin ? 'Login' : 'Sign Up'),
      width: 100,
      height: 40,
      borderRadius: 2,
      onPressed: () async {
        isLogin
            ? await user.signInWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text)
            : await user.createUserWithEmailAndPassword(
                name: _nameController.text,
                email: _emailController.text,
                password: _passwordController.text,
                conPassword: _confirmPasswordController.text);
      },
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
    return Consumer<AuthRepository>(
      builder: (context, user, child) => Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: CustomColors.olive,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TitleWidget(
                title: isLogin ? 'Login' : 'Sign Up',
                actions: [
                  ElevatedButtonWidget(
                    child: Text('Clear'),
                    width: 50,
                    height: 30,
                    borderRadius: 2,
                    onPressed: () {
                      _emailController.clear();
                      _passwordController.clear();
                      setState(() {
                        user.clearMessage();
                        errorMessage = '';
                        succMessage = '';
                      });
                    },
                  ),
                ],
                child: Column(
                  children: [
                    !isLogin
                        ? TextFieldWidget(
                            hintText: 'Name',
                            controller: _nameController,
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                          )
                        : const SizedBox(),
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
                      textCapitalization: TextCapitalization.none,
                    ),
                    !isLogin
                        ? TextFieldWidget(
                            hintText: 'Confirm Password',
                            obscureText: true,
                            controller: _confirmPasswordController,
                            textCapitalization: TextCapitalization.none,
                          )
                        : const SizedBox(),
                    const SizedBox(height: 20),
                    user.getMessage.isEmpty ? const SizedBox() : _message(),
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
      ),
    );
  }
}
