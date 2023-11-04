

import 'dart:convert';

import '../models/all_categories_model.dart';
import '../models/trending_product_list_model.dart';
import '../utilities/api_helpers.dart';

Resource<List<AllCategoriesModel>> getCategoryListApi(){
  return Resource(
      url: 'https://www.zufi.ca/api/inventory/category',
      parse: (response){
        Iterable categoryList = json.decode(response.body);
        List<AllCategoriesModel> data = List<AllCategoriesModel>.from(
            categoryList.map((model) => AllCategoriesModel.fromJson(model)));
        return data;
      }
  );
}
Resource<List<TrendingItems>> getTrendingProductListApi(){
  return Resource(
      url: 'https://www.zufi.ca/api/inventory/product/featured/details?emirate_prefer=',
      parse: (response){
        Map listMap = json.decode(response.body);
        Iterable list = listMap["content"];
        List<TrendingItems> data = list.map((model) => TrendingItems.fromJson(model)).toList();
        return data;
      }
  );
}