import 'dart:math';

import 'package:campma/src/custom_components/LocationCustomItem.dart';
import 'package:flutter/material.dart';

import '../models/Location.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Location> locations = [
    const Location(id: 0, label: "001", surface: 90, available: 0, commentaires: "Première parcelle de terrain Première parcelle de terrain Première parcelle de terrain Première parcelle de terrain Première parcelle de terrainPremière parcelle de terrain Première parcelle de terrain Première parcelle de terrain Première parcelle de terrain Première parcelle de terrain Première parcelle de terrain Première parcelle de terrain Première parcelle de terrain Première parcelle de terrain Première parcelle de terrain Première parcelle de terrain Première parcelle de terrain Première parcelle de terrain Première parcelle de terrain Première parcelle de terrain Première parcelle de terrain Première parcelle de terrain Première parcelle de terrain Première parcelle de terrain Première parcelle de terrain Première parcelle de terrain"),
    const Location(id: 1, label: "002", surface: 95, available: 1, commentaires: "Deuxième parcelle de terrain"),
    const Location(id: 2, label: "003", surface: 95, available: 1, commentaires: "Troisième parcelle de terrain"),
    const Location(id: 3, label: "004", surface: 97, available: 0, commentaires: "Quatrième parcelle de terrain"),
    const Location(id: 4, label: "005", surface: 90, available: 2, commentaires: "Cinquième parcelle de terrain"),
    const Location(id: 5, label: "006", surface: 110, available: 0, commentaires: "Sixième parcelle de terrain"),
    const Location(id: 6, label: "007", surface: 92, available: 1, commentaires: "Septième parcelle de terrain")
  ];

  Offset _gridOffset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: SafeArea(
          child: Drawer(
              child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Text(
              "Menu",
              style: TextStyle(fontSize: 30),
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Row(
                children: [
                  Icon(Icons.person_rounded),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Mon compte",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              )),
          Spacer(),
          Padding(
              padding: EdgeInsets.only(left: 30, right: 30, bottom: 30),
              child: Row(
                children: [
                  Icon(
                    Icons.logout_rounded,
                    color: Colors.red[800],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Se déconnecter",
                      style: TextStyle(fontSize: 20, color: Colors.red[800]),
                    ),
                  ),
                ],
              ))
        ],
      ))),
      appBar: AppBar(
        backgroundColor:
            Theme.of(context).colorScheme.inversePrimary, // #37C45F
        title: const Text("Camma"), // vient de Camping Manager
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                icon: const Icon(Icons.settings_rounded),
                onPressed: () {
                  _scaffoldKey.currentState?.openEndDrawer();
                },
              ))
        ],
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          Positioned(
              left: _gridOffset.dx,
              top: _gridOffset.dy,
              child: GestureDetector(
                onPanUpdate: (details) {
                  setState(() => _gridOffset += details.delta);
                },
                child: Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateX(-1.3)
                    ..rotateZ(0.5),
                  child: Container(
                      alignment: Alignment.center,
                      height: 500,
                      width: 500,
                      color: const Color.fromRGBO(209, 209, 209, 100),
                      child: LocationCustomItem(locations[0])
                      // Center(
                      //   child: ,
                      //   child: GridView(
                      //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      //     crossAxisCount: 3, // Nombre d'éléments dans l'axe transversal
                      //     crossAxisSpacing: 8.0, // Espace horizontal entre les éléments
                      //     mainAxisSpacing: 8.0, // Espace vertical entre les éléments
                      //   ),
                      //   children: [
                      //     ,
                      //     LocationCustomItem(locations[1]),
                      //     LocationCustomItem(locations[2])
                      //   ],
                      // ),
                      ),
                ),
              )),
          Positioned(
              bottom: 30,
              right: 30,
              child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  child: IconButton(
                    iconSize: 50,
                    icon: const Icon(Icons.add_rounded),
                    onPressed: () {
                      print("ADD");
                    },
                  )))
        ],
      ),
    );
  }
}
