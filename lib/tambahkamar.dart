import 'package:crudflut1/datakamar.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class TambahKamar extends StatefulWidget {
  TambahKamar({Key? key}) : super(key: key);

  @override
  State<TambahKamar> createState() => _TambahKamarState();
}

class _TambahKamarState extends State<TambahKamar> {

  final formKey = GlobalKey<FormState>();

  TextEditingController no_kamar = TextEditingController();
  TextEditingController tipe_kamar= TextEditingController();
  TextEditingController tarif = TextEditingController();
  TextEditingController status = TextEditingController();
  Future _simpan() async {
    final respone = await http.post(
      Uri.parse('http://192.168.1.11/flutterapi/crudflut/createkamar.php'),
      body: {
        "no_kamar" : no_kamar.text,
        "tipe_kamar" : tipe_kamar.text,
        "tarif" : tarif.text,
        "status" : status.text,
      }
    );
    if (respone.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah kamar",
        style: TextStyle(color: Colors.white
          ),
        ),
        backgroundColor: Colors.blue,
        
      ),
      body: Form(
        key: formKey,
        child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(height: 10,),
            TextFormField(
              controller: no_kamar,
              decoration: InputDecoration(
                hintText: "Nomor Kamar",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15)
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Nomor kamar tidak boleh kosong!" ;
                }
              },
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: tipe_kamar,
              decoration: InputDecoration(
                hintText: "Tipe Kamar",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15)
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Tipe Kamar tidak boleh kosong!" ;
                }
              },
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: tarif,
              decoration: InputDecoration(
                hintText: "Tarif",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15)
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Tarif tidak boleh kosong!" ;
                }
              },
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: status,
              decoration: InputDecoration(
                hintText: "Status",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15)
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Status tidak boleh kosong!" ;
                }
              },
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                )
              ),
              onPressed: (){
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
                    context, MaterialPageRoute(
                      builder: ((context) => Kamar()))
                  );
                }
              }, 
              child: Text("simpan"))
          ],
        ),
      )),
    );
  }
}
