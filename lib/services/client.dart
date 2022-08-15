import 'dart:convert';

import 'package:memri_web/model/user_commits.dart';
import 'package:http/http.dart' as http;

class Client {
  String url = 'http://0.0.0.0:5001/api';

  Future<List<User>> fetchUsers() async {
    try {
      http.Response response = await http.get(Uri.parse(url));
      var bodyJson = jsonDecode(response.body);

      List<User> users =
          bodyJson.map((e) => User.fromMap(e)).toList().cast<User>();

      return users;
    } catch (e) {
      return [];
    }
  }
}
