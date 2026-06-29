import 'package:flutter/material.dart';
import '../../models/cart_item.dart';

class CartScreen extends StatefulWidget {
  final List<CartItem> cart;

  const CartScreen({super.key, required this.cart});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double get total {
    double jumlah = 0;

    for (var item in widget.cart) {
      jumlah += item.product.harga * item.qty;
    }

    return jumlah;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Keranjang")),

      body: widget.cart.isEmpty
          ? const Center(child: Text("Keranjang masih kosong"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.cart.length,

                    itemBuilder: (context, index) {
                      final item = widget.cart[index];

                      return Card(
                        margin: const EdgeInsets.all(10),

                        child: ListTile(
                          title: Text(item.product.nama),

                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Rp ${item.product.harga}"),

                              Text(
                                "Subtotal : Rp ${item.product.harga * item.qty}",
                              ),
                            ],
                          ),

                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,

                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (item.qty > 1) {
                                      item.qty--;
                                    }
                                  });
                                },

                                icon: const Icon(Icons.remove),
                              ),

                              Text("${item.qty}"),

                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    item.qty++;
                                  });
                                },

                                icon: const Icon(Icons.add),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                Container(
                  padding: const EdgeInsets.all(20),

                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          const Text(
                            "Total",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Text(
                            "Rp ${total.toInt()}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,

                        child: ElevatedButton(
                          onPressed: () {},

                          child: const Text("Checkout"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
