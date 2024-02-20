import 'dart:math';

import 'package:campma/src/custom_components/LocationCustomItem.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/Location.dart';
import '../theme/CustomColors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Offset _gridOffset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Mon compte", style: TextStyle(fontSize: 30)),
                      IconButton(
                        icon: const Icon(Icons.close_rounded),
                        iconSize: 30,
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/');
                        },
                      )
                    ],
                  ),
                  Text("Antoine"),
                  Text("Delaby")
                ],
              ))),
    );
  }
}
