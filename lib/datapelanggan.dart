import 'dart:convert';

import 'package:crudflut1/editpelanggan.dart';
import 'package:crudflut1/mainpage.dart';
import 'package:crudflut1/searchpelanggan.dart';
import 'package:crudflut1/tambahpelanggan.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Pelanggan extends StatefulWidget {
  Pelanggan({Key? key}) : super(key: key);

  @override
  State<Pelanggan> createState() => _PelangganState();
}

class _PelangganState extends State<Pelanggan> {
  List _listdata = [];

  bool _isloading = true;

  Future _getdata() async {
    try {
      final respone = await http.get(Uri.parse(
          'http://192.168.1.11/flutterapinewbed/crudflut/pelanggan/read.php'));
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

  Future _deletedata(String id_pelanggan) async {
    try {
      final respone = await http.post(
          Uri.parse(
              'http://192.168.1.11/flutterapinewbed/crudflut/pelanggan/deletepelanggan.php'),
          body: {
            "nama": id_pelanggan,
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
          "Pelanggan",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Mengarahkan kembali ke halaman utama (MainPage) saat tombol kembali ditekan
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MainPage()),
            );
          },
        ),
        actions: [
          // Menambahkan tombol untuk navigasi ke halaman pencarian
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchPelanggan()),
              );
            },
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
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
                              builder: ((context) => EditPelanggan(
                                    listData: {
                                      "id_pelanggan": _listdata[index]
                                          ['id_pelanggan'],
                                      "nama": _listdata[index]['nama'],
                                      "no_telepon": _listdata[index]
                                          ['no_telepon'],
                                      "alamat": _listdata[index]['alamat'],
                                      "email": _listdata[index]['email'],
                                    },
                                  ))));
                    },
                    child: ListTile(
                      title: Text(_listdata[index]['nama']),
                      subtitle: Text(_listdata[index]['no_telepon']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Ikon untuk menavigasi ke halaman EditPelanggan
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => EditPelanggan(
                                            listData: {
                                              "id_pelanggan": _listdata[index]
                                                  ['id_pelanggan'],
                                              "nama": _listdata[index]['nama'],
                                              "no_telepon": _listdata[index]
                                                  ['no_telepon'],
                                              "alamat": _listdata[index]
                                                  ['alamat'],
                                              "email": _listdata[index]
                                                  ['email'],
                                            },
                                          ))));
                            },
                            icon: Icon(Icons.edit),
                          ),
                          // Ikon untuk menampilkan detail data dalam dialog pop-up
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(_listdata[index]['nama']),
                                    content: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                            "No Telepon: ${_listdata[index]['no_telepon']}"),
                                        Text(
                                            "Alamat: ${_listdata[index]['alamat']}"),
                                        Text(
                                            "Email: ${_listdata[index]['email']}"),
                                      ],
                                    ),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Tutup")),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: Icon(Icons.info),
                          ),
                          // Ikon untuk menghapus data
                          IconButton(
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
                                                    _listdata[index]['nama'])
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
                                                        Pelanggan())));
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
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
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
              MaterialPageRoute(builder: ((context) => TambahPelanggan())));
        },
      ),
    );
  }
}
