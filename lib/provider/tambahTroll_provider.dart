import 'package:flutter/foundation.dart';
import 'package:morfo/provider/paymenthistory.dart';

class Troll {
  final String name;
  final int qty;
  final String harga;
  final String gambar;

  Troll({
    required this.name,
    required this.qty,
    required this.harga,
    required this.gambar,
  });
}

class TrollProvider extends ChangeNotifier {
  List<Troll> _listBarang = [];
  List<Troll> get listBarang => _listBarang;

  List<PaymentHistory> _paymentHistory = [];
  List<PaymentHistory> get paymentHistory => _paymentHistory;

  get isPaying => null;

  void addTroll(Troll troll) {
    _listBarang.add(troll);
    notifyListeners();
  }

  void removeTroll(Troll troll) {
    _listBarang.remove(troll);
    notifyListeners();
  }

  void addProductsFromWishlist(List<Troll> wishlistProducts) {
    _listBarang.addAll(wishlistProducts);
    notifyListeners();
  }

  void clearAll() {
    _listBarang.clear();
    notifyListeners();
  }

  void clearTroll() {
    _listBarang.forEach((troll) {
      _listBarang.remove(troll);
    });
    notifyListeners();
  }

  // Function to add payment history
  void addPaymentHistory(PaymentHistory history) {
    _paymentHistory.add(history);
    notifyListeners();
  }

  void removePaymentHistory(int index) {
    _paymentHistory.removeAt(index);
    notifyListeners();
  }
}
