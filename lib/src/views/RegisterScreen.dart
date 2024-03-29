import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

import '../models/Location.dart';
import '../services/AuthentificationServices.dart';
import '../theme/CustomColors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Variables pour stocker les valeurs du formulaire
  String? _username = '';
  String? _password = '';
  final TextEditingController _passwordController = TextEditingController();
  String? _passwordConfirm = '';

  final Offset _gridOffset = Offset.zero;

  bool _obscureText = true;
  bool _confirmObscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _confirmObscureText = !_confirmObscureText;
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
                    padding: const EdgeInsets.only(top: 60, left: 50, right: 50),
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
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: TextFormField(
                              decoration:
                              const InputDecoration(
                                  prefixIcon: Icon(Icons.person_rounded),
                                  labelText: 'Identifiant'),
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
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.lock),
                                  suffixIcon: GestureDetector(
                                    onTap: _togglePasswordVisibility,
                                    child: Icon(
                                        _obscureText ? Icons.visibility : Icons
                                            .visibility_off),
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
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: TextFormField(
                                obscureText: _confirmObscureText,
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.lock),
                                suffixIcon: GestureDetector(
                                  onTap: _toggleConfirmPasswordVisibility,
                                  child: Icon(_confirmObscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                ),
                                labelText: 'Confirmer mot de passe'),
                            validator: (value) {
                              if (value != null) {
                                print(_password);
                                print(_passwordConfirm);
                                if (value.isEmpty ||
                                    value != _passwordController.text) {
                                  return 'Les mots de passes sont différents';
                                }
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _passwordConfirm = value;
                            },
                          ),
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
                                var registerTest =
                                    await AuthentificationServices.register(
                                    _username!, _password!);
                                var jsonResults =
                                jsonDecode(registerTest.body);
                                if (jsonResults['result']['uid'] !=
                                    null) {
                                  Navigator.pushReplacementNamed(
                                      context, '/');
                                }
                                Navigator.pushReplacementNamed(context, '/');
                              }
                            },
                            child: const Text('Créer un compte'),
                          ),
                        ),
                        SizedBox(
                          width: 300,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<
                                  Color?>(
                                  CustomColors.secondary
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10.0), // Modifier le rayon ici
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/login');
                            },
                            child: const Text('Se connecter', style: TextStyle(
                                color: Colors.white),),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )))],
    )
    )
    ,
    );
  }
}
