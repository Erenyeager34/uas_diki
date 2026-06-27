import 'package:flutter/material.dart';
import '../../models/product_model.dart';
import '../../services/firestore_service.dart';

final FirestoreService firestoreService = FirestoreService();

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kelola Produk")),
      body: StreamBuilder<List<ProductModel>>(
        stream: firestoreService.getProducts(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final products = snapshot.data!;

          if (products.isEmpty) {
            return const Center(child: Text("Belum ada produk"));
          }

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];

              return Card(
                margin: const EdgeInsets.all(10),

                child: ListTile(
                  title: Text(product.nama),

                  subtitle: Text("Rp ${product.harga}\nStok : ${product.stok}"),

                  isThreeLine: true,

                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit),
                      ),

                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
