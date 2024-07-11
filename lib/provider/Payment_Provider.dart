// payment_provider.dart
import 'package:flutter/material.dart';

class PaymentProvider with ChangeNotifier {
  String _address = '';
  String _paymentMethod = 'Cash';

  String get address => _address;
  String get paymentMethod => _paymentMethod;

  void setAddress(String newAddress) {
    _address = newAddress;
    notifyListeners();
  }

  void setPaymentMethod(String newMethod) {
    _paymentMethod = newMethod;
    notifyListeners();
  }
}
