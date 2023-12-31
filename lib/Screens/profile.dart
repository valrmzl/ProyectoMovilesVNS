import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';


class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? currentUser;
  String avatar = ''; // Declarar la variable avatar aquí

  Future<dynamic> getData() async {
    currentUser = FirebaseAuth.instance.currentUser;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey),
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder<dynamic>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return ListView(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    height: 115,
                    width: 115,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage("assets/images/${currentUser?.photoURL}.png"),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: IconButton(
                              onPressed: () async {
                                var cameraStatus = await Permission.camera.request();
                                var photosStatus = await Permission.photos.request();

                                if (cameraStatus.isGranted && photosStatus.isGranted) {
                                  // Acciones al permitir el acceso a la cámara y galería
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Debes conceder los permisos de cámara y galería para continuar.',
                                      ),
                                    ),
                                  );
                                }
                              },
                              icon: Icon(
                                Icons.verified_user,
                                size: 20,
                                color: Color.fromARGB(255, 47, 125, 121),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                _buildInfoCard(
                  Icons.person,
                  currentUser?.displayName ?? 'null',
                  
                  Color.fromARGB(255, 47, 125, 121),
                ),
                const SizedBox(height: 16),
                _buildInfoCard(
                  Icons.email,
                  currentUser?.email ?? 'null',
                  Color.fromARGB(255, 47, 125, 121),
                ),
                const SizedBox(height: 16),
              ],
            );
          }
        },
      ),
    );
  }

  Card _buildInfoCard(IconData icon, String text, Color iconColor) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      child: ListTile(
        leading: Icon(
          icon,
          color: iconColor,
        ),
        title: Text(text),
      ),
    );
  }
}


