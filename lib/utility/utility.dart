import 'package:news_application_bloc/model/category_model.dart';
import 'package:news_application_bloc/model/news_model.dart';

class Utility {
  static const ApiKey = '020daa5a2d8b4747b7d9d66f76e78996';

  static List<CategoryModel> getCategories() {
    List<CategoryModel> resultList = [];
    resultList = [
      CategoryModel('business', 'images/business.png'),
      CategoryModel('entertainment', 'images/entertainment.png'),
      CategoryModel('general', 'images/general.png'),
      CategoryModel('health', 'images/health.png'),
      CategoryModel('science', 'images/science.png'),
      CategoryModel('sport', 'images/sport.png'),
      CategoryModel('technology', 'images/technology.png'),
    ];
    return resultList;
  }
}
