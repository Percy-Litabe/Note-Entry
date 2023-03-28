class Product {
  String? objectId;
  String? name;
  String? category;
  String? imageUrl;
  double? price;
  int? prodVolume;
  int? prodStockQuantitiy;

  Product({
    this.objectId,
    this.name,
    this.category,
    this.price,
    this.prodVolume,
    this.prodStockQuantitiy,
    this.imageUrl,
  });

  static Product fromJson(Map<dynamic, dynamic>? map) => Product(
        objectId: map!['objectId'],
        name: map['name'],
        category: map['category'],
        price: map['price'],
        prodVolume: map['prodQuantity'],
        prodStockQuantitiy: map['prodStockQuantitiy'],
        imageUrl: map['imageUrl'],
      );

  List<Product> convertToList(Map<dynamic, dynamic> map) {
    List<Product> products = [];
    for (var i = 0; i < map.length; i++) {
      products.add(Product.fromJson(map['$i']));
    }
    return products;
  }
}
