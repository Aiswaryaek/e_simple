// ignore_for_file: prefer_typing_uninitialized_variables


import '../services/auth_services.dart';
import '../services/web_service.dart';
class AuthRepository {
  var webService;

  AuthRepository() {
    webService = Webservice();
  }
  Future login(String username, String password,) => webService?.post(postLoginApi(username, password));
  Future signUpData(
      String email, String password, String firstName, String lastName) =>
      webService?.post(postSignUpApi(email, password, firstName, lastName));
}