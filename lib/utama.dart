import 'package:flutter/material.dart';
import 'package:uas_mobapp_grup1/firebase_auth.dart';
import 'package:uas_mobapp_grup1/main.dart';

class HalamanUtama extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Halaman Utama',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Halaman Utama'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await AuthService().signOut();
              Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => LoginPage())
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Selamat Datang',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
