import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ListMeusCarros("1"));
}

class ListMeusCarros extends StatefulWidget {
  final String documentId;
  ListMeusCarros(
    this.documentId, {
    Key key,
  }) : super(key: key);

  @override
  _ListMeusCarrosState createState() => _ListMeusCarrosState();
}

class _ListMeusCarrosState extends State<ListMeusCarros> {
  CollectionReference meusCarros =
      FirebaseFirestore.instance.collection('meus_carros');

  List<Map<String, dynamic>> data = <Map<String, dynamic>>[];

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('meus_carros')
        .get()
        .then((value) => setState(() {
              value.docs.map((e) => print(e.data())).toList();
            }));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CARROS',
      home: Scaffold(
        appBar: AppBar(
          title: Text('MEUS CARROS'),
        ),
        body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            var carro = data[index];
            return Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                  "Meu carro$index: ${carro['anoFabricacao']} ${carro['anoModelo']} ${carro['modelo']} ${carro['marca']} ${carro['placa']} "),
            );
          },
        ),
      ),
    );
  }
}
