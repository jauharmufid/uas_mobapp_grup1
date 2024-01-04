import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uas_mobapp_grup1/tabbarview.dart';

class MahasiswaModifyPage extends StatefulWidget {
  final Mahasiswa mahasiswa;

  MahasiswaModifyPage({required this.mahasiswa});

  @override
  _MahasiswaModifyPageState createState() => _MahasiswaModifyPageState();
}

class _MahasiswaModifyPageState extends State<MahasiswaModifyPage> {
  late TextEditingController namaController;
  late TextEditingController nilaiController;

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController(text: widget.mahasiswa.nama);
    nilaiController =
        TextEditingController(text: widget.mahasiswa.nilai.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Transaksi Modify')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('NIM: ${widget.mahasiswa.nim}'),
            TextField(
              controller: namaController,
              decoration: InputDecoration(labelText: 'Nama'),
            ),
            TextField(
              controller: nilaiController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Nilai'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String nama = namaController.text.trim();
                double nilai = double.tryParse(nilaiController.text) ?? 0.0;

                if (nama.isNotEmpty) {
                  Mahasiswa updatedMahasiswa = Mahasiswa(
                    nim: widget.mahasiswa.nim,
                    nama: nama,
                    nilai: nilai,
                    updatedAt: DateTime.now(),
                  );

                  updateMahasiswa(updatedMahasiswa);

                  // Menggunakan Navigator untuk memberikan data kembali ke MahasiswaListPage
                  Navigator.pop(context, updatedMahasiswa);
                } else {
                  // Show an error message if input is invalid
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Invalid Input'),
                        content: Text('Please enter a valid Name.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Modify'),
            ),
          ],
        ),
      ),
    );
  }

  void updateMahasiswa(Mahasiswa mahasiswa) {
    FirebaseFirestore.instance
        .collection('Nilai_Mahasiswa')
        .doc('${mahasiswa.nim}')
        .update({
      'Nama': mahasiswa.nama,
      'Nilai': mahasiswa.nilai,
      'UpdatedAt': mahasiswa.updatedAt,
    });
  }
}