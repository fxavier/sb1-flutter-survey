import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class UserModel extends ParseUser implements ParseCloneable {
  UserModel(String? username, String? password, String? emailAddress)
      : super(username, password, emailAddress);

  UserModel.clone() : this(null, null, null);

  @override
  UserModel clone(Map<String, dynamic> map) =>
      UserModel.clone()..fromJson(map);
}