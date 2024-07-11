import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:morfo/provider/tambahTroll_provider.dart';
import 'package:morfo/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DetailProductScreen extends StatefulWidget {
  final dynamic data;
  const DetailProductScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  int qty = 1;
  double _sliderValue = 25.0; 
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final trollProvider = Provider.of<TrollProvider>(context);
    final darkModeProv = Provider.of<DarkModeProvider>(context);
    final List<dynamic> imageList = widget.data['detail_gambar'];
    return Scaffold(
      backgroundColor: darkModeProv.isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'Product Detail',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image Slider
              CarouselSlider(
                items: widget.data['detail_gambar']
                    .map<Widget>((item) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(item),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
                options: CarouselOptions(
                  height: 200,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentImageIndex = index;
                    });
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imageList.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => setState(() {
                      _currentImageIndex = entry.key;
                    }),
                    child: Container(
                      width: 12.0,
                      height: 12.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black)
                            .withOpacity(
                                _currentImageIndex == entry.key ? 0.9 : 0.4),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              // Product Name
              Text(
                widget.data['nameProduct'],
                style: TextStyle(
                  fontSize: 32, // Larger font size
                  fontWeight: FontWeight.bold,
                  color: darkModeProv.isDarkMode ? Colors.white : Colors.black,
                  fontFamily: 'Roboto', // Font family changed
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Price: ${widget.data['price']}',
                style: TextStyle(
                  fontSize: 24, // Larger font size
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic, // Italic style
                  color: darkModeProv.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Details:',
                style: TextStyle(
                  fontSize: 26, // Larger font size
                  fontWeight: FontWeight.bold,
                  color: darkModeProv.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.data['detail'],
                style: TextStyle(
                  fontSize: 18,
                  color: darkModeProv.isDarkMode ? Colors.white : Colors.black,
                  letterSpacing: 1.0, // Letter spacing added
                ),
              ),
              const SizedBox(height: 20),
              // Syncfusion Slider
              SfSlider(
                min: 25.0,
                max: 100.0,
                interval: 25,
                showTicks: true,
                showLabels: true,
                value: _sliderValue,
                stepSize: 25,
                labelFormatterCallback: (actualValue, formattedText) {
                  return '$formattedText cm';
                },
                onChanged: (dynamic value) {
                  setState(() {
                    _sliderValue = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              // Quantity Selector
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (qty > 1) qty -= 1;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(12),
                    ),
                    child: const Icon(Icons.remove, color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      qty.toString(),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: darkModeProv.isDarkMode
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        qty += 1;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(12),
                    ),
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Add to Cart Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    trollProvider.addTroll(
                      Troll(
                        name: widget.data['nameProduct'],
                        harga: 'Rp. ${widget.data['price']}',
                        gambar: widget.data['gambar'],
                        qty: qty,
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            '${widget.data['nameProduct']} Berhasil Ditambah'),
                        action: SnackBarAction(
                          label: 'Batal',
                          onPressed: () {
                            // Batalkan penghapusan barang jika tombol "Batal" ditekan
                            trollProvider.addTroll(
                              Troll(
                                name: widget.data['nameProduct'],
                                harga: 'Rp. ${widget.data['price']}',
                                gambar: widget.data['gambar'],
                                qty: qty,
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Masukkan Keranjang",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
