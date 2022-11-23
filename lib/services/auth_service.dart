import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyD-GHd3W-9aOG7FL922reEs13qNMkciaGo';

// REGISTER USUARIO
// Si retona algo es un error, de lo contrario va bien
  Future<String?> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };
    final url =
        Uri.https(_baseUrl, '/v1/accounts:signUp', {'key': _firebaseToken});

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodeResp = json.decode(resp.body);

    print(decodeResp);

    if (decodeResp.containsKey('idToken')) {
      // Token: hay que guardarlo en un lugar seguro

      return null;
      //decodeResp['idToken'];
    } else {
      return decodeResp['error']['message'];
    }
  }

//LOGIN USUARIO
  // Si retona algo es un error, de lo contrario va bien
  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };
    final url = Uri.https(
        _baseUrl, '/v1/accounts:signInWithPassword', {'key': _firebaseToken});

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodeResp = json.decode(resp.body);

    print(decodeResp);

    if (decodeResp.containsKey('idToken')) {
      // Token: hay que guardarlo en un lugar seguro

      return null;
      //decodeResp['idToken'];
    } else {
      return decodeResp['error']['message'];
    }
  }
}