import 'dart:convert';

import 'package:crudflut1/TambahMenu.dart';
import 'package:crudflut1/editmenu.dart';
import 'package:crudflut1/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Menu extends StatefulWidget {
  Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  List _listdata = [];

  bool _isloading = true;

  Future _getdata() async {
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.1.11/flutterapinewbed/crudflut/readmenu.php'));
      if (response.statusCode == 200) {
        print(response.body);
        final data = jsonDecode(response.body);
        setState(() {
          _listdata = data;
          _isloading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future _deletedata(String id_menu) async {
    try {
      final response = await http.post(
          Uri.parse('http://192.168.1.11/flutterapinewbed/deletemenu.php'),
          body: {
            "id_menu": id_menu,
          });
      if (response.statusCode == 200) {
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
          "Menu",
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => EditMenu(
                                    listData: {
                                      "id_menu": _listdata[index]['id_menu'],
                                      "nama_menu": _listdata[index]
                                          ['nama_menu'],
                                      "harga": _listdata[index]['harga'],
                                      "deskripsi": _listdata[index]
                                          ['deskripsi'],
                                    },
                                  ))));
                    },
                    child: ListTile(
                      title: Text(_listdata[index]['nama_menu']),
                      subtitle: Text(_listdata[index]['harga']),
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
                                                  _listdata[index]['id_menu'])
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
                                                      Menu())));
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
          Navigator.push(
              context, MaterialPageRoute(builder: ((context) => TambahMenu())));
        },
      ),
    );
  }
}
