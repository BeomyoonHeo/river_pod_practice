import 'package:data_app/domain/product/product.dart';
import 'package:data_app/domain/product/product_http_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productListViewStore =
    StateNotifierProvider<ProductListViewStore, List<Product>>((ref) {
  return ProductListViewStore([], ref)..initViewModel(); // cascade연산자
});

class ProductListViewStore extends StateNotifier<List<Product>> {
  Ref _ref;
  ProductListViewStore(super.state, this._ref);

  void initViewModel() async {
    List<Product> products = await _ref.read(productHttpRepository).findAll();
    state = products;
  }

  void onRefresh(List<Product> products) {
    state = products;
  }

  void addProduct(Product productRespDto) {
    state = [...state, productRespDto];
  }

  void removeProduct(int id) {
    state = state.where((product) => product.id != id).toList();
  }

  void update(Product productDto) {
    state = state.map((product) {
      if (product.id == productDto.id) {
        return productDto;
      } else {
        return product;
      }
    }).toList();
  }
}
