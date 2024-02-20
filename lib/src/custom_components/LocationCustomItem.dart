import 'dart:math';

import 'package:flutter/material.dart';

import '../models/Location.dart';
import 'TrianglePainter.dart';
import 'InformationLabel.dart';

class LocationCustomItem extends StatelessWidget {
  final Location location;

  const LocationCustomItem(this.location, {super.key});

  Color? getStateColor(int state) {
    switch (state) {
      case 0:
        return Colors.green[600];
      case 1:
        return Colors.orange[600];
      case 2:
        return Colors.red[600];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            showLocationInformation(context);
          },
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                color: getStateColor(this.location.available),
                borderRadius: BorderRadius.circular(5.0)),
            child: Center(
              child: Text(location.label),
            ),
          ),
        )
        // Transform(
        //     // morceau droit de la maison
        //     transform: Matrix4.identity()
        //       ..translate(50.0, 0.0, 0.0)
        //       ..rotateY(pi / 2),
        //     child: GestureDetector(
        //       behavior: HitTestBehavior.translucent,
        //       onTap: () {
        //         print("OK GOT 1");
        //         showLocationInformation(context);
        //       },
        //       child: Container(
        //         width: 10,
        //         height: 50,
        //         color: const Color.fromRGBO(30, 175, 63, 100),
        //       ),
        //     )),
        // Transform(
        //     // morceau avant de la maison
        //     transform: Matrix4.identity()
        //       ..translate(0.0, 50.0, 0.0)
        //       ..rotateX(-pi / 2),
        //     child: GestureDetector(
        //       behavior: HitTestBehavior.translucent,
        //       onTap: () {
        //         print("OK GOT 2");
        //         showLocationInformation(context);
        //       },
        //       child: Container(
        //         width: 50,
        //         height: 10,
        //         color: const Color.fromRGBO(36, 205, 74, 100),
        //       ),
        //     )),
        // Transform(
        //     // morceau droit de la maison
        //     transform: Matrix4.identity()
        //       ..translate(50.0, 0.0, -10.0)
        //       ..rotateY(pi / 2),
        //     child: GestureDetector(
        //       behavior: HitTestBehavior.translucent,
        //       onTap: () {
        //         print("OK GOT 3");
        //         showLocationInformation(context);
        //       },
        //       child: SizedBox(
        //         width: 10,
        //         height: 50,
        //         child: CustomPaint(
        //           painter: TrianglePainter(),
        //         ),
        //       ),
        //     )),
        // Transform(
        //     // morceau arrière du toit
        //     transform: Matrix4.identity()
        //       ..translate(-8.0, -10.0, -6)
        //       ..rotateX(-pi / 8),
        //     child: GestureDetector(
        //       behavior: HitTestBehavior.translucent,
        //       onTap: () {
        //         print("OK GOT 4");
        //         showLocationInformation(context);
        //       },
        //       child: Container(
        //         width: 55,
        //         height: 25.4951,
        //         color: const Color.fromRGBO(36, 205, 74, 100),
        //       ),
        //     )),
        // Transform(
        //   //morceau avant du toit
        //   transform: Matrix4.identity()
        //     ..translate(-10.0, 10.0, -14)
        //     ..rotateX(pi / 8),
        //   child: GestureDetector(
        //     behavior: HitTestBehavior.translucent,
        //     onTap: () {
        //       print("OK GOT 5");
        //       showLocationInformation(context);
        //     },
        //     child: Container(
        //       width: 53,
        //       height: 25.4951,
        //       color: const Color.fromRGBO(36, 205, 74, 100),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  showLocationInformation(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (BuildContext context) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.0,
                      offset: Offset(0.0,
                          1.0), // Décalage de l'ombre (horizontal, vertical)
                    ),
                  ],
                ),
                child: const Text(
                  'Informations sur le terrain',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Expanded(
                  child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.brown[200] ?? Colors.grey,
                                    // Couleur marron gris
                                    width: 2.0, // Épaisseur de la bordure
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 5.0,
                                      offset: Offset(1.0, 1.0),
                                    ),
                                  ]),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6.0),
                                child: Image.asset(
                                  'lib/assets/images/camping1.jpeg',
                                  width: double.infinity,
                                  height: 200.0,
                                  fit: BoxFit.cover,
                                ),
                              )),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 30),
                            child: Column(
                              children: [
                                InformationLabel(Icons.label_outline_rounded,
                                    "Label du terrain : ${location.label}"),
                                InformationLabel(Icons.space_bar_rounded,
                                    "Surface du terrain : ${location.surface} m²"),
                                Row(
                                  children: [
                                    InformationLabel(
                                        Icons.person_rounded, "État :"),
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            getStateColor(location.available),
                                      ),
                                      width: 20,
                                      height: 20,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                InformationLabel(Icons.info_outline_rounded,
                                    "Informations complémentaires :"),
                                Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        color: Colors.grey[350]),
                                    child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        location.commentaires,
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 20,
                      left: 20,
                      right: 20,
                      child: IconButton(
                        iconSize: 40,
                        color: Colors.grey[800],
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )),
                  Positioned(
                      bottom: 20,
                      right: 20,
                      child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                          child: IconButton(
                            iconSize: 40,
                            icon: const Icon(Icons.edit_rounded),
                            onPressed: () {
                              print("EDIT");
                            },
                          )))
                ],
              )),
            ],
          ),
        );
      },
    );
  }
}
