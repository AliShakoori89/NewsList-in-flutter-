import 'package:news_with_bloc/models/news_response.dart';
import 'package:news_with_bloc/networking/api_base_helper.dart';

class CategoryRepository {

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<CategoryModel>> fetchNewsList() async {

    List<CategoryModel> categories = [];
    final response = await _helper.get('category.php');
    response.forEach((v){
      categories.add(CategoryModel.fromJson(v));
    });
    print("qqqqqqqqq$response");
    return categories;
  }
}