import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Lista de países para el Dropdown
  List<String> countries = ["México", "Estados Unidos", "Canadá", "España", "Argentina"];

  // Variable para controlar el valor seleccionado del Dropdown
  String selectedCountry = "México";

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
      body: ListView(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: 115,
              width: 115,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage("assets/images/val.png"),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        size: 20,
                        color: Color.fromARGB(255, 47, 125, 121),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40), 
          _buildInfoCard(Icons.person, "Valeria Ramirez", Color.fromARGB(255, 47, 125, 121)),
          const SizedBox(height: 16), 
          _buildInfoCard(Icons.email, "val@gmail.com", Color.fromARGB(255, 47, 125, 121)),
          const SizedBox(height: 16), 
          _buildInfoCard(Icons.phone, "3312143523", Color.fromARGB(255, 47, 125, 121)),
          const SizedBox(height: 16), 
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 4,
            child: ListTile(
              leading: Icon(
                Icons.flag,
                color: Color.fromARGB(255, 47, 125, 121),
              ),
              title: Text("Divisa"),
              trailing: DropdownButton<String>(
                value: selectedCountry,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedCountry = newValue;
                    });
                  }
                },
                items: countries.map((String country) {
                  return DropdownMenuItem<String>(
                    value: country,
                    child: Text(country),
                  );
                }).toList(),
              ),
            ),
            ),

        ],
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