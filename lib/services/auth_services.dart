import 'dart:convert';

import '../models/login_model.dart';
import '../utilities/api_helpers.dart';

Resource<LoginModel> postLoginApi(
    String email, String password) {
  return Resource(
      url: '/api/login',
      body: {
        'email': email,
        'password': password,
        'firebase_token':
            'f_uSEsbkQLCNWWlAex79ow:APA91bF8CbrAaL2wbHlfAUDv4QEZ5Alb36g4c4iFs0ib93ViA2AuzRkVnK1rln1QfU6z0Lre8S5msWUl_WhnjfUociWk0FNw3gmmVZqL54p-kYwSEHzl4DUplmu6dHEO_UNjKXfEonM0'
      },
      parse: (response) {
        print(response.body);
        Map<String, dynamic> loginResultMap = jsonDecode(response.body);
        var loginResult = LoginModel.fromJson(loginResultMap);
        return loginResult;
      });
}
