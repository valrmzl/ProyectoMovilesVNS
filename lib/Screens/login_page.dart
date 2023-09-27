import 'package:flutter/material.dart';
import 'package:proyecto_vsn/Screens/home_page.dart';
import 'create_account.dart'; // Importa la clase CreateAccount desde el archivo correspondiente

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController emailAddressController;
  late TextEditingController passwordController;
  bool passwordVisibility = false;

  @override
  void initState() {
    super.initState();
    emailAddressController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailAddressController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Color de fondo
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: AssetImage('assets/images/login_bg@2x.png'),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(24, 40, 24, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.monetization_on,
                      size: 60,
                      color: Colors.blue, // Puedes personalizar el color aquí
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Welcome back',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Login to access your account',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: emailAddressController,
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        hintText: 'Enter your email...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        contentPadding: EdgeInsets.all(16),
                      ),
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      controller: passwordController,
                      obscureText: !passwordVisibility,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        contentPadding: EdgeInsets.all(16),
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              passwordVisibility = !passwordVisibility;
                            });
                          },
                          child: Icon(
                            passwordVisibility
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            // Acción para olvidar la contraseña
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                                Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HomePage()), // Reemplaza CreateAccount() con el constructor real de tu página de creación de cuentas
                            );
                          },
                          child: Text('Login'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CreateAccount()), // Reemplaza CreateAccount() con el constructor real de tu página de creación de cuentas
                        );
                      },
                      child: Container(
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? Create",
                              style: TextStyle(fontSize: 14),
                            ),
                            Icon(
                              Icons.arrow_forward_rounded,
                              size: 24,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
