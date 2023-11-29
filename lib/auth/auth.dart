import 'package:flutter/material.dart';
import 'package:proyecto_vsn/Screens/create_account.dart';
import 'package:proyecto_vsn/Screens/login_page.dart';


class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
   //initialyy show the login page
  bool showLoginPage = true;
  @override
  Widget build(BuildContext context) {
   if(showLoginPage){
    return LoginPage();
   }else{
    return CreateAccount();
   }
  }
}