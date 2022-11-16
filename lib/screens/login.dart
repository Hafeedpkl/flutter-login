import 'package:flutter/material.dart';
import 'package:login_page/main.dart';
import 'package:login_page/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  final String uname = "hafeed";
  final String pword = "1234";
  final _usernameController = TextEditingController();

  final _passwordController = TextEditingController();

  bool _isDataMatched = true;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Username',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Username is Empty';
                    } else {
                      return null;
                    }
                  }),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is Empty';
                    } else {
                      return null;
                    }
                  }),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                    visible: !_isDataMatched,
                    // ignore: prefer_const_constructors
                    child: Text(
                      'Username password doesn\'t match',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                  ElevatedButton.icon(
                      onPressed: () {
                        _formKey.currentState!.validate();
                        checkLogin(context);
                      },
                      icon: const Icon(Icons.check),
                      label: const Text('Login')),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }

  void checkLogin(BuildContext ctx) async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    if (username == uname && password == pword) {
// Goto Home
      final sharedPrefs = await SharedPreferences.getInstance();
      await sharedPrefs.setBool(SAVE_KEY_NAME, true);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx1) => const ScreenHome()));
      // ignore: use_build_context_synchronously
      showTopSnackBar(
        context,
        const CustomSnackBar.success(
          message: "Login Successfull",
        ),
      );
    } else {
      // print('Username Password Doesn't match');

      const errorMessage = 'Username and password doesn\'t Match';
//Snackbar
      ScaffoldMessenger.of(ctx).showSnackBar(
        // ignore: prefer_const_constructors
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(10),
          content: const Text(errorMessage),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
        ),
      );
// // Alert Dialog
//       showDialog(
//           context: ctx,
//           builder: (ctx1) {
//             return AlertDialog(
//               title: const Text('Error'),
//               content: const Text(errorMessage),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(ctx1).pop();
//                   },
//                   child: const Text('Close'),
//                 ),
//               ],
//             );
//           });

//Show Text
      setState(() {
        _isDataMatched = false;
      });
    }
  }
}
