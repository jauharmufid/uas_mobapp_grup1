import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uas_mobapp_grup1/transaksi_add.dart';
import 'package:uas_mobapp_grup1/firebase_auth.dart';
import 'package:uas_mobapp_grup1/main.dart';
import 'package:uas_mobapp_grup1/transaksi_detail.dart';
import 'package:firebase_core/firebase_core.dart';


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

class Mahasiswa {
  late int nim;
  late String nama;
  late double nilai;
  late DateTime updatedAt;

  Mahasiswa({
    required this.nim,
    required this.nama,
    required this.nilai,
    required this.updatedAt,
  });

  factory Mahasiswa.fromDocument(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    return Mahasiswa(
      nim: int.parse(document.id),
      nama: data['Nama'],
      nilai: data['Nilai'],
      updatedAt: data['UpdatedAt'] != null ? (data['UpdatedAt'] as Timestamp).toDate() : DateTime.now(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Center(child: Text('GRUP 1')),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () async {
                  await AuthService().signOut();
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setBool('isLoggedIn', false);
                  Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginPage())
                  );
                },
              ),
            ],
            bottom: TabBar(
              indicatorColor: Colors.blue,
              labelColor: Colors.blue,
              tabs: [
                Tab(text: 'Tab 1'),
                Tab(text: 'Tab 2'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        Image.asset('lib/assets/chika.jpg'),
                        Text('NAMA: FAYZA RIZKA ZALIANTY'),
                        Text('NIM: 1101201267'),
                        
                        Padding(padding: const EdgeInsets.all(5.0)),
                        Image.asset('lib/assets/anam.jpg'),
                        Text('NAMA: NASEHUN ANAM'),
                        Text('NIM: 1101202529'),
                        Padding(padding: const EdgeInsets.all(5.0)),
                        Image.asset('lib/assets/mufid.jpg'),
                        Text('NAMA: JAUHAR MUFID WIDYANDANI'),
                        Text('NIM: 1101204061'),
                        
                      ],
                    ),
                  ),
                ],
              ),
              Stack(
                children: <Widget>[
                  StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('Nilai_Mahasiswa').snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      List<Mahasiswa> mahasiswaList = snapshot.data!.docs.map((DocumentSnapshot document) {
                        return Mahasiswa.fromDocument(document);
                      }).toList();

                      return ListView.builder(
                        itemCount: mahasiswaList.length,
                        itemBuilder: (context, index) {
                          Mahasiswa mahasiswa = mahasiswaList[index];
                          return ListTile(
                            title: Text('${mahasiswa.nim}',
                            style: TextStyle(fontWeight: FontWeight.bold),),
                            subtitle: Text('Nilai: ${mahasiswa.nilai}'),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MahasiswaDetailPage(mahasiswa: mahasiswa),
                                ),
                              );
                            },
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Delete Confirmation'),
                                      content: Text(
                                          'Are you sure you want to delete this item?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            deleteMahasiswa(mahasiswa.nim);
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Delete'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MahasiswaAddPage(),
                          ),
                        );
                      },
                      child: Icon(Icons.add),
                      backgroundColor: Colors.blue.shade100,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void deleteMahasiswa(int nim) {
    FirebaseFirestore.instance
        .collection('Nilai_Mahasiswa')
        .doc('$nim')
        .delete();
  }
}


