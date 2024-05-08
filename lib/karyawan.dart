import 'dart:convert';

import 'package:crudflut1/editkaryawan.dart';
import 'package:crudflut1/mainpage.dart';
import 'package:crudflut1/tambahKaryawan.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Karyawan extends StatefulWidget {
  Karyawan({Key? key}) : super(key: key);

  @override
  State<Karyawan> createState() => _KaryawanState();
}

class _KaryawanState extends State<Karyawan> {
  List _listdata = [];

  bool _isloading = true;

  Future _getdata() async {
    try {
      final respone = await http.get(Uri.parse(
          'http://192.168.1.11/flutterapinewbed/crudflut/readkaryawan.php'));
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

  Future _deletedata(String id_karyawan) async {
    try {
      final respone = await http.post(
          Uri.parse('http://192.168.1.11/flutterapinewbed/deletekaryawan.php'),
          body: {
            "nama_karyawan": id_karyawan,
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
          "Karyawan",
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
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Detail Karyawan"),
                            content: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "Nama: ${_listdata[index]['nama_karyawan']}"),
                                  Text(
                                      "Jabatan: ${_listdata[index]['jabatan']}"),
                                  Text("Email: ${_listdata[index]['email']}"),
                                  Text(
                                      "No Telepon: ${_listdata[index]['no_telepon']}"),
                                  Text("Alamat: ${_listdata[index]['alamat']}"),
                                  Text(
                                      "Tanggal Lahir: ${_listdata[index]['tanggal_lahir']}"),
                                  Text(
                                      "Jenis Kelamin: ${_listdata[index]['jenis_kelamin']}"),
                                  Text(
                                      "Tanggal Mulai: ${_listdata[index]['tanggal_mulai']}"),
                                  Text(
                                      "Status Pekerjaan: ${_listdata[index]['status_pekerjaan']}"),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Tutup'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditKaryawan(
                                        listData: {
                                          "id_karyawan": _listdata[index]
                                              ['id_karyawan'],
                                          "nama_karyawan": _listdata[index]
                                              ['nama_karyawan'],
                                          "email": _listdata[index]['email'],
                                          "no_telepon": _listdata[index]
                                              ['no_telepon'],
                                          "alamat": _listdata[index]['alamat'],
                                          "tanggal_lahir": _listdata[index]
                                              ['tanggal_lahir'],
                                          "jenis_kelamin": _listdata[index]
                                              ['jenis_kelamin'],
                                          "jabatan": _listdata[index]
                                              ['jabatan'],
                                          "tanggal_mulai": _listdata[index]
                                              ['tanggal_mulai'],
                                          "status_pekerjaan": _listdata[index]
                                              ['status_pekerjaan'],
                                        },
                                      ),
                                    ),
                                  );
                                },
                                child: Text('Edit'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: ListTile(
                      title: Text(_listdata[index]['nama_karyawan']),
                      subtitle: Text(_listdata[index]['jabatan']),
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
                                              _listdata[index]['nama_karyawan'])
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
                                          builder: ((context) => Karyawan()),
                                        ),
                                      );
                                    },
                                    child: Text("Hapus"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Batal"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.delete),
                      ),
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
            MaterialPageRoute(builder: (context) => TambahKaryawan()),
          );
        },
      ),
    );
  }
}
