import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPass extends StatefulWidget {
  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();

  String errorMessage = '';

  Future<void> resetPassword() async {
    try {
      if (newPasswordController.text.length < 6) {
        setState(() {
          errorMessage = 'Password should be at least 6 characters long';
        });
        return;
      }

      if (newPasswordController.text != confirmNewPasswordController.text) {
        setState(() {
          errorMessage = 'Passwords do not match';
        });
        return;
      }

      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text,
      );

      // Password reset email sent, navigate back to login page
      Navigator.pop(context);
    } catch (e) {
      print('Error during password reset: $e');
      setState(() {
        errorMessage = 'Password reset failed. Please try again.';
      });
    }
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      centerTitle: true,
    ),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: 400.0,
          height: 500.0,
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Forgot Password",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 70),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
                SizedBox(height: 25),
                TextField(
                  controller: newPasswordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'New Password',
                  ),
                ),
                SizedBox(height: 25),
                TextField(
                  controller: confirmNewPasswordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Confirm New Password',
                  ),
                ),
                Text(errorMessage),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: resetPassword,
                  child: Text('Reset Password'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      onPrimary: Colors.white,
                    ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
}