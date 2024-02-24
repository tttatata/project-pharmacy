import 'package:flutter/material.dart';
import 'package:pharmacy_manager/constants/error_handling.dart';
import 'package:pharmacy_manager/constants/global_variables.dart';
import 'package:pharmacy_manager/constants/utils.dart';
import 'package:pharmacy_manager/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
class AuthService {
  //sign up
  //
  
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    try {
      User user = User(
          id: '',
          name: name,
          email: email,
          password: password,
          phone: phone,
          address: '',
          type: '',
          token: '');
      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Account created! Login with the same credentials!',
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    // sign in user
  }
  void signInUser({
      required BuildContext context,
      required String phone,
      required String password,
    }) async {
      try {
        http.Response res = await http.post(
          Uri.parse('$uri/api/signin'),
          body: jsonEncode({
            'phone': phoneNumber\,
            'password': password,
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider[]>(context, listen: false).setUser(res.body);
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
            Navigator.pushNamedAndRemoveUntil(
              context,
              BottomBar.routeName,
              (route) => false,
            );
          },
        );
      } catch (e) {
        showSnackBar(context, e.toString());
      }
    }
}
