import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uas_mobapp_grup1/tabbarview.dart';


class MahasiswaAddPage extends StatelessWidget {
  final TextEditingController nimController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController nilaiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Transaksi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nimController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'NIM'),
            ),
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
              onPressed: () {
                int nim = int.tryParse(nimController.text) ?? 0;
                String nama = namaController.text.trim();
                double nilai = double.tryParse(nilaiController.text) ?? 0.0;

                if (nim > 0 && nama.isNotEmpty) {
                  Mahasiswa newMahasiswa = Mahasiswa(
                    nim: nim,
                    nama: nama,
                    nilai: nilai,
                    updatedAt: DateTime.now(),
                  );

                  addMahasiswa(newMahasiswa);

                  Navigator.pop(context);
                } else {
                  // Show an error message if input is invalid
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Invalid Input'),
                        content: Text('Please enter valid data.'),
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
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }

  void addMahasiswa(Mahasiswa mahasiswa) {
    FirebaseFirestore.instance
        .collection('Nilai_Mahasiswa')
        .doc('${mahasiswa.nim}')
        .set({
      'Nama': mahasiswa.nama,
      'Nilai': mahasiswa.nilai,
      'UpdatedAt': mahasiswa.updatedAt,
    });
  }
}

