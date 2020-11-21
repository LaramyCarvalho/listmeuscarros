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
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CARROS',
      home: Scaffold(
        appBar: AppBar(
          title: Text('MEUS CARROS'),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            var result1 = await meusCarros.doc('1').get();
            print(result1.data());
            var result = await meusCarros.get();
            var idCarros = result.docs.map((e) => e.id).toList();
            print(idCarros);
            var carros = <Map<String, dynamic>>[];
            for (var id in idCarros) {
              var r = await meusCarros.doc(id).get();
              carros.add(r.data());
            }
            setState(() {
              data = carros ?? <Map<String, dynamic>>[];
            });
          },
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              var carro = data[index];
              return Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                    """Meu carro$index: ${carro['anoFabricacao']} ${carro['anoModelo']} ${carro['modelo']} ${carro['marca']} ${carro['placa']}"""),
              );
            },
          ),
        ),
      ),
    );
  }
}
