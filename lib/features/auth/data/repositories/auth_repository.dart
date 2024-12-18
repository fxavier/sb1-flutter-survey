import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:survey_app/features/auth/data/models/user_model.dart';

class AuthRepository {
  Future<UserModel?> login(String username, String password) async {
    try {
      final user = UserModel(username, password, null);
      final response = await user.login();
      
      if (response.success && response.results != null) {
        return response.results!.first as UserModel;
      }
      throw ParseException(response.error?.code, response.error?.message);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    final user = await ParseUser.currentUser() as UserModel?;
    await user?.logout();
  }
}