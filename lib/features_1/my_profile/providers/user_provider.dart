import 'package:famibo/features_1/my_profile/models/user_model.dart';
import 'package:famibo/features_1/my_profile/services/firestore_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userStateNotifierProvider =
    StateNotifierProvider<UserStateNotifier, UserState>((ref) {
  return UserStateNotifier(ref);
});


class UserStateNotifier extends StateNotifier<UserState> {
  final Ref _ref;

  UserStateNotifier(this._ref) : super(UserState());

 Future<void> loadUserData() async {
  UserState userData = await _ref.read(firestoreServiceProvider).getUserData();
  state = userData;
  }
}
