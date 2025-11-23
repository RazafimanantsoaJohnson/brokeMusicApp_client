import 'dart:convert';

import 'package:brokemusicapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthBrain extends ChangeNotifier{
  String _email = "";
  String _accessToken = "";
  String _refreshToken = "";

  Future<bool> signin(String email, String password) async{
    try{
      Uri url = Uri.parse("$kServerBaseUrl$kSigninEndpoint");
      Map<String, String> reqBody = {
        'email': email,
        'password': password
      };

      http.Response response= await http.post(url, body: jsonEncode(reqBody), headers: {
        'Content-Type': 'application/json'
      });
      if (response.statusCode >299) {
        return false;
      }
      var resBody= jsonDecode(response.body);
      _accessToken = resBody['token'];
      _refreshToken = resBody['refresh_token'];
      _email = email;
      return true;
    } catch(e){
      return false;
    }
  }

  Future<void> signup(String email, String password) async{
    try{
      Uri url= Uri.parse("$kServerBaseUrl$kSignupEndpoint");
      Map<String, String> reqBody = {
        'email': email,
        'password': password
      };
      http.Response response= await http.post(url, body: jsonEncode(reqBody), headers: {
        'Content-Type': 'application/json'
      });
      if (response.statusCode > 299){
        throw Exception("error happened when creating this user");
      }
    }catch(e){
      rethrow;
    }
  }

  get accessToken => _accessToken;
}

