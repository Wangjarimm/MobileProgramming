import 'dart:convert';

import 'package:crudflut1/editreservasi.dart';
import 'package:crudflut1/mainpage.dart';
import 'package:crudflut1/tambahreservasi.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Reservasi extends StatefulWidget {
  Reservasi({Key? key}) : super(key: key);

  @override
  State<Reservasi> createState() => _ReservasiState();
}

class _ReservasiState extends State<Reservasi> {
  List _listdata = [];
  bool _isloading = true;

  Future _getdata() async {
    try {
      final respone = await http.get(
          Uri.parse('http://192.168.1.11/flutterapinewbed/crudflut/read.php'));
      if (respone.statusCode == 200) {
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

  Future _deletedata(String id_reserv) async {
    try {
      final respone = await http.post(
        Uri.parse('http://192.168.1.11/flutterapinewbed/deleteReservasi.php'),
        body: {"nama": id_reserv},
      );
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
          "Reservasi",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MainPage()),
            );
          },
        ),
      ),
      body: _isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _listdata.length,
              itemBuilder: ((context, index) {
                return Card(
                  child: ListTile(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Detail Reservasi"),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Nama: ${_listdata[index]['nama']}"),
                                Text(
                                    "Nomor Kamar: ${_listdata[index]['no_kamar']}"),
                                Text(
                                    "Tanggal Check In: ${_listdata[index]['check_in_date']}"),
                                Text(
                                    "Tanggal Check Out: ${_listdata[index]['check_out_date']}"),
                              ],
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    title: Text(_listdata[index]['nama']),
                    subtitle: Text(_listdata[index]['no_kamar']),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditReservasi(
                                  listData: {
                                    "id_reserv": _listdata[index]['id_reserv'],
                                    "nama": _listdata[index]['nama'],
                                    "no_kamar": _listdata[index]['no_kamar'],
                                    "check_in_date": _listdata[index]
                                        ['check_in_date'],
                                    "check_out_date": _listdata[index]
                                        ['check_out_date'],
                                  },
                                ),
                              ),
                            );
                          },
                          icon: Icon(Icons.edit),
                        ),
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
                                        _deletedata(_listdata[index]['nama'])
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
                                              builder: (context) =>
                                                  Reservasi()),
                                        );
                                      },
                                      child: Text("Hapus"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Batal"),
                                    )
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
                );
              }),
            ),
      floatingActionButton: FloatingActionButton(
        child: Text(
          "+",
          style: TextStyle(fontSize: 20),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TambahReservasi()),
          );
        },
      ),
    );
  }
}
