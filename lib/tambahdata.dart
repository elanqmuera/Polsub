import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:polsub/homepage.dart';

class tambahdata extends StatefulWidget {
  const tambahdata({super.key});
 
  @override
  State<tambahdata> createState() => _tambahdataState();
}

class _tambahdataState extends State<tambahdata> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nim = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController alamat = TextEditingController();
  Future _simpan() async {
    final respone = await http.post(
        Uri.parse('http://10.104.11.190/flutterAPI/crudFlutter/create.php'),
        body: {
          'nim': nim.text,
          'nama': nama.text,
          'alamat': alamat.text,
        });
    if (respone.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah data ieumah nya'),
      ),
      body: Form(
          key: formKey,
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                TextFormField(
                  controller: nim,
                  decoration: InputDecoration(
                    hintText: 'Nim',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Nim tidak boleh kosong";
                      ;
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: nama,
                  decoration: InputDecoration(
                      hintText: 'Nama',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Nama tidak boleh kosong";
                      ;
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: alamat,
                  decoration: InputDecoration(
                      hintText: 'Alamat',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Alamat tidak boleh kosong";
                      ;
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
                        _simpan().then((value) {
                          if (value) {
                            final snackBar = SnackBar(
                              content: const Text('Data Berhasil Di Simpan'),
                            );
                                 ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          } else {
                            final snackBar = SnackBar(
                              content: const Text('Data tidak Berhasil Di Simpan')
                              
                            );
                                 ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                        });
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => homepage()), (route) => false);
                      }
                    },
                    child: Text('Simpannya euy'))
              ],
            ),
          )),
    );
  }
}
