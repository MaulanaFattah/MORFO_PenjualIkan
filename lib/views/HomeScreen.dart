import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:morfo/data/data.dart';
import 'package:morfo/provider/tambahTroll_provider.dart';
import 'package:morfo/provider/theme_provider.dart';
import 'package:morfo/provider/wishlist_provider.dart';
import 'package:morfo/views/DetailProduct.dart';
import 'package:morfo/views/LoginScreen.dart';
import 'package:morfo/views/historyScreen.dart';
import 'package:morfo/views/pengaturanScreen.dart';
import 'package:morfo/views/profileScreen.dart';
import 'package:morfo/views/trollScreen.dart';
import 'package:morfo/views/wishlistScreen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Example: Simulate loading for 2 seconds
  }

  @override
  Widget build(BuildContext context) {
    final trollProvider = Provider.of<TrollProvider>(context);
    final darkModeProv = Provider.of<DarkModeProvider>(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);

    List<Map<String, dynamic>> filteredProducts = productList.where((product) {
      final productName = product['nameProduct'].toString().toLowerCase();
      final searchTerm = _searchController.text.toLowerCase();
      return productName.contains(searchTerm);
    }).toList();

    return Scaffold(
      backgroundColor: darkModeProv.isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          'Koi Fish',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border_outlined, color: Colors.white),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => WishlistScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.history, color: Colors.white),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => HistoryScreen()),
              );
            },
          ),
          PopupMenuButton<MenuItem>(
            onSelected: (value) {
              if (value == MenuItem.Logout) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: MenuItem.Logout,
                child: Text('Logout'),
              ),
            ],
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(
                        'https://example.com/profile.jpg'), // Ganti dengan URL gambar profil pengguna
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Nama Pengguna', // Ganti dengan nama pengguna
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'email.pengguna@example.com', // Ganti dengan email pengguna
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.of(context)
                    .pop(); // Tutup drawer sebelum pindah layar
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Troll'),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => TrollScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('History'),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HistoryScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.bookmark),
              title: Text('Bookmark'),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => WishlistScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Pengaturan'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PengaturanScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Product Kami',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: darkModeProv.isDarkMode
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                  TextField(
                    controller: _searchController,
                    style: TextStyle(
                      color:
                          darkModeProv.isDarkMode ? Colors.white : Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(
                        Icons.search,
                        color: darkModeProv.isDarkMode
                            ? Colors.white
                            : Colors.black,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (_) {
                      setState(() {});
                    },
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: (filteredProducts.length / 2).ceil(),
                      itemBuilder: (context, index) {
                        final int item1Index = index * 2;
                        final int item2Index = index * 2 + 1;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (item1Index < filteredProducts.length) ...[
                              _buildProductItem(
                                filteredProducts[item1Index],
                                darkModeProv,
                                trollProvider,
                                wishlistProvider,
                              ),
                            ],
                            if (item2Index < filteredProducts.length) ...[
                              _buildProductItem(
                                filteredProducts[item2Index],
                                darkModeProv,
                                trollProvider,
                                wishlistProvider,
                              ),
                            ],
                            if (item2Index >= filteredProducts.length) ...[
                              Expanded(child: Container()),
                            ],
                          ],
                        );
                      },
                    ),
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
            icon: Icon(Icons.shopping_cart),
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
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
              break;
            case 1:
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => TrollScreen()),
              );
              break;
            case 2:
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
              break;
          }
        },
      ),
    );
  }

  Widget _buildProductItem(
    Map<String, dynamic> product,
    DarkModeProvider darkModeProv,
    TrollProvider trollProvider,
    WishlistProvider wishlistProvider,
  ) {
    bool isInWishlist = wishlistProvider.isInWishlist(product['nameProduct']);
    double rating = product['rating'] ?? 3.0; // Default rating to 3.0 if null

    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DetailProductScreen(data: product),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Image.network(
                  product['gambar'],
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 8),
              Text(
                product['nameProduct'],
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: darkModeProv.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              RatingBarIndicator(
                rating: rating,
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 20.0,
                direction: Axis.horizontal,
              ),
              Row(
                children: [
                  Text(
                    'Rp. ${product['price']}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color:
                          darkModeProv.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(width: 5),
                  IconButton(
                    icon: isInWishlist
                        ? Icon(Icons.favorite, color: Colors.red)
                        : Icon(Icons.favorite_border, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        if (isInWishlist) {
                          wishlistProvider
                              .removeWishlist(product['nameProduct']);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  '${product['nameProduct']} dihapus dari wishlist'),
                            ),
                          );
                        } else {
                          wishlistProvider.addToWishlist(
                            Troll(
                              name: product['nameProduct'],
                              harga: 'Rp. ${product['price']}',
                              gambar: product['gambar'],
                              qty: 1,
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  '${product['nameProduct']} ditambahkan ke wishlist'),
                            ),
                          );
                        }
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
