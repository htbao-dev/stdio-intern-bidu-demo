import 'package:bidu_demo/data/models/product.dart';

class SuggestProduct {
  final List<Product> listProduct;
  final int totalPage;
  final int currentPage;
  final int randomNumber;

  SuggestProduct({
    required this.listProduct,
    required this.totalPage,
    required this.currentPage,
    required this.randomNumber,
  });

  factory SuggestProduct.fromMap(Map<String, dynamic> map) {
    return SuggestProduct(
      listProduct: listProductFromMap(map['data']),
      totalPage: map['paginate']['total_page'],
      currentPage: map['paginate']['page'],
      randomNumber: map['paginate']['random_number'],
    );
  }
}
