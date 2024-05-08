import 'dart:convert';
import 'package:crudflut1/datakamar.dart';
import 'package:crudflut1/editkamar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchKamar extends StatefulWidget {
  SearchKamar({Key? key}) : super(key: key);

  @override
  State<SearchKamar> createState() => _SearchKamarState();
}

class _SearchKamarState extends State<SearchKamar> {
  List _listdata = [];
  List _filteredData = [];
  bool _isloading = true;

  TextEditingController _searchController = TextEditingController();

  Future _getdata() async {
    try {
      final response = await http.get(
          Uri.parse('http://192.168.1.11/flutterapi/crudflut/readkamar.php'));
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
              element['no_kamar'].toString().toLowerCase().contains(query.toLowerCase()) ||
              element['tipe_kamar'].toString().toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Kamar",
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
                      hintText: "Search Kamar...",
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
                                builder: ((context) => EditKamar(
                                  listData: {
                                    "id_kamar": _filteredData[index]['id_kamar'],
                                    "no_kamar": _filteredData[index]['no_kamar'],
                                    "tipe_kamar": _filteredData[index]['tipe_kamar'],
                                    "tarif": _filteredData[index]['tarif'],
                                    "status": _filteredData[index]['status'],
                                  },
                                )),
                              ),
                            );
                          },
                          child: ListTile(
                            title: Text(_filteredData[index]['no_kamar']),
                            subtitle: Text(_filteredData[index]['tipe_kamar']),
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
              context, MaterialPageRoute(builder: ((context) => Kamar())));
        },
      ),
    );
  }
}
