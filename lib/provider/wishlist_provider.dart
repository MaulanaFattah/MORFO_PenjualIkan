import 'package:flutter/material.dart';
import 'package:morfo/provider/tambahTroll_provider.dart';

class WishlistProvider with ChangeNotifier {
  List<Troll> _wishlist =
      []; // List untuk menyimpan item yang ditambahkan ke wishlist

  // Getter untuk mendapatkan daftar wishlist
  List<Troll> get wishlist => _wishlist;

  // Menambahkan item ke wishlist
  void addToWishlist(Troll troll) {
    _wishlist.add(troll);
    notifyListeners(); // Memberitahu semua listener (widget) bahwa data telah berubah
  }

  // Menghapus item dari wishlist berdasarkan nama produk
  void removeWishlist(String productName) {
    _wishlist.removeWhere((troll) => troll.name == productName);
    notifyListeners(); // Memberitahu semua listener (widget) bahwa data telah berubah
  }

  // Memeriksa apakah item sudah ada di wishlist berdasarkan nama produk
  bool isInWishlist(String productName) {
    return _wishlist.any((troll) => troll.name == productName);
  }

  // Membersihkan wishlist
  void clearWishlist() {
    _wishlist.clear();
    notifyListeners(); // Memberitahu semua listener (widget) bahwa data telah berubah
  }
}
