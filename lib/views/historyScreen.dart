import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morfo/provider/paymenthistory.dart';
import 'package:morfo/provider/tambahTroll_provider.dart';
import 'package:morfo/views/HomeScreen.dart';
import 'package:morfo/views/ratingPage.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          'Histori Pembayaran',
          style: GoogleFonts.lato(
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TrollProvider>(
          builder: (context, myProvider, _) {
            List<PaymentHistory> paymentHistory = myProvider.paymentHistory;
            return ListView.builder(
              itemCount: paymentHistory.length,
              itemBuilder: (context, index) {
                PaymentHistory history = paymentHistory[index];
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    myProvider.removePaymentHistory(index);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Histori pembayaran dihapus')),
                    );
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Metode Pembayaran: ${history.paymentMethod}',
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              PopupMenuButton<String>(
                                onSelected: (String value) {
                                  switch (value) {
                                    case 'Beli Lagi':
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomeScreen()),
                                      );
                                      break;
                                    case 'Rating':
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => RatingPage()),
                                      );
                                      break;
                                  }
                                },
                                itemBuilder: (BuildContext context) {
                                  return {'Beli Lagi', 'Rating'}
                                      .map((String choice) {
                                    return PopupMenuItem<String>(
                                      value: choice,
                                      child: Text(choice),
                                    );
                                  }).toList();
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          
                          SizedBox(height: 4),
                          Text(
                            'Total Ikan: ${history.totalFish}',
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Total Harga: ${history.totalPrice}',
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Alamat: ${history.address}',
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
