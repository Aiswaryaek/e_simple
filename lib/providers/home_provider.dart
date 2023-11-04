import 'package:flutter/cupertino.dart';
import '../core/live_data.dart';
import '../core/ui_state.dart';
import '../models/all_categories_model.dart';
import '../models/trending_product_list_model.dart';
import '../repositories/auth_repository.dart';
import '../repositories/catalog_repository.dart';

class HomeProvider extends ChangeNotifier{
  CatalogRepository catalogRepository;

  HomeProvider({required this.catalogRepository});

  List<AllCategoriesModel>list = [];
  LiveData<UIState<AllCategoriesModel>> categoryListLiveData =
  LiveData<UIState<AllCategoriesModel>>();

  LiveData<UIState<AllCategoriesModel>> getCategoryListLiveData() {
    return this.categoryListLiveData;
  }

  List<TrendingItems>trendingList = [];
  LiveData<UIState<TrendingItems>> trendingProductListLiveData =
  LiveData<UIState<TrendingItems>>();

  LiveData<UIState<TrendingItems>> getTrendingProductListLiveData() {
    return this.trendingProductListLiveData;
  }


  void initialState()
  {
    getCategoryList();

    notifyListeners();
  }

  getCategoryList() async {
    try {
      categoryListLiveData.setValue(IsLoading());
      list = await catalogRepository.getCategoryListData();
      if (list.isNotEmpty) {
        categoryListLiveData.setValue(Success(AllCategoriesModel()));
      } else {
        categoryListLiveData.setValue(IsEmpty());
      }
    } catch (ex) {
      categoryListLiveData.setValue(Failure(ex.toString()));
    } finally {
      notifyListeners();
    }
  }
  getTrendingList() async {
    try {
      trendingProductListLiveData.setValue(IsLoading());
      trendingList = await catalogRepository.getTrendingProductListData();
      if (trendingList.isNotEmpty) {
        trendingProductListLiveData.setValue(Success(TrendingItems()));
      } else {
        trendingProductListLiveData.setValue(Failure(trendingList.toString()));
      }
    } catch (ex) {
      trendingProductListLiveData.setValue(Failure(ex.toString()));
    } finally {
      notifyListeners();
    }
    // return true;
  }
}