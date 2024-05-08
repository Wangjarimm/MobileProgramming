import 'package:crudflut1/Karyawan.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TambahKaryawan extends StatefulWidget {
  TambahKaryawan({Key? key}) : super(key: key);

  @override
  State<TambahKaryawan> createState() => _TambahKaryawanState();
}

class _TambahKaryawanState extends State<TambahKaryawan> {
  final formKey = GlobalKey<FormState>();

  TextEditingController nama = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController no_telepon = TextEditingController();
  TextEditingController tanggal_lahir = TextEditingController();
  TextEditingController jabatan = TextEditingController();
  TextEditingController tanggal_mulai = TextEditingController();

  String selectedGender = 'Laki-laki'; // Default selected gender
  String selectedJobStatus = 'Penuh Waktu'; // Default selected job status

  Future _simpan() async {
    final response = await http.post(
      Uri.parse('http://192.168.1.11/flutterapinewbed/createkaryawan.php'),
      body: {
        "nama_karyawan": nama.text,
        "email": email.text,
        "no_telepon": no_telepon.text,
        "alamat": alamat.text,
        "tanggal_lahir": tanggal_lahir.text,
        "jenis_kelamin": selectedGender,
        "jabatan": jabatan.text,
        "tanggal_mulai": tanggal_mulai.text,
        "status_pekerjaan": selectedJobStatus,
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
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        controller.text = pickedDate.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tambah Karyawan",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(height: 10),
                TextFormField(
                  controller: nama,
                  decoration: InputDecoration(
                    hintText: 'Nama Karyawan',
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
                    hintText: 'Alamat',
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
                    hintText: 'Email',
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
                    hintText: 'No Telepon',
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
                GestureDetector(
                  onTap: () {
                    _selectDate(context, tanggal_lahir);
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: tanggal_lahir,
                      decoration: InputDecoration(
                        hintText: 'Tanggal Lahir',
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
                  ),
                ),
                SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: selectedGender,
                  onChanged: (newValue) {
                    setState(() {
                      selectedGender = newValue!;
                    });
                  },
                  items: <String>['Laki-laki', 'Perempuan']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    hintText: 'Jenis Kelamin',
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
                    hintText: 'Jabatan',
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
                GestureDetector(
                  onTap: () {
                    _selectDate(context, tanggal_mulai);
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: tanggal_mulai,
                      decoration: InputDecoration(
                        hintText: 'Tanggal Mulai',
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
                  ),
                ),
                SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: selectedJobStatus,
                  onChanged: (newValue) {
                    setState(() {
                      selectedJobStatus = newValue!;
                    });
                  },
                  items: <String>['Penuh Waktu', 'Paruh Waktu', 'Kontrak']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    hintText: 'Status Pekerjaan',
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
                      _simpan().then((value) {
                        if (value) {
                          final snackBar = SnackBar(
                            content: const Text('Data Disimpan!'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          final snackBar = SnackBar(
                            content: const Text('Data Gagal Disimpan!'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      });
                      // Reset all text controllers after saving
                      nama.clear();
                      alamat.clear();
                      email.clear();
                      no_telepon.clear();
                      tanggal_lahir.clear();
                      jabatan.clear();
                      tanggal_mulai.clear();
                      // Reset selected gender and job status
                      setState(() {
                        selectedGender = 'Laki-laki';
                        selectedJobStatus = 'Penuh Waktu';
                      });
                      // Navigate back to Karyawan page
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: ((context) => Karyawan())),
                      );
                    }
                  },
                  child: Text("Simpan"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
