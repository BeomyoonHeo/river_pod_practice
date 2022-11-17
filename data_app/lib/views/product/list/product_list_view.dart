import 'package:data_app/controller/product_controller.dart';
import 'package:data_app/domain/product/product.dart';
import 'package:data_app/store/global_state_store.dart';
import 'package:data_app/views/components/my_alert_dialog.dart';
import 'package:data_app/views/product/list/product_list_view_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductListView extends ConsumerWidget {
  const ProductListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pc = ref.read(
        productController); // singletone으로 하기 위해서 provider에서 해당 Controller를 가지고 있게 한다.
    final pm = ref.watch(productListViewStore);
    final globalListener = ref.listen(globalState, (previous, next) {
      MyAlertDialog(context: context, msg: "실패").showDialog();
    });

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pc.insert(Product(id: pm.length + 1, name: "밤", price: 1000));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(title: Text("product_list_page")),
      body: _buildListView(pm, pc),
    );
  }

  Widget _buildListView(List<Product> pm, ProductController pc) {
    if (!(pm.length > 0)) {
      return Center(
        child: Image.asset("assets/image/img.gif"),
      );
    } else {
      return ListView.builder(
        itemCount: pm.length,
        itemBuilder: (context, index) => ListTile(
          key: ValueKey(pm[index].id.toString()),
          onTap: () {},
          onLongPress: () {
            Product productReqDto = pm[index];
            productReqDto.price = 20000;
            pc.update(pm[index].id, productReqDto);
          },
          leading: IconButton(
            onPressed: () {
              pc.delete(pm[index].id);
            },
            icon: Icon(Icons.shopping_cart),
          ),
          title: Text("${pm[index].name}",
              style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text("${pm[index].price}"),
        ),
      );
    }
  }
}
