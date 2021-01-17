import 'dart:async';
import 'package:news_with_bloc/models/news_response.dart';
import 'package:news_with_bloc/networking/api_response.dart';
import 'package:news_with_bloc/repository/news_detail_repository.dart';
import 'package:news_with_bloc/view/categories_detail.dart';


class NewsDetailBloc {
  NewsDetailRepository _newsDetailRepository;

  StreamController _newsDetailController;

  StreamSink<ApiResponse<List<NewsDetailsModel>>> get newsDetailSink =>
      _newsDetailController.sink;

  Stream<ApiResponse<List<NewsDetailsModel>>> get newsDetailStream =>
      _newsDetailController.stream;

  NewsDetailBloc(selectedMovie) {
    _newsDetailController = StreamController<ApiResponse<List<NewsDetailsModel>>>();
    _newsDetailRepository = NewsDetailRepository();
    // fetchNewsDetail(selectedMovie);
  }

  fetchNewsDetail(String selectedNews) async {
    newsDetailSink.add(ApiResponse.loading('Fetching Details'));
    try {
      List<NewsDetailsModel> newsdetail = await _newsDetailRepository.fetchNewsDetail(selectedNews);
      newsDetailSink.add(ApiResponse.completed(newsdetail));
    } catch (e) {
      newsDetailSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _newsDetailController?.close();
  }
}