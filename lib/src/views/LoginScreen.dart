import 'dart:convert';

import 'package:campma/src/services/AuthentificationServices.dart';
import 'package:flutter/material.dart';
import '../theme/CustomColors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Variables pour stocker les valeurs du formulaire
  String? _username = '';
  String? _password = '';

  final Offset _gridOffset = Offset.zero;

  bool _obscureText = true;
  bool? _invalidCredentials;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _toggleInvalidCredentials(bool? newValue) {
    setState(() {
      _invalidCredentials = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      body: SafeArea(
          child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 20,
            child: Image.asset(
              'lib/assets/images/saplins.png',
              height: 300.0,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                  padding: const EdgeInsets.only(top: 100, left: 50, right: 50),
                  child: Column(
                    children: [
                      const Text(
                        "Camma",
                        style: TextStyle(
                            fontSize: 65, color: CustomColors.primary_dark),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 50),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                      labelText: 'Identifiant',
                                      prefixIcon: Icon(Icons.person_rounded)),
                                  validator: (value) {
                                    if (value != null) {
                                      final emailRegex = RegExp(
                                          r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
                                      if (value.isEmpty ||
                                          !emailRegex.hasMatch(value)) {
                                        return 'Veuillez entrer une adresse e-mail valide';
                                      }
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _username = value;
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: TextFormField(
                                  obscureText: _obscureText,
                                  decoration: InputDecoration(
                                      prefixIcon: const Icon(Icons.lock),
                                      suffixIcon: GestureDetector(
                                        onTap: _togglePasswordVisibility,
                                        child: Icon(_obscureText
                                            ? Icons.visibility
                                            : Icons.visibility_off),
                                      ),
                                      labelText: 'Mot de passe'),
                                  validator: (value) {
                                    if (value != null) {
                                      final passwordRegex = RegExp(
                                          r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+])(?=.*[a-z]).{8,}$');
                                      if (value.isEmpty ||
                                          !passwordRegex.hasMatch(value)) {
                                        return 'Le mot de passe doit faire au moins 8 caractères, '
                                            'avoir au moins 1 chiffre, 1 majuscule et 1 caractère spécial';
                                      }
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _password = value;
                                  },
                                ),
                              ),
                              if (_invalidCredentials != null &&
                                  _invalidCredentials == false)
                                const Text(
                                  "Identifiant ou mot de passe invalide",
                                  style: TextStyle(color: CustomColors.red),
                                ),
                              Container(
                                padding: const EdgeInsets.only(top: 100),
                                width: 300,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            10.0), // Modifier le rayon ici
                                      ),
                                    ),
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      var loginTest =
                                          await AuthentificationServices.login(
                                              _username!, _password!);
                                      var jsonResults =
                                          jsonDecode(loginTest.body);
                                      if (jsonResults['result']['uid'] !=
                                          null) {
                                        Navigator.pushReplacementNamed(
                                            context, '/');
                                      } else {
                                        _toggleInvalidCredentials(false);
                                      }
                                    }
                                  },
                                  child: const Text('Connexion'),
                                ),
                              ),
                              SizedBox(
                                width: 300,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color?>(
                                            CustomColors.secondary),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            10.0), // Modifier le rayon ici
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, '/register');
                                  },
                                  child: const Text(
                                    'Créer un compte',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )))
        ],
      )),
    );
  }
}
