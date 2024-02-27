import 'dart:math';

import 'package:campma/src/custom_components/LocationCustomItem.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/Location.dart';
import '../theme/CustomColors.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Location> locations = [
    const Location(
        id: 0,
        label: "001",
        surface: 90,
        available: 0,
        commentaires:
            "Première parcelle de terrain Première parcelle de terrain Première parcelle de terrain Première parcelle de terrain Première parcelle de terrainPremière parcelle de terrain Première parcelle de terrain Première parcelle de terrain Première parcelle de terrain Première parcelle de terrain Première parcelle de terrain Première parcelle de terrain Première parcelle de terrain Première parcelle de terrain Première parcelle de terrain Première parcelle de terrain Première parcelle de terrain Première parcelle de terrain Première parcelle de terrain Première parcelle de terrain Première parcelle de terrain Première parcelle de terrain Première parcelle de terrain Première parcelle de terrain Première parcelle de terrain Première parcelle de terrain"),
    const Location(
        id: 1,
        label: "002",
        surface: 95,
        available: 1,
        commentaires: "Deuxième parcelle de terrain"),
    const Location(
        id: 2,
        label: "003",
        surface: 95,
        available: 1,
        commentaires: "Troisième parcelle de terrain"),
    const Location(
        id: 3,
        label: "004",
        surface: 97,
        available: 0,
        commentaires: "Quatrième parcelle de terrain"),
    const Location(
        id: 4,
        label: "005",
        surface: 90,
        available: 2,
        commentaires: "Cinquième parcelle de terrain"),
    const Location(
        id: 5,
        label: "006",
        surface: 110,
        available: 0,
        commentaires: "Sixième parcelle de terrain"),
    const Location(
        id: 6,
        label: "007",
        surface: 92,
        available: 1,
        commentaires: "Septième parcelle de terrain")
  ];

  Offset _gridOffset = Offset.zero;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _gridOffset = Offset(
      MediaQuery.of(context).size.width / 2 - 100,
      MediaQuery.of(context).size.height / 2 - 100,
    );
  }

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
              child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                  child: const Row(
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
                  ))),
          const Spacer(),
          Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
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
                ),
              ))
        ],
      ))),
      body: Stack(
        children: [
          Positioned(
              left: _gridOffset.dx,
              top: _gridOffset.dy,
              child: GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    _gridOffset += details.delta;

                    double screenWidth = MediaQuery.of(context).size.width;
                    double screenHeight = MediaQuery.of(context).size.height;

                    _gridOffset = Offset(
                      _gridOffset.dx.clamp(0, screenWidth - 200),
                      _gridOffset.dy.clamp(0, screenHeight - 200),
                    );
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 200,
                  width: 200,
                  color: Colors.grey,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: GridView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 3.0,
                            mainAxisSpacing: 3.0),
                        itemCount: locations.length,
                        itemBuilder: (BuildContext context, int index) {
                          return LocationCustomItem(locations[index]);
                        }),
                  ),
                ),
              )),
          Positioned(
              top: MediaQuery.of(context).padding.top,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text("Camma",
                          style: TextStyle(
                              color: CustomColors.primary_dark, fontSize: 30)),
                      IconButton(
                        icon: const Icon(Icons.settings_rounded),
                        iconSize: 30,
                        onPressed: () {
                          _scaffoldKey.currentState?.openEndDrawer();
                        },
                      )
                    ]),
              )),
          Positioned(
              bottom: 30,
              right: 30,
              child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: CustomColors.primary,
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
