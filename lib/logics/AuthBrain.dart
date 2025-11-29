import 'dart:convert';

import 'package:brokemusicapp/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthBrain extends ChangeNotifier{
  String _email = "";
  String _accessToken = "";
  String _refreshToken = "";

  get email => _email;
  get accessToken => _accessToken;
  get refreshToken => _refreshToken;

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
        print(response.body);
        return false;
      }
      var resBody= jsonDecode(response.body);
      _accessToken = resBody['token'];
      _refreshToken = resBody['refresh_token'];
      _email = email;
      await cacheRefreshToken(_refreshToken);
      return true;
    } catch(e){
      return false;
    }
  }

  Future<bool> signup(String email, String password) async{
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
      await signin(email, password);
      return true;
    }catch(e){
      rethrow;
    }
  }

  Future<void> cacheRefreshToken(String refreshToken) async{
    SharedPreferences localCache = await SharedPreferences.getInstance();
    localCache.setString(kRefreshTokenKey, refreshToken);
  }

  Future<bool> refreshAccessToken() async{
    try{
      SharedPreferences localCache = await SharedPreferences.getInstance();
      String? cachedRefreshToken = localCache.getString("refresh_token");
      if(cachedRefreshToken != null && _refreshToken == ""){
        _refreshToken = cachedRefreshToken;
      }
      Uri url = Uri.parse("$kServerBaseUrl$kRefreshTokenEndpoint");
      http.Response response = await http.post(url, headers:{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_refreshToken'
      });

      if (response.statusCode > 299){
        return false;
      }

      var resBody = jsonDecode(response.body);
      _accessToken =  resBody["token"];
      return true;
    }catch (e){
      return false;
    }
  }

}

