import 'dart:convert';

import 'package:crudflut1/editkamar.dart';
import 'package:crudflut1/searchkamar.dart';
import 'package:crudflut1/tambahkamar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Kamar extends StatefulWidget {
  Kamar({Key? key}) : super(key: key);

  @override
  State<Kamar> createState() => _KamarState();
}

class _KamarState extends State<Kamar> {
  List _listdata = [];

  bool _isloading = true;

  Future _getdata() async {
    try {
      final respone = await http.get(
          Uri.parse('http://192.168.1.11/flutterapi/crudflut/readkamar.php'));
      if (respone.statusCode == 200) {
        print(respone.body);
        final data = jsonDecode(respone.body);
        setState(() {
          _listdata = data;
          _isloading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future _deletedata(String id_kamar) async {
    try {
      final respone = await http.post(
          Uri.parse('http://192.168.1.11/flutterapi/crudflut/deletekamar.php'),
          body: {
            "no_kamar": id_kamar,
          });
      if (respone.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Kamar",
          style: TextStyle(color: Colors.white),
        ), // Mengubah judul menjadi "Kamar"
        backgroundColor: Colors.blue,
        actions: [
          // Menambahkan tombol untuk navigasi ke halaman pencarian
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchKamar()),
              );
            },
            icon: Icon(Icons.search, color: Colors.white),
          ),
        ],
      ),
      body: _isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _listdata.length,
              itemBuilder: ((context, index) {
                return Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => EditKamar(
                                    listData: {
                                      "id_kamar": _listdata[index]['id_kamar'],
                                      "no_kamar": _listdata[index]['no_kamar'],
                                      "tipe_kamar": _listdata[index]
                                          ['tipe_kamar'],
                                      "tarif": _listdata[index]['tarif'],
                                      "status": _listdata[index]['status'],
                                    },
                                  ))));
                    },
                    child: ListTile(
                      title: Text(_listdata[index]['no_kamar']),
                      subtitle: Text(_listdata[index]['tipe_kamar']),
                      trailing: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text("Yakin Menghapus Data?"),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          _deletedata(
                                                  _listdata[index]['no_kamar'])
                                              .then((value) {
                                            if (value) {
                                              final snackBar = SnackBar(
                                                content: const Text(
                                                    'Data Berhasil Dihapus!'),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            } else {
                                              final snackBar = SnackBar(
                                                content: const Text(
                                                    'Data Gagal Dihapus!'),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            }
                                          });
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: ((context) =>
                                                      Kamar())));
                                        },
                                        child: Text("Hapus")),
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Batal"))
                                  ],
                                );
                              },
                            );
                          },
                          icon: Icon(Icons.delete)),
                    ),
                  ),
                );
              })),
      floatingActionButton: FloatingActionButton(
        child: Text(
          "+",
          style: TextStyle(fontSize: 20),
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => TambahKamar())));
        },
      ),
    );
  }
}
