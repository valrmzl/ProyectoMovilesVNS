import 'package:flutter/material.dart';
import 'package:proyecto_vsn/Screens/home_page.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController passwordCreateController = TextEditingController();
  final TextEditingController passwordConfirmController = TextEditingController();

  bool passwordCreateVisibility = true;
  bool passwordConfirmVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: AssetImage(
                  'assets/images/createAccount_bg@2x.png',
                ),
              ),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(24, 24, 0, 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Agrega aquí tu imagen de logo
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Get Started',
                                // Estilo de texto
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Create your account below.',
                                  // Estilo de texto
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                            child: TextFormField(
                              controller: emailAddressController,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Email Address',
                                // Otros atributos de estilo
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                            child: TextFormField(
                              controller: passwordCreateController,
                              obscureText: passwordCreateVisibility,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                // Otros atributos de estilo
                                suffixIcon: InkWell(
                                  onTap: () => setState(() {
                                    passwordCreateVisibility =
                                        !passwordCreateVisibility;
                                  }),
                                  focusNode: FocusNode(skipTraversal: true),
                                  child: Icon(
                                    passwordCreateVisibility
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                            child: TextFormField(
                              controller: passwordConfirmController,
                              obscureText: passwordConfirmVisibility,
                              decoration: InputDecoration(
                                labelText: 'Confirm Password',
                                // Otros atributos de estilo
                                suffixIcon: InkWell(
                                  onTap: () => setState(() {
                                    passwordConfirmVisibility =
                                        !passwordConfirmVisibility;
                                  }),
                                  focusNode: FocusNode(skipTraversal: true),
                                  child: Icon(
                                    passwordConfirmVisibility
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 24),
                            child: ElevatedButton(
                              onPressed: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => HomePage()), // Reemplaza CreateAccount() con el constructor real de tu página de creación de cuentas
                                  );
                              },
                              child: Text('Create Account'),
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                             
                              TextButton(
                                onPressed: () {
                                  // Navega a la página de inicio de sesión
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Already have an account? Login',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
