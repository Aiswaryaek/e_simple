import 'dart:io';

import '../services/catalog_services.dart';
import '../services/web_service.dart';


class CatalogRepository {
  var webService;
  CatalogRepository() {
    this.webService = Webservice();
  }
  Future getCategoryListData() =>
      webService?.get(getCategoryListApi());

  // Future getProductListData(String id,String location) =>
  //     webService?.get(getProductListApi(id,location));


  Future getTrendingProductListData() =>
      webService?.get(getTrendingProductListApi());


}
