import 'package:flutter/material.dart';
import 'package:morfo/provider/theme_provider.dart';
import 'package:morfo/views/HomeScreen.dart';
import 'package:morfo/views/LoginScreen.dart';
import 'package:morfo/views/pengaturanScreen.dart';
import 'package:morfo/views/trollScreen.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/background.jpg'), // Add your background image here
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5),
                  BlendMode.dstATop,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.amber,
                      radius: 50,
                      backgroundImage: AssetImage(
                          'assets/avatar.png'), // Add your avatar image here
                    ),
                    SizedBox(width: 30),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Text(
                            "John Doe",
                            style: TextStyle(
                              color: darkModeProv.isDarkMode
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "johndoe@gmail.com",
                            style: TextStyle(
                              fontSize: 16,
                              color: darkModeProv.isDarkMode
                                  ? Colors.white70
                                  : Colors.black87,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Jakarta, Indonesia",
                            style: TextStyle(
                              fontSize: 16,
                              color: darkModeProv.isDarkMode
                                  ? Colors.white70
                                  : Colors.black87,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "+62 812-3456-7890",
                            style: TextStyle(
                              fontSize: 16,
                              color: darkModeProv.isDarkMode
                                  ? Colors.white70
                                  : Colors.black87,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "1 Januari 1990",
                            style: TextStyle(
                              fontSize: 16,
                              color: darkModeProv.isDarkMode
                                  ? Colors.white70
                                  : Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Text(
                  "Recent Activities",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color:
                        darkModeProv.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                // Display recent activities
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildActivityItem("Logged in", "2 hours ago"),
                      _buildActivityItem("Purchased Ikan koi", "Yesterday"),
                      _buildActivityItem(
                          "Added Ikan Guppy to wishlist", "3 days ago"),
                      SizedBox(height: 20),
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                            );
                          },
                          icon: Icon(Icons.logout),
                          label: Text("Logout"),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Troll',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 2,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomeScreen()));
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

  Widget _buildActivityItem(String activity, String time) {
    return ListTile(
      leading: Icon(Icons.check_circle, color: Colors.green),
      title: Text(
        activity,
        style: TextStyle(
          color: Provider.of<DarkModeProvider>(context).isDarkMode
              ? Colors.white
              : Colors.black,
        ),
      ),
      subtitle: Text(
        time,
        style: TextStyle(
          color: Provider.of<DarkModeProvider>(context).isDarkMode
              ? Colors.white70
              : Colors.black87,
        ),
      ),
    );
  }
}

enum MenuItem { Profil, Pengaturan, Logout }
