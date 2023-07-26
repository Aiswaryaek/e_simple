import 'package:http/http.dart';
import 'base_urls.dart';

class Resource<T> {
  String? url;
  String? firebaseToken;
  String? token;
  dynamic id;
  dynamic body;
  T Function(Response response)? parse;

  Resource({this.url,this.firebaseToken, this.token,this.id, this.body, this.parse});
}

Uri getUrl(String component) {
  var url= Uri.parse(BaseUrls.devApiBaseUrl + component);
  return url;
}