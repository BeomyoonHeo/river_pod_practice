//View -> Controller 요청
import 'package:data_app/domain/product/product.dart';
import 'package:data_app/domain/product/product_http_repository.dart';
import 'package:data_app/main.dart';
import 'package:data_app/store/global_state_store.dart';
import 'package:data_app/views/product/list/product_list_view_store.dart';
import 'package:data_app/views/components/my_alert_dialog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//singletone pattern으로 선언됨
final productController = Provider<ProductController>((ref) {
  //final로 선언하여 singletone으로 유지한다.
  return ProductController(ref);
});

/**
 * 컨트롤러:비지니스 로직 담당 - 컨트롤러는 뷰를 알 필요가 없다.4
 */
class ProductController {
  final Ref _ref;
  final context = naviagtorKey.currentContext!; // 글로벌 하게 의존한다. - main
  ProductController(this._ref);
  //ProductHttpRepository repo = ProductHttpRepository();

  void findAll() async {
    List<Product> productList =
        await _ref.read(productHttpRepository).findAll();
    _ref.read(productListViewStore.notifier).onRefresh(productList);
  }

  // void findAll() {
  //   List<Product> productList = _ref.read(productHttpRepository).findAll();
  //   _ref.read(productListViewStore.notifier).onRefresh(productList);
  // }

  void insert(Product productReqDto) async {
    Product productRespDto =
        await _ref.read(productHttpRepository).insert(productReqDto);
    _ref.read(productListViewStore.notifier).addProduct(productRespDto);
  }

  void delete(int id) async {
    int code = await _ref.read(productHttpRepository).removeProduct(id);
    if (code == 1) {
      _ref.read(productListViewStore.notifier).removeProduct(id);
    } else {
      _ref.read(globalState.notifier).state++;
    }
    // int result = _ref.read(productHttpRepository).removeProduct(id);
    // if (result != 1) {
    //   _ref.read(globalState.notifier).state++;
    //   //MyAlertDialog(context: context, msg: "삭제 실패").showDialog();
    // } else {
    //   _ref.read(productListViewStore.notifier).removeProduct(id);
    // }
  }

  void update(int id, productDto) async {
    Product productRespDto =
        await _ref.read(productHttpRepository).updateById(id, productDto);
    _ref.read(productListViewStore.notifier).update(productRespDto);
  }
}
