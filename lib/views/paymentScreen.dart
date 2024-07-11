import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:morfo/provider/tambahTroll_provider.dart';
import 'package:morfo/provider/paymenthistory.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController _addressController = TextEditingController();
  String? _selectedPaymentMethod;
  bool _isPaying = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembayaran'),
        backgroundColor: Colors.red,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tambahkan Alamat Anda',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan alamat lengkap Anda',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Metode Pembayaran',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildPaymentMethodRadio(
                          context,
                          'Debit Kartu BCA',
                          'assets/images/bca_logo.png',
                        ),
                        const SizedBox(height: 8),
                        _buildPaymentMethodRadio(
                          context,
                          'Debit Kartu BRI',
                          'assets/images/bri_logo.png',
                        ),
                        const SizedBox(height: 8),
                        _buildPaymentMethodRadio(
                          context,
                          'Debit Kartu Mandiri',
                          'assets/images/mandiri_logo.png',
                        ),
                        const SizedBox(height: 8),
                        _buildPaymentMethodRadio(
                          context,
                          'COD (Bayar di Tempat)',
                          'assets/images/logo_cod.png',
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                Consumer<TrollProvider>(
                  builder: (context, trollProv, _) {
                    int totalIkan = trollProv.listBarang
                        .fold(0, (total, troll) => total + troll.qty);
                    int totalHarga = trollProv.listBarang.fold(
                        0,
                        (total, troll) =>
                            total +
                            (troll.qty *
                                int.parse(troll.harga.replaceAll("Rp. ", ""))));
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ringkasan Pembayaran',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ListTile(
                            leading: FaIcon(
                              FontAwesomeIcons.fish,
                              color: Colors.black,
                              size: 30,
                            ),
                            title: Text(
                              'Total Ikan:',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            trailing: Text(
                              '$totalIkan',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          const Divider(),
                          ListTile(
                            leading: FaIcon(
                              FontAwesomeIcons.moneyBillWave,
                              color: Colors.black,
                              size: 30,
                            ),
                            title: Text(
                              'Total Harga:',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            trailing: Text(
                              'Rp. $totalHarga',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: ElevatedButton(
                              onPressed: _isPaying
                                  ? null
                                  : () => _processPayment(context),
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
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          if (_isPaying)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodRadio(
      BuildContext context, String title, String logoPath) {
    return ListTile(
      leading: Image.asset(logoPath, width: 40, height: 40),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
      ),
      trailing: Radio<String>(
        value: title,
        groupValue: _selectedPaymentMethod,
        onChanged: (value) {
          setState(() {
            _selectedPaymentMethod = value;
          });
        },
        activeColor: Colors.red,
      ),
      onTap: () {
        setState(() {
          _selectedPaymentMethod = title;
        });
      },
    );
  }

  void _processPayment(BuildContext context) {
    setState(() {
      _isPaying = true;
    });

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isPaying = false;
      });

      String address = _addressController.text;
      if (address.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Alamat tidak boleh kosong'),
          ),
        );
        return;
      }

      if (_selectedPaymentMethod == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Silakan pilih metode pembayaran'),
          ),
        );
        return;
      }

      final trollProv = Provider.of<TrollProvider>(context, listen: false);
      int totalIkan =
          trollProv.listBarang.fold(0, (total, troll) => total + troll.qty);
      int totalHarga = trollProv.listBarang.fold(
        0,
        (total, troll) =>
            total + (troll.qty * int.parse(troll.harga.replaceAll("Rp. ", ""))),
      );

      final paymentHistory = PaymentHistory(
        address: address,
        paymentMethod: _selectedPaymentMethod!,
        totalFish: totalIkan,
        totalPrice: totalHarga,
      );

      trollProv.addPaymentHistory(paymentHistory);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Pembayaran berhasil dengan metode: $_selectedPaymentMethod'),
        ),
      );

      Navigator.pop(context);
    });
  }
}

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TrollProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: PaymentScreen(),
      ),
    ),
  );
}
