import 'package:flutter/material.dart';
import 'package:uas_mobapp_grup1/firebase_auth.dart';
import 'package:uas_mobapp_grup1/main.dart';

void main() {
  runApp(MyApp());
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
                        Text('NIM: 1101201267')
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        Image.asset('lib/assets/image2.jpg'),
                        Text('NAMA: MUHAMMAD IKHLASHUL YOREN'),
                        Text('NIM: 1101200223')
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        Image.asset('lib/assets/anam.jpg'),
                        Text('NAMA: NASEHUN ANAM'),
                        Text('NIM: 1101202529')
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        Image.asset('lib/assets/mufid.jpg'),
                        Text('NAMA: JAUHAR MUFID WIDYANDANI'),
                        Text('NIM: 1101204061')
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        Image.asset('lib/assets/image5.jpg'),
                        Text('NAMA: ANGEL BLESS TANIA'),
                        Text('NIM: 1101228431')
                      ],
                    ),
                  ),
                ],
              ),
              ListView.builder(
                itemCount: 10, // Ganti dengan jumlah data yang sebenarnya
                itemBuilder: (context, index) {
                  int no = index + 1;
                  return Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text('Username $no'), // Ganti dengan username yang sebenarnya
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Keterangan: Keterangan $no'), // Ganti dengan keterangan yang sebenarnya
                        Text('Jenis: Pemasukan'), // Ganti dengan jenis yang sebenarnya
                        Text('Jumlah: Jumlah $no'), // Ganti dengan jumlah yang sebenarnya
                        Text('Upload bukti transaksi: Bukti $no'), // Ganti dengan bukti transaksi yang sebenarnya
                        Text('Tanggal isi data: Tanggal $no'), // Ganti dengan tanggal isi data yang sebenarnya
                      ],
                    ),
                    trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                    // Tambahkan fungsi untuk menghapus data di sini
                        },
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
