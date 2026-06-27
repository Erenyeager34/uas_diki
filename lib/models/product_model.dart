class ProductModel {
  final String id;
  final String nama;
  final int harga;
  final int stok;
  final String kategori;

  ProductModel({
    required this.id,
    required this.nama,
    required this.harga,
    required this.stok,
    required this.kategori,
  });

  factory ProductModel.fromMap(Map<String, dynamic> data, String id) {
    return ProductModel(
      id: id,
      nama: data['nama'] ?? '',
      harga: data['harga'] ?? 0,
      stok: data['stok'] ?? 0,
      kategori: data['kategori'] ?? '',
    );
  }
}
