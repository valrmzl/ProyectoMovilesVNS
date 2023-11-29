import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_vsn/Screens/home_page.dart';
import 'package:proyecto_vsn/Screens/login_page.dart';


class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          //si ya esta iniciada la sesion
          if(snapshot.hasData){
            return HomePage();
          }
          else{
            return LoginPage();
          }
        },
        ),
    );
  }
}