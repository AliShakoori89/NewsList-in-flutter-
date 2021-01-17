import 'dart:async';
import 'package:news_with_bloc/networking/api_response.dart';
import 'package:news_with_bloc/models/news_response.dart';
import 'package:news_with_bloc/repository/news_repository.dart';

class CategoryBloc{
  CategoryRepository _categoriesRepository;

  StreamController _categoriesListController;

  StreamSink<ApiResponse<List<CategoryModel>>> get categoriesListSink =>
      _categoriesListController.sink;

  Stream<ApiResponse<List<CategoryModel>>> get categoriesListStream =>
      _categoriesListController.stream;

  CategoryBloc(){
    _categoriesListController = StreamController<ApiResponse<List<CategoryModel>>>();
    _categoriesRepository = CategoryRepository();
    fetchCategory();
  }

  fetchCategory() async {
    categoriesListSink.add(ApiResponse.loading('Fetching News'));
    try{
      List<CategoryModel> categorymodel = await _categoriesRepository.fetchNewsList();
      categoriesListSink.add(ApiResponse.completed(categorymodel));
    } catch(e) {
      categoriesListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose(){
    _categoriesListController?.close();
  }
}