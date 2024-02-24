import 'package:flutter/material.dart';
import 'package:pharmacy_manager/common/widgets/custom_button.dart';
import 'package:pharmacy_manager/common/widgets/custom_textfield.dart';
import 'package:pharmacy_manager/constants/global_variables.dart';
import 'package:pharmacy_manager/features/auth/services/auth_service.dart';

enum Auth {
  signin,
  signup,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({Key? key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final AuthService authService = AuthService();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
  }

  void signUpUser() {
    authService.signUpUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
      phone: _phoneController.text,
    );
  }

  void signInUser() {
    authService.signInUser(
      context: context,
      phone: _phoneController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            ' welcome',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),

          ListTile(
            tileColor: _auth == Auth.signup
                ? GlobalVariables.backgroundColor
                : GlobalVariables.greyBackgroundCOlor,
            title: const Text(
              'Create Account',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: Radio(
              activeColor: GlobalVariables.secondaryColor,
              value: Auth.signup,
              groupValue: _auth,
              onChanged: (Auth? val) {
                setState(() {
                  _auth = val!;
                });
              },
            ),
          ),
          if (_auth == Auth.signup)
            Container(
              padding: const EdgeInsets.all(8),
              color: GlobalVariables.backgroundColor,
              child: Form(
                key: _signUpFormKey,
                child: Column(children: [
                  CustomTextField(
                    controller: _nameController,
                    hintText: 'Họ Tên',
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: _phoneController,
                    hintText: 'Số điện thoại',
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: _emailController,
                    hintText: 'Email',
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: _passwordController,
                    hintText: 'Mật khẩu đăng nhậpl',
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                      text: 'Đăng nhập ',
                      onTap: () {
                        if (_signUpFormKey.currentState!.validate()) {
                          signUpUser();
                        }
                      })
                ]),
              ),
            ),

          ListTile(
            title: const Text(
              'Dang nhap',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: Radio(
              activeColor: GlobalVariables.secondaryColor,
              value: Auth.signin,
              groupValue: _auth,
              onChanged: (Auth? val) {
                setState(() {
                  _auth = val!;
                });
              },
            ),
          ),
          if (_auth == Auth.signin)
            Container(
              padding: const EdgeInsets.all(8),
              color: GlobalVariables.backgroundColor,
              child: Form(
                key: _signInFormKey,
                child: Column(children: [
                  CustomTextField(
                    controller: _phoneController,
                    hintText: 'Số điện thoại',
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: _passwordController,
                    hintText: 'Mật khẩu đăng nhậpl',
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                      text: 'Đăng nhập ',
                      onTap: () {
                        if (_signInFormKey.currentState!.validate()) {
                          signInUser();
                        }
                      })
                ]),
              ),
            ),

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: <Widget>[
          //     const SizedBox(width: 16),
          //     // An example of the regular floating action button.
          //     //
          //     // https://m3.material.io/components/floating-action-button/specs#71504201-7bd1-423d-8bb7-07e0291743e5
          //     FloatingActionButton.extended(
          //       onPressed: () {
          //         // Add your onPressed code here!
          //       },
          //       label: const Text('Đăng nhập ngay'),
          //     ),
          //   ],
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: <Widget>[
          //     const SizedBox(width: 16),
          //     // An example of the regular floating action button.
          //     //
          //     // https://m3.material.io/components/floating-action-button/specs#71504201-7bd1-423d-8bb7-07e0291743e5
          //     FloatingActionButton.extended(
          //       onPressed: () {
          //         // Add your onPressed code here!
          //       },
          //       label: const Text('Đăng Ký '),
          //     ),
          //   ],
          // ),
        ]),
      )),
    );
  }
}
