import 'package:crudflut1/Reservasi.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TambahReservasi extends StatefulWidget {
  TambahReservasi({Key? key}) : super(key: key);

  @override
  State<TambahReservasi> createState() => _TambahReservasiState();
}

class _TambahReservasiState extends State<TambahReservasi> {
  final formKey = GlobalKey<FormState>();

  TextEditingController nama = TextEditingController();
  TextEditingController no_kamar = TextEditingController();
  TextEditingController checkInDate = TextEditingController();
  TextEditingController checkOutDate = TextEditingController();

  Future _simpan() async {
    final response = await http.post(
      Uri.parse('http://192.168.1.11/flutterapinewbed/createreservasi.php'),
      body: {
        "nama": nama.text,
        "no_kamar": no_kamar.text,
        "check_in_date": checkInDate.text,
        "check_out_date": checkOutDate.text,
      },
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        controller.text = pickedDate
            .toString(); // Sesuaikan format tanggal yang diinginkan di sini
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tambah Reservasi",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Isi formulir di bawah untuk menambahkan reservasi baru:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Form(
              key: formKey,
              child: Container(
                padding: EdgeInsets.all(10),
                child: ListView(
                  children: [
                    SizedBox(height: 10),
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
                    SizedBox(height: 10),
                    TextFormField(
                      controller: no_kamar,
                      decoration: InputDecoration(
                        hintText: "No Kamar",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "No Kamar Diisi Berdasarkan Pemesanan";
                        }
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: checkInDate,
                      onTap: () {
                        _selectDate(context, checkInDate);
                      },
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: "Tanggal Check In",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Input tanggal check in";
                        }
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: checkOutDate,
                      onTap: () {
                        _selectDate(context, checkOutDate);
                      },
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: "Tanggal Check Out",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Input Tanggal Check Out";
                        }
                      },
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          _simpan().then((value) {
                            if (value) {
                              final snackBar = SnackBar(
                                content: const Text('Data Disimpan!'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              final snackBar = SnackBar(
                                content: const Text('Data Gagal Disimpan!'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          });
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => Reservasi())));
                        }
                      },
                      child: Text("Simpan"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
