import 'package:crudflut1/datapelanggan.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TambahPelanggan extends StatefulWidget {
  TambahPelanggan({Key? key}) : super(key: key);

  @override
  State<TambahPelanggan> createState() => _TambahPelangganState();
}

class _TambahPelangganState extends State<TambahPelanggan> {
  final formKey = GlobalKey<FormState>();

  TextEditingController nama = TextEditingController();
  TextEditingController no_telepon = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController email = TextEditingController();
  Future _simpan() async {
    final respone = await http.post(
        Uri.parse(
            'http://192.168.1.11/flutterapi/crudflut/createpelanggan.php'),
        body: {
          "nama": nama.text,
          "no_telepon": no_telepon.text,
          "alamat": alamat.text,
          "email": email.text,
        });
    if (respone.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tambah Pelanggan",
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
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: nama,
                  decoration: InputDecoration(
                    hintText: "Nama",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Nama tidak boleh kosong!";
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: no_telepon,
                  decoration: InputDecoration(
                    hintText: "No Telepon",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "No Telepon tidak boleh kosong!";
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: alamat,
                  decoration: InputDecoration(
                    hintText: "Alamat",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Alamat tidak boleh kosong!";
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                    hintText: "Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Email tidak boleh kosong!";
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        _simpan().then((value) {
                          if (value) {
                            final snackBar = SnackBar(
                              content: const Text('Data Disimpan!'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            final snackBar = SnackBar(
                              content: const Text('Data Gagal Disimpan!'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        });
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => Pelanggan())));
                      }
                    },
                    child: Text("simpan"))
              ],
            ),
          )),
    );
  }
}
