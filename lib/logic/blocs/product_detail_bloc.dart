import 'dart:async';

import 'package:bidu_demo/data/models/product.dart';
import 'package:bidu_demo/data/models/product_detail.dart';
import 'package:bidu_demo/data/repositories/product_repository.dart';

class ProductDetailBloc {
  late ProductDetail? _productDetail;
  final IProductRepository productRepository;

  final StreamController<ProductDetail> _productDetailController =
      StreamController<ProductDetail>.broadcast();
  final StreamController<List<Product>> _suggestProductController =
      StreamController<List<Product>>.broadcast();

  Stream<List<Product>> get suggestProductStream =>
      _suggestProductController.stream;

  Stream<ProductDetail> get productDetailStream =>
      _productDetailController.stream;
  ProductDetailBloc({required this.productRepository});

  void initLoad(Product product) async {
    _productDetail =
        await productRepository.loadProductDetail(product.id ?? '');
    if (_productDetail == null) {
    } else {
      _productDetailController.sink.add(_productDetail!);
    }
  }

  void loadSuggestion() async {
    final suggestProduct =
        await productRepository.loadSuggestProducts(page: 1, limit: 9);
    _suggestProductController.sink.add(suggestProduct?.listProduct ?? []);
  }

  void dispose() {
    _productDetailController.close();
    _suggestProductController.close();
  }
}
