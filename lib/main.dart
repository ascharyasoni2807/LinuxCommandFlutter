import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String command;
  var responsedata;
  methodrun(command) async {
    var url = "http://192.168.142.130/cgi-bin/command.py?x=${command}";
    var r = await http.get(url);
    setState(() {
      responsedata = r.body;
    });
    print(responsedata);
  }

  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  savedata() async {
    return await _firebaseFirestore
        .collection('LinuxCommands')
        .add({'$command': '$responsedata'});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.brown,
              title: Text('Command Run'),
            ),
            body: Container(
                width: double.infinity,
                height: double.infinity,
                // color: Colors.blue,
                child: (SingleChildScrollView(
                  child: Container(
                      child: Column(
                    children: <Widget>[
                      Container(
                          width: 500,
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            "CHECK LINUX COMMAND",
                            style: TextStyle(fontSize: 30),
                          )),
                      SizedBox(height: 15),
                      Container(
                        width: 300,
                        margin:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 4),
                        child: TextField(
                          decoration: InputDecoration(
                              labelText: "Enter the Command",
                              hintText: "Enter command",
                              border: OutlineInputBorder()),
                          onChanged: (val) {
                            command = val;
                          },
                        ),
                      ),
                      RaisedButton(
                        child: Text("Run Command"),
                        onPressed: () {
                          //print(command);
                          methodrun(command);
                          savedata();
                        },
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                        height: 180,
                        //  color: Colors.black,
                        width: 400,
                        child: Text(
                          ' ${responsedata} ',
                          style: TextStyle(color: Colors.white),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(color: Colors.black)),
                      ),
                    ],
                  )),
                )
                    // child: Container(
                    //   //margin: EdgeInsets.only(top: 20),
                    //   alignment: Alignment.topCenter,
                    //   height: double.infinity,
                    //   width: double.infinity,
                    //   color: Colors.black,
                    //   child: SingleChildScrollView(
                    //     child: Column(
                    //       children: <Widget>[
                    // Container(
                    //   height: 100,
                    //   width: 200,
                    //   margin: EdgeInsets.only(top: 7),
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     image: DecorationImage(
                    //       image: AssetImage('images/linux.jpg'),
                    //       fit: BoxFit.cover,
                    //     ),
                    //     borderRadius: BorderRadius.circular(30),
                    //   ),
                    // ),

                    // margin: EdgeInsets.symmetric(vertical: 15, horizontal: 4),
                    // child: TextField(
                    //   onChanged: (val) {
                    //     // command = val;
                    //   },
                    //     decoration: InputDecoration(
                    //         hintStyle: TextStyle(
                    //             //textBaseline: UnderlineTabIndicator,
                    //             color: Colors.black,
                    //             fontWeight: FontWeight.bold,
                    //             fontSize: 20),
                    //         hintText: "Enter Linux Command",
                    //         border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(30),
                    //         )),
                    //     textAlign: TextAlign.center,
                    //   ),
                    // ),
                    // Card(
                    //     child: FlatButton(
                    //   onPressed: () {
                    //     //   web(command);
                    //   },
                    //   child: Text(
                    //     "Run Command",
                    //     style: TextStyle(
                    //       color: Colors.black,
                    //       fontSize: 20,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // )),
                    // Container(
                    //     width: double.infinity,
                    //     child: Card(
                    //       color: Colors.black,
                    //       elevation: 20,
                    //       shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.only(
                    //               topLeft: Radius.circular(00),
                    //               bottomLeft: Radius.circular(10),
                    //               bottomRight: Radius.circular(10),
                    //               topRight: Radius.circular(00)),
                    //           side: BorderSide(width: 2, color: Colors.black)),
                    //   child: Text(
                    //   "${webdata}" ?? "                 ",
                    //   style: TextStyle(
                    //       height: 3,
                    //       color: Colors.white,
                    //       fontSize: 20,
                    //       fontFamily: 'Sriracha'),
                    // ),
                    // )),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    //backgroundColor: Colors.yellow[300],
                    //),
                    ))));
  }
}
