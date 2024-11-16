class ProductModel {
  final String storeId;
  final String productId;
  final String productImage;
  final String plantName;
  final String plantPrice;
  final String plantCategory;
  final String plantDesc;

  ProductModel({
    required this.storeId,
    required this.productId,
    required this.productImage,
    required this.plantName,
    required this.plantPrice,
    required this.plantCategory,
    required this.plantDesc,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      storeId: map['storeid'] ?? '',
      productId: map['productId'] ?? '',
      productImage: map['productImage'] ?? '',
      plantName: map['plantName'] ?? '',
      plantPrice: map['plantPrice'] ?? '',
      plantCategory: map['plantCategory'] ?? '',
      plantDesc: map['plantDesc'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'storeid': storeId,
      'productId': productId,
      'productImage': productImage,
      'plantName': plantName,
      'plantPrice': plantPrice,
      'plantCategory': plantCategory,
      'plantDesc': plantDesc,
    };
  }
}
