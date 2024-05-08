import 'package:crudflut1/datapelanggan.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditPelanggan extends StatefulWidget {
  final Map listData;

  EditPelanggan({Key? key, required this.listData}) : super(key: key);

  @override
  State<EditPelanggan> createState() => _EditPelangganState();
}

class _EditPelangganState extends State<EditPelanggan> {
  final formKey = GlobalKey<FormState>();

  TextEditingController id_pelanggan = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController no_telepon = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController email = TextEditingController();
  Future _update() async {
    final respone = await http.post(
        Uri.parse('http://192.168.1.11/flutterapi/crudflut/editpelanggan.php'),
        body: {
          "id_pelanggan": id_pelanggan.text,
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
    id_pelanggan.text = widget.listData['id_pelanggan'];
    nama.text = widget.listData['nama'];
    no_telepon.text = widget.listData['no_telepon'];
    alamat.text = widget.listData['alamat'];
    email.text = widget.listData['email'];
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
                        _update().then((value) {
                          if (value) {
                            final snackBar = SnackBar(
                              content: const Text('Data Diperbaharui!'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            final snackBar = SnackBar(
                              content: const Text('Data Gagal Diperbaharui!'),
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
                    child: Text("update")),
              ],
            ),
          )),
    );
  }
}
