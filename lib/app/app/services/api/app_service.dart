import 'package:get/get.dart';
import 'base_api_service.dart';

class AppService extends BaseApiService {

  Future getProducts() async {
    try {
      final response = await baseGetAPICall(
          path: "products?limit=100");
    //  print("categoryResponse---- : : $response");
      if (response.success && response.data != null) {
        return response.data;
      }
      return null;
    } catch (exception) {
      exception.printError();
      return {};
    }
  }
}
