import 'package:crudflut1/reservasi.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditReservasi extends StatefulWidget {
  final Map listData;

  EditReservasi({Key? key, required this.listData}) : super(key: key);

  @override
  State<EditReservasi> createState() => _EditReservasiState();
}

class _EditReservasiState extends State<EditReservasi> {
  final formKey = GlobalKey<FormState>();

  TextEditingController id_reserv = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController no_kamar = TextEditingController();
  TextEditingController CheckInDate = TextEditingController();
  TextEditingController CheckOutDate = TextEditingController();
  Future _update() async {
    final respone = await http.post(
        Uri.parse('http://192.168.1.11/flutterapinewbed/editreservasi.php'),
        body: {
          "id_reserv": id_reserv.text,
          "nama": nama.text,
          "no_kamar": no_kamar.text,
          "check_in_date": CheckInDate.text,
          "check_out_date": CheckOutDate.text
        });
    if (respone.statusCode == 200) {
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
    id_reserv.text = widget.listData['id_reserv'];
    nama.text = widget.listData['nama'];
    no_kamar.text = widget.listData['no_kamar'];
    CheckInDate.text = widget.listData['check_in_date'];
    CheckOutDate.text = widget.listData['check_out_date'];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Data Reservasi",
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
                Text(
                  "Nama:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: nama,
                  decoration: InputDecoration(
                    hintText: "Masukkan Nama",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Nama tidak boleh kosong!";
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Nomor Kamar:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: no_kamar,
                  decoration: InputDecoration(
                    hintText: "Masukkan Nomor Kamar",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Nomor Kamar diisi apabila pindah kamar";
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Tanggal Check In:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: CheckInDate,
                  onTap: () {
                    _selectDate(context, CheckInDate);
                  },
                  decoration: InputDecoration(
                    hintText: "Pilih Tanggal Check In",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Inputkan tanggal check in";
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Tanggal Check Out:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: CheckOutDate,
                  onTap: () {
                    _selectDate(context, CheckOutDate);
                  },
                  decoration: InputDecoration(
                    hintText: "Pilih Tanggal Check Out",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Inputkan tanggal check out";
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
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => Reservasi())));
                      }
                    },
                    child: Text("Update")),
              ],
            ),
          )),
    );
  }
}
