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

  //text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();

  Future SignUp() async {
    if(confirmasPassword()){

      //se crea el usuario
       await FirebaseAuth.instance.createUserWithEmailAndPassword(
      
      email: _emailController.text.trim(), 
      password: _passwordController.text.trim()
      );

      //añadir otros detalles
      addUserDetails(_nombreController.text.trim(), _apellidoController.text.trim(), _emailController.text.trim(), _passwordController.text.trim());

    }
   
  }

  Future addUserDetails(String nombre, String apellido, String email, String password) async {
    await FirebaseFirestore.instance.collection("Users").add({

      'Nombre': nombre,
      'Apellido': apellido,
      'Email': email,
      'Password': password

    }
    );
  }

  bool confirmasPassword(){
    if (_passwordController.text.trim() == _confirmpasswordController.text.trim()){
      return true;
    }else{
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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
        ),
      ),
      body: Container(
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
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Crea una cuenta",
                        style: TextStyle(
                            fontSize: 15, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: <Widget>[
                        makeInput(label: "Nombre ", controller: _nombreController),
                        makeInput(label: "Apellido ", controller: _apellidoController),
                        makeInput(label: "Email", controller: _emailController),
                        makeInput(label: "Password", obscureText: true, controller: _passwordController),
                        makeInput(label: "Confirmar password", obscureText: true, controller: _confirmpasswordController),
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
                        onPressed: () {
                          SignUp();
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
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
    Text("¿Ya tienes una cuenta?   "),
    GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
        // Navegar a la página de inicio (HomePage)
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
          color: Colors.black, // Cambia el color del texto si lo deseas
        ),
      ),
    ),
  ],
)

                ],
              ),
            ),
            
          ],
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
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)),
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
