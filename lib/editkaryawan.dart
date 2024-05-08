import 'package:crudflut1/karyawan.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditKaryawan extends StatefulWidget {
  final Map listData;

  EditKaryawan({Key? key, required this.listData}) : super(key: key);

  @override
  State<EditKaryawan> createState() => _EditKaryawanState();
}

class _EditKaryawanState extends State<EditKaryawan> {
  final formKey = GlobalKey<FormState>();

  TextEditingController id_karyawan = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController no_telepon = TextEditingController();
  TextEditingController tanggal_lahir = TextEditingController();
  String selectedjenis_kelamin = '';
  TextEditingController jabatan = TextEditingController();
  TextEditingController tanggal_mulai = TextEditingController();
  String selectedStatusPekerjaan = '';

  Future _update() async {
    final respone = await http.post(
        Uri.parse('http://192.168.1.11/flutterapinewbed/editkaryawan.php'),
        body: {
          "id_karyawan": id_karyawan.text,
          "nama_karyawan": nama.text,
          "email": email.text,
          "no_telepon": no_telepon.text,
          "alamat": alamat.text,
          "tanggal_lahir": tanggal_lahir.text,
          "jenis_kelamin": selectedjenis_kelamin,
          "jabatan": jabatan.text,
          "tanggal_mulai": tanggal_mulai.text,
          "status_pekerjaan": selectedStatusPekerjaan,
        });
    if (respone.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    id_karyawan.text = widget.listData['id_karyawan'];
    nama.text = widget.listData['nama_karyawan'];
    alamat.text = widget.listData['alamat'];
    email.text = widget.listData['email'];
    no_telepon.text = widget.listData['no_telepon'];
    tanggal_lahir.text = widget.listData['tanggal_lahir'];
    selectedjenis_kelamin = widget.listData['jenis_kelamin'];
    jabatan.text = widget.listData['jabatan'];
    tanggal_mulai.text = widget.listData['tanggal_mulai'];
    selectedStatusPekerjaan = widget.listData['status_pekerjaan'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Data",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 54, 156, 240),
      ),
      body: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(height: 10),
              TextFormField(
                controller: nama,
                decoration: InputDecoration(
                  labelText: 'Nama Karyawan',
                  hintText: 'Masukkan Nama Karyawan',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Nama Karyawan tidak boleh kosong!";
                  }
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: alamat,
                decoration: InputDecoration(
                  labelText: 'Alamat',
                  hintText: 'Masukkan Alamat',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Alamat tidak boleh kosong!";
                  }
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: email,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Masukkan Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Email tidak boleh kosong!";
                  }
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: no_telepon,
                decoration: InputDecoration(
                  labelText: 'No Telepon',
                  hintText: 'Masukkan No Telepon',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "No Telepon tidak boleh kosong!";
                  }
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: tanggal_lahir,
                decoration: InputDecoration(
                  labelText: 'Tanggal Lahir',
                  hintText: 'Masukkan Tanggal Lahir',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Tanggal Lahir tidak boleh kosong!";
                  }
                },
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedjenis_kelamin,
                items: <String>['Laki-laki', 'Perempuan']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedjenis_kelamin = newValue!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Jenis Kelamin',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Jenis Kelamin tidak boleh kosong!";
                  }
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: jabatan,
                decoration: InputDecoration(
                  labelText: 'Jabatan',
                  hintText: 'Masukkan Jabatan',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Jabatan tidak boleh kosong!";
                  }
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: tanggal_mulai,
                decoration: InputDecoration(
                  labelText: 'Tanggal Mulai',
                  hintText: 'Masukkan Tanggal Mulai',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Tanggal Mulai tidak boleh kosong!";
                  }
                },
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedStatusPekerjaan,
                items: <String>['Penuh Waktu', 'Paruh Waktu', 'Kontrak']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedStatusPekerjaan = newValue!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Status Pekerjaan',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Status Pekerjaan tidak boleh kosong!";
                  }
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    _update().then((value) {
                      if (value) {
                        final snackBar = SnackBar(
                          content: const Text('Data Diperbaharui!'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        final snackBar = SnackBar(
                          content: const Text('Data Gagal Diperbaharui!'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    });
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: ((context) => Karyawan())),
                    );
                  }
                },
                child: Text("Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
