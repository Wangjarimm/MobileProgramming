// import 'package:crudflut1/datakamar.dart';
import 'package:crudflut1/karyawan.dart';
import 'package:crudflut1/menu.dart';
import 'package:crudflut1/reservasi.dart';
import 'package:flutter/material.dart';

import 'datakamar.dart'; // import halaman manajemen kamar
import 'datapelanggan.dart'; // import halaman manajemen pelanggan

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.blue, // Mengatur warna latar belakang menjadi biru
            child: Padding(
              padding: EdgeInsets.only(
                  top: 16.0), // Menambahkan jarak 16.0 ke atas judul
              child: ListTile(
                title: Text(
                  'Hotel Hotelan',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white, // Mengatur warna teks menjadi putih
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Pelanggan()),
              );
            },
            child: Text('Manajemen Pelanggan'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Kamar()),
              );
            },
            child: Text('Manajemen Kamar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Karyawan()),
              );
            },
            child: Text('Manajemen Karyawan'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Reservasi()),
              );
            },
            child: Text('Reservasi'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Menu()),
              );
            },
            child: Text('Menu'),
          ),
          //copas aja Elevated Button diatas
        ],
      ),
    );
  }
}
