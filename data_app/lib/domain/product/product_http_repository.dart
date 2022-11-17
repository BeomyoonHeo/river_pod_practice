import 'dart:convert';

import 'package:data_app/domain/http_connector.dart';
import 'package:data_app/domain/product/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

final productHttpRepository = Provider<ProductHttpRepository>((ref) {
  return ProductHttpRepository(ref);
});

class ProductHttpRepository {
  final Ref _ref;
  ProductHttpRepository(this._ref);
  //Fake data
  List<Product> list = [
    Product(id: 1, name: "바나나", price: 1000),
    Product(id: 2, name: "딸기", price: 2000),
    Product(id: 3, name: "참외", price: 3000),
  ];

  Product findById(int id) {
    //통신을 하기위해선 Future를 사용해야한다. - 약속(promise) observer pattern
    //http 통신 코드
    Product product = list.singleWhere((product) => product.id == id);
    return product;
  }

  Future<List<Product>> findAll() async {
    Response response = await _ref.read(httpConnector).get("/api/product");
    List<dynamic> body = // 해당 type을 알 수 없기 때문에 dynamic으로 받는다.
        jsonDecode(response.body)["data"]; // body값을 map type으로 변경
    return body.map((productMap) => Product.fromJson(productMap)).toList();
  }

  //name, price
  Future<Product> insert(Product productReqDto) async {
    //http 통신 코드(product 전송)

    String body = jsonEncode(productReqDto.toJson());
    Response response =
        await _ref.read(httpConnector).post("/api/product", body);

    Product product = Product.fromJson(jsonDecode(response.body)["data"]);

    return product;
  }

  Future<Product> updateById(int id, Product productReqDto) async {
    //http 통신 코드

    String body = jsonEncode(productReqDto.toJson());
    Response response =
        await _ref.read(httpConnector).put("/api/product/${id}", body);

    Product product = Product.fromJson(jsonDecode(response.body)["data"]);

    return product;
    // list = list.map((product) {
    //   if (product.id == id) {
    //     product = productDto;
    //   } else {
    //     return product;
    //   }
    //   return product;
    // }).toList();
    //
    // productDto.id = id;
    //
    // return productDto;
  }

  Future<int> removeProduct(int id) async {
    //http 통신 코드
    Response response =
        await _ref.read(httpConnector).delete("/api/product/${id}");
    int result = jsonDecode(response.body)["code"];
    return result;
  }
}
