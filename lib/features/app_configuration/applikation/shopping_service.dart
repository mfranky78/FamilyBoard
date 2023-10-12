



import 'package:famibo/features/app_configuration/applikation/domain/shopping_model.dart';
import 'package:famibo/features/app_configuration/data/shopping_repository.dart';

class ShoppingService {
  ShoppingRepository shoppingRepository = ShoppingRepository();

  Future<List<Shopping>> fetchCategories() async {
    var categories = await shoppingRepository.fetchShoppingsFromServer();
    return categories;
  }

  createNewCategory(Shopping shopping) async {
    return shoppingRepository.createShoppingOnServer(shopping);
  }
}