import 'dart:convert';

import '../models/login_model.dart';
import '../models/signup_model.dart';
import '../utilities/api_helpers.dart';

Resource<LoginModel> postLoginApi(String username, String password) {
  return Resource(
      url: 'https://apitextile.eyeterp.com/product/login',
      body:  json.encode({
        "emailorphonenumber" : username,
        "password": password
      }
      ),
      parse: (response) {
        print(response.body);
        Map<String, dynamic> loginResultMap = jsonDecode(response.body);
        var loginResult = LoginModel.fromJson(loginResultMap);
        return loginResult;
      });
}

Resource<SignUpModel> postSignUpApi(String email, String password,String firstName,String lastName) {
  return Resource(
      url: 'https://apitextile.eyeterp.com/product/adduser',
      body:  json.encode({
        "emailorphonenumber": email,
        "password": password,
        "firstName": firstName,
        "lastName": lastName
      }),
      parse: (response) {
        print(response.body);
        Map<String, dynamic> signupResultMap = jsonDecode(response.body);
        var signupResult = SignUpModel.fromJson(signupResultMap);
        return signupResult;
      });
}

