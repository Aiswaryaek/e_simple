import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../utilities/api_helpers.dart';

class Webservice {
  Future<T> post<T>(Resource<T> resource) async {
    try {
      Response response;
      response = await http.post(
        getUrl(resource.url!),
        body: resource.body,
      );
      return resource.parse!(response);
    } catch (e) {
      print('*******webservice post******' + e.toString());
      rethrow;
    }
  }
}
