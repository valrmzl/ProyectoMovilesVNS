// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_vsn/Screens/home_page.dart';
import 'package:proyecto_vsn/Screens/login_page.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  // Text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();

  // Variable to track the selected image
  String selectedImage = '';

  // Variable to track the number of the selected avatar
  int selectedAvatarNumber = 0;

  // Checkbox state
  bool acceptTerms = false;

  // Toggle checkbox state
  void toggleAcceptTerms() {
    setState(() {
      acceptTerms = !acceptTerms;
    });
  }

  Future signUp() async {
    if (confirmasPassword() && acceptTerms) {
      // Create the user
      UserCredential userCred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      User? user = userCred.user;
      await user!.updateDisplayName('${_nombreController.text.trim()} ${_apellidoController.text.trim()}');
      await user!.updatePhotoURL(selectedAvatarNumber.toString());
      // Add other details
      addUserDetails(
        _nombreController.text.trim(),
        _apellidoController.text.trim(),
        _emailController.text.trim(),
        _passwordController.text.trim(),
        selectedAvatarNumber,
      );

      bool signInSuccess = await signUserIn(context);

      if (signInSuccess) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      }
    } else {
      // Mostrar un mensaje indicando que los términos y condiciones deben ser aceptados
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Por favor, acepta los términos y condiciones."),
        ),
      );
    }
  }

  Future<bool> signUserIn(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // Successful login
      return true;
    } catch (e) {
      // Error handling
      print("Error during login: $e");
      // Show a SnackBar with the error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error during login: $e"),
        ),
      );
      // Login failed
      return false;
    }
    print('Login successful');
  }

  Future addUserDetails(String nombre, String apellido, String email, String password, avatar) async {
    await FirebaseFirestore.instance.collection("Users").add({
      'Nombre': nombre,
      'Apellido': apellido,
      'Email': email,
      'Password': password,
      'Avatar': avatar
    });
  }

  bool confirmasPassword() {
    if (_passwordController.text.trim() == _confirmpasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          "Sign up",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Create an account",
                          style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: <Widget>[
                          makeInput(
                              label: "Nombre ", controller: _nombreController),
                          makeInput(
                              label: "Apellido ",
                              controller: _apellidoController),
                          makeInput(
                              label: "Email", controller: _emailController),
                          makeInput(
                              label: "Password",
                              obscureText: true,
                              controller: _passwordController),
                          makeInput(
                              label: "Confirm Password",
                              obscureText: true,
                              controller: _confirmpasswordController),
                        ],
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: acceptTerms,
                            onChanged: (value) {
                              toggleAcceptTerms();
                            },
                          ),
                          Text("Acepto terminos y condiciones", style: TextStyle(color: Colors.black),),
                        ],
                      ),
                    SizedBox(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AvatarImage(
                            image: 'images/1.png',
                            isSelected: selectedImage == 'images/1.png',
                            avatarNumber: 1,
                            onTap: (number) {
                              setState(() {
                                selectedImage = 'images/1.png';
                                selectedAvatarNumber = number;
                              });
                            },
                          ),
                          AvatarImage(
                            image: 'images/2.png',
                            isSelected: selectedImage == 'images/2.png',
                            avatarNumber: 2,
                            onTap: (number) {
                              setState(() {
                                selectedImage = 'images/2.png';
                                selectedAvatarNumber = number;
                              });
                            },
                          ),
                          AvatarImage(
                            image: 'images/3.png',
                            isSelected: selectedImage == 'images/3.png',
                            avatarNumber: 3,
                            onTap: (number) {
                              setState(() {
                                selectedImage = 'images/3.png';
                                selectedAvatarNumber = number;
                              });
                            },
                          ),
                          AvatarImage(
                            image: 'images/4.png',
                            isSelected: selectedImage == 'images/4.png',
                            avatarNumber: 4,
                            onTap: (number) {
                              setState(() {
                                selectedImage = 'images/4.png';
                                selectedAvatarNumber = number;
                              });
                            },
                          ),
                          AvatarImage(
                            image: 'images/5.png',
                            isSelected: selectedImage == 'images/5.png',
                            avatarNumber: 5,
                            onTap: (number) {
                              setState(() {
                                selectedImage = 'images/5.png';
                                selectedAvatarNumber = number;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                        padding: EdgeInsets.only(top: 3, left: 3),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border(
                              bottom: BorderSide(color: Colors.black),
                              top: BorderSide(color: Colors.black),
                              left: BorderSide(color: Colors.black),
                              right: BorderSide(color: Colors.black),
                            )),
                        child: MaterialButton(
                          minWidth: double.infinity,
                          height: 60,
                          onPressed: () async {
                            await signUp();
                            print("hola");
                          },
                          color: Color.fromARGB(255, 184, 243, 223),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Already have an account?   ",
                            style: TextStyle(color: Colors.black)),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            // Navigate to the login page
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: acceptTerms,
                          onChanged: (value) {
                            toggleAcceptTerms();
                          },
                        ),
                        Text("I accept the terms and conditions"),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget makeInput({label, obscureText = false, TextEditingController? controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          controller: controller,
          obscureText: obscureText,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}

class AvatarImage extends StatelessWidget {
  final String image;
  final bool isSelected;
  final int avatarNumber;
  final Function(int) onTap;

  AvatarImage({
    required this.image,
    required this.isSelected,
    required this.avatarNumber,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(avatarNumber),
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? Colors.red : Colors.blue,
            width: 2,
          ),
        ),
        child: ClipOval(
          child: Image.asset(
            'assets/$image',
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
