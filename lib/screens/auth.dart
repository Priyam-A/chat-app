import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/image_picker.dart';

final _firebaseAuth = FirebaseAuth.instance;

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});
  @override
  State<AuthenticationScreen> createState() {
    // TODO: implement createState
    return _AuthenticationState();
  }
}

class _AuthenticationState extends State<AuthenticationScreen> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = false;
  String _password = "";
  String _emailID = "";
  String _username = "";
  File? _selectImage;
  var _isAuth = false;
  void flip() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    } else {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Invalid username or password"),
        ),
      );
      return;
    }
    if (!_isLogin && _selectImage == null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please select an image"),
        ),
      );
      return;
    }
    try {
      setState(() {
        _isAuth = true;
      });
      if (_isLogin) {
        final creds = await _firebaseAuth.signInWithEmailAndPassword(
            email: _emailID, password: _password);
      } else {
        final creds = await _firebaseAuth.createUserWithEmailAndPassword(
            email: _emailID, password: _password);
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${creds.user!.uid}.jpg');
        await storageRef.putFile(_selectImage!);
        final imageURL = await storageRef.getDownloadURL();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(creds.user!.uid)
            .set({
          'username': _username,
          'email': _emailID,
          'imageURL': imageURL,
        });
      }
    } on FirebaseAuthException catch (exception) {
      setState(() {
        _isAuth = false;
      });
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(exception.message ?? "Authentication failed")));
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.purple,
          Colors.deepPurple,
          Colors.pink,
          Colors.red
        ], begin: Alignment.bottomRight, end: Alignment.topLeft)),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 30,
                    bottom: 30,
                  ),
                  width: 200,
                  child: Image.asset('assets/icon.png'),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          if (!_isLogin)
                            UserImagePicker(
                              onPickedImage: (pic) {
                                _selectImage = pic;
                              },
                            ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: "Email Address",
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  !value.contains('@'))
                                return "Enter valid email";
                              return null;
                            },
                            onSaved: (newValue) {
                              _emailID = newValue!;
                            },
                          ),
                          if (!_isLogin)
                            TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Enter Username'),
                              autocorrect: false,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Enter a valid username';
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (newValue) {
                                _username = newValue!;
                              },
                            ),
                          TextFormField(
                            decoration: InputDecoration(labelText: "password"),
                            obscureText: true,
                            autocorrect: false,
                            validator: (value) {
                              if (value == null || value.length < 6)
                                return "Enter password of min 6 characters";
                              return null;
                            },
                            onSaved: (newValue) {
                              _password = newValue!;
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          if (_isAuth)
                            CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                            ),
                          if (!_isAuth)
                            ElevatedButton(
                              onPressed: _submit,
                              child: Text(_isLogin ? "Log in" : "Sign up"),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer),
                            ),
                          if (!_isAuth)
                            TextButton(
                              onPressed: flip,
                              child: Text(_isLogin
                                  ? "Create account"
                                  : "I already have an account!"),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
