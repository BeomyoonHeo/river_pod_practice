import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'views/product/list/product_list_view.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

final naviagtorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: naviagtorKey,
      debugShowCheckedModeBanner: false,
      home: ProductListView(),
    );
  }
}
