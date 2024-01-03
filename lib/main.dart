import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uas_mobapp_grup1/firebase_auth.dart';
import 'package:uas_mobapp_grup1/forgotpass.dart';
import 'package:uas_mobapp_grup1/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:uas_mobapp_grup1/utama.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: const FirebaseOptions(
      apiKey: "AIzaSyAbVmrmlC-EzBHNAJBzmGmzSsZ2KiAqx9Q",
      authDomain: "uas-mobappgrup1-df6e6.firebaseapp.com",
      projectId: "uas-mobappgrup1-df6e6",
      storageBucket: "uas-mobappgrup1-df6e6.appspot.com",
      messagingSenderId: "778726661442",
      appId: "1:778726661442:android:7a2879ce9bf77706cbbcdb"),
);

runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String errorMessage = '';

  Future<void> login() async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );

    // Login successful, navigate to main page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HalamanUtama()),
    );
  } catch (e) {
    print('Error during login: $e');
    setState(() {
      errorMessage = 'Invalid email or password. Please try again.';
    });
  }
}



  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
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
            height: 600.0,
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
                    "Login",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 70),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                  SizedBox(height: 25),
                  TextField(
                    controller: passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: _togglePasswordVisibility,
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed:login,
                    child: Text('Login'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      onPrimary: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () async {
                      try {
                        final result = await AuthService().signInWithGoogle();
                        if (result !=null){
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HalamanUtama()),
                          );
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Image.asset('lib/assets/logogoogle.png',
                        width: 50, height: 50),
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForgotPass()),
                      );
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.black,
                      ),
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