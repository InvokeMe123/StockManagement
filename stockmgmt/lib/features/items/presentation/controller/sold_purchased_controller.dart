import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class SoldPurchased extends StateNotifier<int> {
  SoldPurchased() : super(0);

  void soldQuantity({required int count}) {
    state += count;
    log(state.toString());
  }

  void purchasedQuantity({required int count}) {
    state -= count;
    log(state.toString());
  }
}

final soldPurchasedProvider = StateNotifierProvider<SoldPurchased, int>((ref) {
  return SoldPurchased();
});
