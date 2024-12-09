import 'package:demo/models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/login_provider.dart';
import '../../utils/NavigationHelper.dart';
import 'SignUpScreen.dart';



class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<SignInScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        margin: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _header(context),
            _inputField(context,ref),
            _forgotPassword(context),
            _signup(context),
          ],
        ),
      ),
    ));
  }
}

_header(context) {
  return const Column(
    children: [
      Text(
        "Welcome Back",
        style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
      ),
      Text("Enter your credential to login"),
    ],
  );
}

_inputField(context, ref) {
  final TextEditingController _mobileNoController = TextEditingController();
  final TextEditingController _roleIdController = TextEditingController();
  final TextEditingController _fcmKeyController = TextEditingController();
  String roleid = "2";
  String fcm = "";
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      TextField(
        controller: _mobileNoController,
        decoration: InputDecoration(
            hintText: "Username",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
            fillColor: Colors.purple.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.person)),
      ),
      const SizedBox(height: 10),
      TextField(
        decoration: InputDecoration(
          hintText: "Password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
          fillColor: Colors.purple.withOpacity(0.1),
          filled: true,
          prefixIcon: const Icon(Icons.password),
        ),
        obscureText: true,
      ),
      const SizedBox(height: 10),
      ElevatedButton(
        onPressed: () async {
          final loginRequest = SignInRequest(
            mobileNo: _mobileNoController.text,
            roleId: roleid,
            fcmKey: fcm,
          );
          final response = await ref.read(loginProvider(loginRequest).future);

        },
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Colors.purple,
        ),
        child: const Text(
          "Login",
          style: TextStyle(fontSize: 20),
        ),
      )
    ],
  );
}

_forgotPassword(context) {
  return TextButton(
    onPressed: () {},
    child: const Text(
      "Forgot password?",
      style: TextStyle(color: Colors.purple),
    ),
  );
}

_signup(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text("Dont have an account? "),
      TextButton(
          onPressed: () {
            NavigationHelper.navigateToScreen(context, const SignUpScreen());
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(color: Colors.purple),
          ))
    ],
  );
}
