import 'package:my_library_app/network/api.dart';
import 'package:my_library_app/schemas/schemas.dart';

class NetWorkImplementation {
  static Future<List<Book>> getBookListByCategory(String category) async {
    ApiResponse response = await ApiClient.getBookListByCategory(category);
    if (response.items!.isEmpty) {
      return [];
    } else {
      return response.items!;
    }
  }
}
