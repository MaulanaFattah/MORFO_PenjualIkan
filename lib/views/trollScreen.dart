import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:morfo/provider/tambahTroll_provider.dart';
import 'package:morfo/provider/theme_provider.dart';
import 'package:morfo/views/HomeScreen.dart';
import 'package:morfo/views/LoginScreen.dart';
import 'package:morfo/views/paymentScreen.dart';
import 'package:morfo/views/pengaturanScreen.dart';
import 'package:morfo/views/profileScreen.dart';
import 'package:provider/provider.dart';

class TrollScreen extends StatefulWidget {
  const TrollScreen({Key? key}) : super(key: key);

  @override
  State<TrollScreen> createState() => _TrollScreenState();
}

class _TrollScreenState extends State<TrollScreen> {
  @override
  Widget build(BuildContext context) {
    final trollProv = Provider.of<TrollProvider>(context);
    final darkModeProv = Provider.of<DarkModeProvider>(context);
    return Scaffold(
      backgroundColor: darkModeProv.isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'Koi Fish',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
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
              const PopupMenuItem(
                value: MenuItem.Profil,
                child: Text('Profil'),
              ),
              const PopupMenuItem(
                value: MenuItem.Pengaturan,
                child: Text('Pengaturan'),
              ),
              const PopupMenuItem(
                value: MenuItem.Logout,
                child: Text('Logout'),
              ),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'My Troll',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: trollProv.listBarang.length,
                itemBuilder: (context, index) {
                  final barang = trollProv.listBarang[index];
                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(barang.gambar),
                      ),
                      title: Text(
                        barang.name,
                        style: TextStyle(
                          color: darkModeProv.isDarkMode
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        '${barang.qty} x ${barang.harga}',
                        style: TextStyle(
                          color: darkModeProv.isDarkMode
                              ? Colors.white70
                              : Colors.black87,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: darkModeProv.isDarkMode
                              ? Colors.white
                              : Colors.black,
                        ),
                        onPressed: () {
                          trollProv.removeTroll(barang);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${barang.name} dihapus'),
                              action: SnackBarAction(
                                label: 'Batal',
                                onPressed: () {
                                  trollProv.addTroll(barang);
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              Card(
                color: darkModeProv.isDarkMode
                    ? Colors.grey[850]
                    : Colors.grey[200],
                elevation: 0, // Menghilangkan bayangan
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.fish,
                            color: darkModeProv.isDarkMode
                                ? Colors.white
                                : Colors.black,
                            size: 30,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Total Ikan:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: darkModeProv.isDarkMode
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              '${trollProv.listBarang.fold(0, (total, troll) => total + troll.qty)}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.moneyBillWave,
                            color: darkModeProv.isDarkMode
                                ? Colors.white
                                : Colors.black,
                            size: 30,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Total Harga:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: darkModeProv.isDarkMode
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Rp. ${trollProv.listBarang.fold(0, (total, troll) => total + (troll.qty * int.parse(troll.harga.replaceAll("Rp. ", ""))))}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PaymentScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Bayar Sekarang',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
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
        currentIndex: 1,
        selectedItemColor: Colors.red,
        unselectedItemColor:
            darkModeProv.isDarkMode ? Colors.white70 : Colors.black54,
        backgroundColor: darkModeProv.isDarkMode ? Colors.black : Colors.white,
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
}
