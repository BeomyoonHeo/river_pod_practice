import 'package:flutter_riverpod/flutter_riverpod.dart';

final globalState = StateProvider<int>((ref) {
  return 1;
});
