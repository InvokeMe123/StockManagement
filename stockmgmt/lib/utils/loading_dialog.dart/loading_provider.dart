import 'package:flutter_riverpod/flutter_riverpod.dart';

final addingItemProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});
final addingBrandProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

// final loadingMemberProfileUpdateProvider = StateProvider.autoDispose<bool>((ref) {
//   return false;
// });

// final passwordForgotEmailControllerProvider = StateProvider.autoDispose<bool>((ref) {
//   return false;
  
// });


// final veryCodeForgotPasswordControllerLoadingProvider = StateProvider.autoDispose<bool>((ref) {
//   return false;
  
// });

// final setPasswordControllerLoadinf = StateProvider.autoDispose<bool>((ref) {
//   return false;
  
// });

// final requestCodeAgainControllerLoading = StateProvider.autoDispose<bool>((ref) {
//   return false;
  
// });