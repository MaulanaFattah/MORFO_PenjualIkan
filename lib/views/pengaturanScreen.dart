import 'package:flutter/material.dart';
import 'package:morfo/provider/theme_provider.dart';
import 'package:morfo/views/LoginScreen.dart';
import 'package:morfo/views/profileScreen.dart';
import 'package:morfo/views/trollScreen.dart';
import 'package:provider/provider.dart';

class PengaturanScreen extends StatelessWidget {
  const PengaturanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkModeProv = Provider.of<DarkModeProvider>(context);
    return Scaffold(
      backgroundColor: darkModeProv.isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          'Koi Fish',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                // primary: Colors.white,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Row(
                children: [
                  Icon(Icons.logout),
                  SizedBox(width: 5),
                  Text("Logout"),
                ],
              ),
            ),
          ),
          PopupMenuButton<MenuItem>(
            onSelected: (value) {
              if (value == MenuItem.Profil) {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              } else if (value == MenuItem.Pengaturan) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PengaturanScreen()));
              } else if (value == MenuItem.Logout) {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: MenuItem.Profil,
                child: Text('Profil'),
              ),
              PopupMenuItem(
                value: MenuItem.Pengaturan,
                child: Text('Pengaturan'),
              ),
              PopupMenuItem(
                value: MenuItem.Logout,
                child: Text('Logout'),
              ),
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 20),
            SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Settings",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                ListView(
                  shrinkWrap: true,
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.dark_mode,
                        color: darkModeProv.isDarkMode
                            ? Colors.white
                            : Colors.black,
                      ),
                      title: Text(
                        'Dark Theme',
                        style: TextStyle(
                          color: darkModeProv.isDarkMode
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      trailing: Switch(
                        value: darkModeProv.isDarkMode,
                        onChanged: (value) {
                          darkModeProv.toggleDarkMode();
                          // Handle dark mode setting
                          // Here you can update the app's theme based on the value of _isDarkMode
                        },
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.notifications,
                        color: darkModeProv.isDarkMode
                            ? Colors.white
                            : Colors.black,
                      ),
                      title: Text(
                        'Notifications',
                        style: TextStyle(
                          color: darkModeProv.isDarkMode
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      onTap: () {
                        // Handle notifications settings
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.security,
                        color: darkModeProv.isDarkMode
                            ? Colors.white
                            : Colors.black,
                      ),
                      title: Text(
                        'Privacy & Security',
                        style: TextStyle(
                          color: darkModeProv.isDarkMode
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      onTap: () {
                        // Handle privacy settings
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trolley),
            label: 'Troll',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 0,
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => TrollScreen()));
              break;
            case 1:
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => TrollScreen()));
              break;
            case 2:
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => ProfileScreen()));
              break;
          }
        },
      ),
    );
  }
}
