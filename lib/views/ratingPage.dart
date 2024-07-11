import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class RatingPage extends StatefulWidget {
  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  double kualitasIkanRating = 0;
  double jasaKirimRating = 0;
  double pelayananTokoRating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          'Nilai Produk',
          style: GoogleFonts.lato(
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Sukses'),
                    content: Text('Penilaian Anda telah berhasil dikirim!'),
                    actions: [
                      TextButton(
                        child: Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: Text(
              'Kirim',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/logo-apps.png', // Ganti dengan aset gambar Anda
                  height: 200,
                ),
              ),
              SizedBox(height: 20),
              buildRatingRow('Kualitas Ikan', kualitasIkanRating, (rating) {
                setState(() {
                  kualitasIkanRating = rating;
                });
              }),
              Divider(),
              buildRatingRow('Jasa Kirim', jasaKirimRating, (rating) {
                setState(() {
                  jasaKirimRating = rating;
                });
              }),
              Divider(),
              buildRatingRow('Pelayanan Toko', pelayananTokoRating, (rating) {
                setState(() {
                  pelayananTokoRating = rating;
                });
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRatingRow(
      String title, double rating, Function(double) onRatingUpdate) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            title,
            style: GoogleFonts.lato(
              textStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        VerticalDivider(thickness: 1, color: Colors.grey),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: RatingBar.builder(
              initialRating: rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: onRatingUpdate,
            ),
          ),
        ),
      ],
    );
  }
}
