import 'package:crudflut1/menu.dart'; // Mengganti import Karyawan.dart menjadi Menu.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditMenu extends StatefulWidget {
  final Map listData;

  EditMenu({Key? key, required this.listData}) : super(key: key);

  @override
  State<EditMenu> createState() => _EditMenuState();
}

class _EditMenuState extends State<EditMenu> {
  final formKey = GlobalKey<FormState>();

  TextEditingController id_menu = TextEditingController();
  TextEditingController nama_menu = TextEditingController();
  TextEditingController harga = TextEditingController();
  TextEditingController deskripsi = TextEditingController();

  Future _update() async {
    final response = await http.post(
      Uri.parse(
          'http://192.168.1.11/flutterapinewbed/editmenu.php'), // Mengganti URL endpoint
      body: {
        "id_menu": id_menu.text,
        "nama_menu": nama_menu.text,
        "harga": harga.text,
        "deskripsi": deskripsi.text,
      },
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    id_menu.text = widget.listData['id_menu'];
    nama_menu.text = widget.listData['nama_menu'];
    harga.text = widget.listData['harga'];
    deskripsi.text = widget.listData['deskripsi'];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Data",
          style: TextStyle(
              color: Colors.white), // Hanya teks "Edit Data" yang menjadi putih
        ),
        backgroundColor: Color.fromARGB(255, 54, 156, 240),
      ),
      body: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: nama_menu,
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
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    _update().then((value) {
                      if (value) {
                        final snackBar = SnackBar(
                          content: const Text('Data Diperbaharui!'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        final snackBar = SnackBar(
                          content: const Text('Data Gagal Diperbaharui!'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    });
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: ((context) => Menu())),
                    );
                  }
                },
                child: Text("Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
