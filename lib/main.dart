// ignore_for_file: prefer_const_constructors, prefer_final_fields, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:lab_mis/widgets/createNewElement.dart';

import './model/termin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Upcoming exams'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Termin> _termini = [
    Termin(
        id: "1",
        ime: "Mobile information systems",
        datum: "15.01.2023",
        vreme: "10:00h"),
    Termin(
        id: "2",
        ime: "Management information systems",
        datum: "25.01.2023",
        vreme: "15:30h"),
    Termin(
        id: "3",
        ime: "Design of human-computer interaction",
        datum: "16.01.2023",
        vreme: "8:00h")
  ];

  void _showModal(BuildContext ctx){
    showModalBottomSheet(
      context: ctx, 
      builder: (_){
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: createNewElement(_addNewTermin),
        );
      }
    );
  }

  void _addNewTermin(Termin termin){
    setState(() {
      _termini.add(termin);
    });
  }

  void _deleteTermin(String id){
    setState(() {
      _termini.removeWhere((termin) => termin.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_box_outlined),
            onPressed: () => _showModal(context))
        ]
        ,
      ),
      body: Center(
          child: _termini.isEmpty
              ? Text("No exams scheduled")
              : ListView.builder(
                  itemCount: _termini.length,
                  itemBuilder: (ctx, index) {
                    return Card(
                      elevation: 2,
                      margin: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                      child: ListTile(
                        tileColor: Colors.green[100],
                        title: Text(
                          _termini[index].ime,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          _termini[index].datum + " | " + _termini[index].vreme,
                          style: TextStyle(color: Colors.grey),
                        ),
                        trailing: IconButton(
                          onPressed: () => _deleteTermin(_termini[index].id),
                          icon: Icon(Icons.delete_outline)),
                      ),
                    );
                  },
                )
              ),
    );
  }
}
