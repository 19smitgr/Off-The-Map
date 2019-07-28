import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:off_the_map/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:off_the_map/models/user.dart';
import 'package:off_the_map/views/teacher_home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final Color veryDarkBlue = Color(0xFF30465C);
  final Color purple = Color(0xFF93639A);

  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool loggingIn = false;

  bool error = false;
  String errorText = 'Incorrect email or password. Please try again';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGrayBackgroundColor,
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: veryDarkBlue,
      ),
      body: ModalProgressHUD(
        inAsyncCall: loggingIn,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      hintText: 'Type your email', labelText: 'Email'),
                ),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: 'Type your password', labelText: 'Password'),
                ),
                if (error)
                  Text(
                    errorText,
                    style:
                        TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                RaisedButton(
                  color: purple,
                  onPressed: () async {
                    setState(() {
                      loggingIn = true;
                    });

                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );

                      if (user != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return StreamBuilder<QuerySnapshot>(
                                stream: Firestore.instance
                                    .collection('users')
                                    .where('uid', isEqualTo: user.uid)
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.waiting:
                                      return Text('Loading...');
                                    default:
                                      if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}');
                                      } else {
                                        return TeacherHome(
                                          user: User.fromFirestore(
                                            snapshot.data.documents[0],
                                          ),
                                        );
                                      }
                                  }
                                },
                              );
                            },
                          ),
                        );

                        setState(() {
                          loggingIn = false;
                        });
                      }
                    } catch (e) {
                      setState(() {
                        loggingIn = false;
                        error = true;
                      });
                    }
                  },
                  child: Text('Login', style: TextStyle(color: Colors.white)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
