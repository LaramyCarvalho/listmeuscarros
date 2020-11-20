import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  // Create the initilization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Text("ops");
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return ListMeusCarros("1");
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Text("Loading");
      },
    );
  }
}

class ListMeusCarros extends StatelessWidget {
  final String documentId;

  ListMeusCarros(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference meus_carros =
        FirebaseFirestore.instance.collection('meus_carros');

    return FutureBuilder<DocumentSnapshot>(
      future: meus_carros.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          return Text(
              "Full Name: ${data['anoFabricacao']} ${data['anoModelo']} ${data['modelo']} ${data['marca']} ${data['placa']} ");
        }

        return Text("loading");
      },
    );
  }
}
