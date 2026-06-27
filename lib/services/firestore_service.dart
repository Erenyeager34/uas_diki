import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // READ
  Stream<List<ProductModel>> getProducts() {
    return _firestore.collection('products').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => ProductModel.fromMap(doc.data(), doc.id))
          .toList();
    });
  }

  // CREATE
  Future<void> addProduct({
    required String nama,
    required int harga,
    required int stok,
    required String kategori,
  }) async {
    await _firestore.collection('products').add({
      'nama': nama,
      'harga': harga,
      'stok': stok,
      'kategori': kategori,
    });
  }

  // UPDATE
  Future<void> updateProduct({
    required String id,
    required String nama,
    required int harga,
    required int stok,
    required String kategori,
  }) async {
    await _firestore.collection('products').doc(id).update({
      'nama': nama,
      'harga': harga,
      'stok': stok,
      'kategori': kategori,
    });
  }

  // DELETE
  Future<void> deleteProduct(String id) async {
    await _firestore.collection('products').doc(id).delete();
  }
}
