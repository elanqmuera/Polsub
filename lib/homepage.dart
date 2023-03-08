import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:polsub/tambahdata.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> { 
  List _listdata = [];
  bool _loading = true;
  Future _getdata() async {
    try {
      final respone1 = await http
          .get(Uri.parse('http://10.104.11.190/flutterAPI/crudFlutter/read.php'));
      if (respone1.statusCode == 200) {
        final data = jsonDecode(respone1.body);
        setState(() {
          _listdata = data;
          _loading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _getdata();
    print(_listdata);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Bar'),
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _listdata.length,
              itemBuilder: ((context, index) {
                return Card(
                  margin: EdgeInsetsDirectional.only(top:5 , start: 5),
                  child: ListTile(
                    title: Text(_listdata[index]['nama']),
                   
                  ),
                );
              }),
            ),
      floatingActionButton: FloatingActionButton(
          child: Text(
            '+',
            style: TextStyle(fontSize: 25),
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => tambahdata()));
          }),
    );
  }
}
