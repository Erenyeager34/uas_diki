import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'product_screen.dart';

class AdminDashboard extends StatelessWidget {
  AdminDashboard({super.key});

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<int> totalProduk() {
    return firestore
        .collection('products')
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  Stream<int> totalTransaksi() {
    return firestore
        .collection('transactions')
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard Admin"), centerTitle: true),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: ListView(
          children: [
            const Text(
              "Halo, Admin 👋",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            StreamBuilder<int>(
              stream: totalProduk(),
              builder: (context, snapshot) {
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.inventory),
                    title: const Text("Total Produk"),
                    trailing: Text(
                      "${snapshot.data ?? 0}",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 15),

            StreamBuilder<int>(
              stream: totalTransaksi(),
              builder: (context, snapshot) {
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.receipt_long),
                    title: const Text("Total Transaksi"),
                    trailing: Text(
                      "${snapshot.data ?? 0}",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 25),

            Card(
              child: ListTile(
                leading: const Icon(Icons.shopping_bag),
                title: const Text("Kelola Produk"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ProductScreen()),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            Card(
              child: ListTile(
                leading: const Icon(Icons.history),
                title: const Text("Riwayat Transaksi"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
            ),

            const SizedBox(height: 10),

            Card(
              child: ListTile(
                leading: const Icon(Icons.logout),
                title: const Text("Logout"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
