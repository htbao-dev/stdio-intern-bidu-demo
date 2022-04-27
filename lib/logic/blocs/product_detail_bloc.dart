import 'dart:async';

import 'package:bidu_demo/data/models/product.dart';
import 'package:bidu_demo/data/models/product_detail.dart';
import 'package:bidu_demo/data/repositories/product_repository.dart';

class ProductDetailBloc {
  late ProductDetail? _productDetail;
  final IProductRepository productRepository;

  final StreamController<ProductDetail> _productDetailController =
      StreamController<ProductDetail>.broadcast();
  // final StreamController<bool> _isDataNullController =
  // StreamController<bool>.broadcast();
  Stream<ProductDetail> get productDetailStream =>
      _productDetailController.stream;
  // Stream<bool> get isDataNullStream => _isDataNullController.stream;
  ProductDetailBloc({required this.productRepository});

  void initLoad(Product product) async {
    _productDetail =
        await productRepository.loadProductDetail(product.id ?? '');
    if (_productDetail == null) {
      // _isDataNullController.add(true);
    } else {
      // _isDataNullController.add(false);
      _productDetailController.sink.add(_productDetail!);
    }
  }

  void dispose() {
    _productDetailController.close();
    // _isDataNullController.close();
  }
}
