import 'package:crudflut1/datakamar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditKamar extends StatefulWidget {
  final Map listData;

  EditKamar({Key? key, required this.listData}) : super(key: key);

  @override
  State<EditKamar> createState() => _EditKamarState();
}

class _EditKamarState extends State<EditKamar> {
  final formKey = GlobalKey<FormState>();

  TextEditingController id_kamar = TextEditingController();
  TextEditingController no_kamar = TextEditingController();
  TextEditingController tipe_kamar = TextEditingController();
  TextEditingController tarif = TextEditingController();
  TextEditingController status = TextEditingController();
  Future _update() async {
    final respone = await http.post(
        Uri.parse('http://192.168.1.11/flutterapi/crudflut/editkamar.php'),
        body: {
          "id_kamar": id_kamar.text,
          "no_kamar": no_kamar.text,
          "tipe_kamar": tipe_kamar.text,
          "tarif": tarif.text,
          "status": status.text,
        });
    if (respone.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    id_kamar.text = widget.listData['id_kamar'];
    no_kamar.text = widget.listData['no_kamar'];
    tipe_kamar.text = widget.listData['tipe_kamar'];
    tarif.text = widget.listData['tarif'];
    status.text = widget.listData['status'];
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
                  controller: no_kamar,
                  decoration: InputDecoration(
                    hintText: "Nomor Kamar",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Nomor Kamar tidak boleh kosong!";
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: tipe_kamar,
                  decoration: InputDecoration(
                    hintText: "Tipe Kamar",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Tipe Kamar tidak boleh kosong!";
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: tarif,
                  decoration: InputDecoration(
                    hintText: "Tarif",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Tarif tidak boleh kosong!";
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: status,
                  decoration: InputDecoration(
                    hintText: "Status",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Status tidak boleh kosong!";
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
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: ((context) => Kamar())));
                      }
                    },
                    child: Text("update")),
              ],
            ),
          )),
    );
  }
}
