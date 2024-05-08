import 'dart:convert';
import 'package:crudflut1/datapelanggan.dart';
import 'package:crudflut1/editPelanggan.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchPelanggan extends StatefulWidget {
  SearchPelanggan({Key? key}) : super(key: key);

  @override
  State<SearchPelanggan> createState() => _SearchPelangganState();
}

class _SearchPelangganState extends State<SearchPelanggan> {
  List _listdata = [];
  List _filteredData = [];
  bool _isloading = true;

  TextEditingController _searchController = TextEditingController();

  Future _getdata() async {
    try {
      final response = await http.get(
          Uri.parse('http://192.168.1.11/flutterapi/crudflut/read.php'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _listdata = data;
          _filteredData = _listdata;
          _isloading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _getdata();
    super.initState();
  }

  void _filterData(String query) {
    setState(() {
      _filteredData = _listdata
          .where((element) =>
              element['nama'].toString().toLowerCase().contains(query.toLowerCase()) ||
              element['no_telepon'].toString().toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Pelanggan",
        style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: _isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: "Search",
                      hintText: "Search Pelanggan...",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onChanged: (value) {
                      _filterData(value);
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _filteredData.length,
                    itemBuilder: ((context, index) {
                      return Card(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => EditPelanggan(
                                  listData: {
                                    "id_pelanggan": _filteredData[index]['id_pelanggan'],
                                    "nama": _filteredData[index]['nama'],
                                    "no_telepon": _filteredData[index]['no_telepon'],
                                    "alamat": _filteredData[index]['alamat'],
                                    "email": _filteredData[index]['email'],
                                  },
                                )),
                              ),
                            );
                          },
                          child: ListTile(
                            title: Text(_filteredData[index]['nama']),
                            subtitle: Text(_filteredData[index]['no_telepon']),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        child: Text(
          "+",
          style: TextStyle(fontSize: 20),
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: ((context) => Pelanggan())));
        },
      ),
    );
  }
}
