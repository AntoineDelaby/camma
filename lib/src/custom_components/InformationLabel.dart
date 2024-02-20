import 'package:flutter/material.dart';

class InformationLabel extends StatelessWidget {
  final IconData icon;
  final String label;

  const InformationLabel(this.icon, this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              this.label,
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.justify,
            ),
          )
        ],
      ),
    );
  }
}
