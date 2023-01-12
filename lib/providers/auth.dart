import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Uri getUrl(String path) {
  final tokenKey = 'AIzaSyANBiWT4vd823AmY6ZYkkjxZIBm29fvFLY';

  final url = Uri.parse(
      'https://identitytoolkit.googleapis.com/v1/accounts:$path?key=$tokenKey');

  return url;
}

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> _authenticate(
    String email,
    String password,
    String urlSegment,
  ) async {
    final response = await http.post(
      getUrl(urlSegment),
      body: json.encode(
        {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
      ),
    );
    print(json.decode(response.body));
  }

  // REGISTER
  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  // LOGIN
  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }
}
