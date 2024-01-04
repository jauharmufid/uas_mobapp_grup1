import 'package:flutter/material.dart';
import 'package:uas_mobapp_grup1/tabbarview.dart';
import 'package:uas_mobapp_grup1/transaksi_modify.dart';

class MahasiswaDetailPage extends StatefulWidget {
  final Mahasiswa mahasiswa;

  MahasiswaDetailPage({required this.mahasiswa});

  @override
  _MahasiswaDetailPageState createState() => _MahasiswaDetailPageState();
}

class _MahasiswaDetailPageState extends State<MahasiswaDetailPage> {
  late Mahasiswa _updatedMahasiswa;

  @override
  void initState() {
    super.initState();
    _updatedMahasiswa = widget.mahasiswa;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Transaksi Detail')),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('NIM: ${_updatedMahasiswa.nim}'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Nama: ${_updatedMahasiswa.nama}'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Nilai: ${_updatedMahasiswa.nilai}'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Updated At: ${_updatedMahasiswa.updatedAt}'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () async {
                  // Kode untuk download
                },
                child: Text('Download',
                style: TextStyle(
                  color: Colors.black
                ),),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue.shade100
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  // Kode untuk upload
                },
                child: Text('Upload',
                style: TextStyle(
                  color: Colors.black
                ),),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue.shade100
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  // Menggunakan Navigator untuk membuka halaman Modify
                  final updatedMahasiswa = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MahasiswaModifyPage(mahasiswa: _updatedMahasiswa),
                    ),
                  );

                  // Memperbarui tampilan jika ada perubahan
                  if (updatedMahasiswa != null) {
                    setState(() {
                      _updatedMahasiswa = updatedMahasiswa as Mahasiswa;
                    });
                  }
                },
                child: Text('Modify',
                style: TextStyle(
                  color: Colors.black
                ),),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue.shade100
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
