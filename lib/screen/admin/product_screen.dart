import 'package:flutter/material.dart';
import '../../models/product_model.dart';
import '../../services/firestore_service.dart';

final FirestoreService firestoreService = FirestoreService();

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final FirestoreService firestoreService = FirestoreService();

  final namaController = TextEditingController();
  final hargaController = TextEditingController();
  final stokController = TextEditingController();
  final kategoriController = TextEditingController();

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
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          showProductDialog(product: product);
                        },
                      ),

                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          bool? hapus = await showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text("Hapus Produk"),
                              content: const Text(
                                "Yakin ingin menghapus produk ini?",
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, false);
                                  },
                                  child: const Text("Batal"),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context, true);
                                  },
                                  child: const Text("Hapus"),
                                ),
                              ],
                            ),
                          );

                          if (hapus == true) {
                            await firestoreService.deleteProduct(product.id);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showProductDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void showProductDialog({ProductModel? product}) {
    if (product != null) {
      namaController.text = product.nama;
      hargaController.text = product.harga.toString();
      stokController.text = product.stok.toString();
      kategoriController.text = product.kategori;
    } else {
      namaController.clear();
      hargaController.clear();
      stokController.clear();
      kategoriController.clear();
    }

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(product == null ? "Tambah Produk" : "Edit Produk"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: namaController,
                  decoration: const InputDecoration(labelText: "Nama Produk"),
                ),

                TextField(
                  controller: hargaController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Harga"),
                ),

                TextField(
                  controller: stokController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Stok"),
                ),

                TextField(
                  controller: kategoriController,
                  decoration: const InputDecoration(labelText: "Kategori"),
                ),
              ],
            ),
          ),

          actions: [
            TextButton(
              onPressed: () async {
                if (namaController.text.isEmpty ||
                    hargaController.text.isEmpty ||
                    stokController.text.isEmpty ||
                    kategoriController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Semua data wajib diisi")),
                  );

                  return;
                }

                if (product == null) {}
                Navigator.pop(context);
                namaController.clear();
                hargaController.clear();
                stokController.clear();
                kategoriController.clear();
              },
              child: const Text("Batal"),
            ),

            ElevatedButton(
              onPressed: () async {
                if (product == null) {
                  await firestoreService.addProduct(
                    nama: namaController.text,
                    harga: int.parse(hargaController.text),
                    stok: int.parse(stokController.text),
                    kategori: kategoriController.text,
                  );
                } else {
                  await firestoreService.updateProduct(
                    id: product.id,
                    nama: namaController.text,
                    harga: int.parse(hargaController.text),
                    stok: int.parse(stokController.text),
                    kategori: kategoriController.text,
                  );
                }

                Navigator.pop(context);
              },
              child: Text(product == null ? "Simpan" : "Update"),
            ),
          ],
        );
      },
    );
  }
}
