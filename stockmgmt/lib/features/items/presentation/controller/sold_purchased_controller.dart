import 'package:flutter_riverpod/flutter_riverpod.dart';

class SoldPurchased extends StateNotifier<int> {
  SoldPurchased() : super(0);

  void sold() {
    if (state > 0) {
      state--;
    }
  }

  void purchased() {
    state++;
  }

  int soldQ() {
    return state++;
  }
}

class SoldHome extends StateNotifier<int> {
  SoldHome() : super(0);

  void soldH() {
    state++;
  }
}

class PurchasedHome extends StateNotifier<int> {
  PurchasedHome() : super(0);
  void purchasedH() {
    state++;
  }
}
