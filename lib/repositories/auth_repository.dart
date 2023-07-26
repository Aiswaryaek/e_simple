// ignore_for_file: prefer_typing_uninitialized_variables


import '../services/auth_services.dart';
import '../services/web_service.dart';
class AuthRepository {
  var webService;

  AuthRepository() {
    webService = Webservice();
  }
  Future login(String email, String password) => webService?.post(postLoginApi(email,password));
}