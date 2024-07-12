import 'package:user_entries/bloc/users_event.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/userdetails.dart';

class UserRepository {
  static String _baseUrl = 'https://reqres.in/api/users';
  static getUserLists(int page) async {
    var response = await http.get(Uri.parse("$_baseUrl?page=${page}"));
    final dynamic json = jsonDecode(response.body);
    final List usersList = json["data"];
    final List<Userr> newUsers =
        usersList.map((p) => Userr.fromJson(p)).toList();
    return newUsers;
  }

  static getUserDetails(int userId) async {
    var resp = await http.get(Uri.parse("$_baseUrl/${userId}"));
    final dynamic json = jsonDecode(resp.body);
    final user = json["data"];
    return Userr.fromJson(user);
  }
}
