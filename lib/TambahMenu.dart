import 'package:crudflut1/menu.dart'; // Mengganti import Karyawan.dart menjadi Menu.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TambahMenu extends StatefulWidget {
  TambahMenu({Key? key}) : super(key: key);

  @override
  State<TambahMenu> createState() => _TambahMenuState();
}

class _TambahMenuState extends State<TambahMenu> {
  final formKey = GlobalKey<FormState>();

  TextEditingController namaMenu =
      TextEditingController(); // Mengganti nama variabel nama menjadi namaMenu
  TextEditingController deskripsi =
      TextEditingController(); // Menambahkan controller untuk deskripsi
  TextEditingController harga =
      TextEditingController(); // Menambahkan controller untuk harga

  Future _simpan() async {
    final response = await http.post(
      Uri.parse(
          'http://192.168.1.11/flutterapinewbed/createmenu.php'), // Mengganti URL endpoint
      body: {
        "nama_menu": namaMenu.text, // Menggunakan controller namaMenu
        "deskripsi": deskripsi.text, // Menggunakan controller deskripsi
        "harga": harga.text, // Menggunakan controller harga
      },
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tambah Menu",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(height: 10),
              TextFormField(
                controller: namaMenu,
                decoration: InputDecoration(
                  hintText: 'Nama Menu',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Nama Menu tidak boleh kosong!";
                  }
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: deskripsi,
                decoration: InputDecoration(
                  hintText: 'Deskripsi',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Deskripsi tidak boleh kosong!";
                  }
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: harga,
                decoration: InputDecoration(
                  hintText: 'Harga',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Harga tidak boleh kosong!";
                  }
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    _simpan().then((value) {
                      if (value) {
                        final snackBar = SnackBar(
                          content: const Text('Data Disimpan!'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        final snackBar = SnackBar(
                          content: const Text('Data Gagal Disimpan!'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    });
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>
                              Menu())), // Menggunakan Menu() sebagai halaman pengganti
                    );
                  }
                },
                child: Text("Simpan"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
