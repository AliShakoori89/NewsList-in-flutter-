import 'package:news_with_bloc/models/news_response.dart';
import 'package:news_with_bloc/networking/api_base_helper.dart';

class NewsDetailRepository{
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<NewsDetailsModel>> fetchNewsDetail(String selectednew) async{

    List<NewsDetailsModel> postList = [];
    print(selectednew);
    final response = await _helper.get('postlist.php?cat=$selectednew');
    print('response:::::: $response');
    response.forEach((v){
      postList.add(NewsDetailsModel.fromJson(v));
    });
    return postList;
  }
}
