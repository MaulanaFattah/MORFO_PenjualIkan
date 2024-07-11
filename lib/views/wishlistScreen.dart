import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:morfo/provider/tambahTroll_provider.dart';
import 'package:morfo/provider/wishlist_provider.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final trollProvider = Provider.of<TrollProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'Wishlist',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: ListView.separated(
        key: Key('wishlist_list'),
        itemCount: wishlistProvider.wishlist.length,
        itemBuilder: (context, index) {
          Troll troll = wishlistProvider.wishlist[index];
          return ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: troll.gambar,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            title: Text(
              troll.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              troll.harga,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            onTap: () {
              _showFishImageDialog(context, troll.gambar);
            },
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    trollProvider.addTroll(troll);
                    wishlistProvider.removeWishlist(troll.name);
                  },
                  child: Icon(Icons.shopping_cart, color: Colors.green),
                ),
                SizedBox(width: 8),
                InkWell(
                  onTap: () {
                    wishlistProvider.removeWishlist(troll.name);
                  },
                  child: Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(
          color: Colors.grey,
          thickness: 1,
          indent: 20,
        ),
      ),
    );
  }

  void _showFishImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          width: double.infinity,
          height: 300,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }
}
