// ignore_for_file: curly_braces_in_flow_control_structures, prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DashboardScreen extends StatefulWidget {
  // const DashboardScreen({super.key});

  final username = Get.arguments;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool load = true;

  TextEditingController _editingController = TextEditingController();
  TextEditingController _addController = TextEditingController();

  Future<void> _add(String con) async {
    try {
      _addController.clear();
      final url =
          Uri.parse("https://taskcon-production.up.railway.app/addContact");
      final body = json.encode({"username": widget.username, "contact": con});
      var headers = {'Content-Type': 'application/json'};
      final response = await http.post(url, headers: headers, body: body);

      final data = json.decode(response.body);
      setState(() {
        load = true;
      });
    } catch (error) {
      throw (error);
    }
  }

  Future<void> _edit(String prev, String con) async {
    try {
      _editingController.clear();
      final url =
          Uri.parse("https://taskcon-production.up.railway.app/editContact");
      final body =
          json.encode({"username": widget.username, "prev": prev, "cur": con});
      var headers = {'Content-Type': 'application/json'};
      final response = await http.post(url, headers: headers, body: body);

      final data = json.decode(response.body);
      setState(() {
        load = true;
      });
    } catch (error) {
      throw (error);
    }
  }

  Future<void> _delete(String con) async {
    try {
      final url =
          Uri.parse("https://taskcon-production.up.railway.app/deleteContact");
      final body = json.encode({"username": widget.username, "con": con});
      var headers = {'Content-Type': 'application/json'};
      final response = await http.post(url, headers: headers, body: body);

      final data = json.decode(response.body);
      setState(() {
        load = true;
      });
    } catch (error) {
      throw (error);
    }
  }

  Future<List<dynamic>> _fetchList() async {
    try {
      if (load) {
        final url =
            Uri.parse("https://taskcon-production.up.railway.app/getContacts");
        final body = json.encode({"username": widget.username});
        var headers = {'Content-Type': 'application/json'};
        final response = await http.post(url, headers: headers, body: body);

        final data = json.decode(response.body);
        load = false;
        return data;
      } else
        return [];
    } catch (error) {
      throw (error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Contact List"),
          foregroundColor: Colors.white,
          backgroundColor: Color.fromRGBO(99, 68, 171, 0.8),
          actions: [
            IconButton(
              onPressed: () {
                Get.defaultDialog(
                    title: 'ADD Contact',
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: _addController,
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          decoration: InputDecoration(
                              labelText: 'Contact',
                              hintMaxLines: 1,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.green, width: 4.0))),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await _add(_addController.text);
                            Get.back();
                          },
                          child: Text(
                            'ADD Contact',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.0),
                          ),
                          // color: Colors.redAccent,
                        )
                      ],
                    ),
                    radius: 10.0);
              },
              icon: Icon(Icons.add),
            )
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: FutureBuilder(
            future: _fetchList(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data?.length == 0) {
                  return Center(
                    child: Text("No Contact List"),
                  );
                } else
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: ((context, index) {
                      return Container(
                          height: 80,
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(vertical: 5),
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.blue.shade100,
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            children: [
                              Expanded(child: Text(snapshot.data![index])),
                              ElevatedButton(
                                  onPressed: () {
                                    Get.defaultDialog(
                                        title: 'Edit Contact',
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextFormField(
                                              controller: _editingController,
                                              keyboardType: TextInputType.text,
                                              maxLines: 1,
                                              decoration: InputDecoration(
                                                  labelText: 'Contact',
                                                  hintMaxLines: 1,
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.green,
                                                          width: 4.0))),
                                            ),
                                            SizedBox(
                                              height: 30.0,
                                            ),
                                            ElevatedButton(
                                              onPressed: () async {
                                                await _edit(
                                                    snapshot.data![index],
                                                    _editingController.text);
                                                Get.back();
                                              },
                                              child: Text(
                                                'Edit Contact',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16.0),
                                              ),
                                              // color: Colors.redAccent,
                                            )
                                          ],
                                        ),
                                        radius: 10.0);
                                  },
                                  child: Text("Edit")),
                              SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    _delete(snapshot.data?[index]);
                                  },
                                  child: Text("Delete")),
                            ],
                          ));
                    }),
                  );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ));
  }
}
