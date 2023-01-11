import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:scotch/common/api/api_baseurl.dart';
import 'package:scotch/common/api/api_endpoints.dart';
import 'package:scotch/util/dio_exception.dart';
import 'package:scotch/util/dio_interceptor.dart';
import 'package:scotch/view/screens/home_screen/model/category_model.dart';

class CategoryServices {
  Future<List<CategoryModel>?> categoryUsers() async {
    Dio dios = await ApiInterceptor().getApiUser();
    try {
      final Response response =
          await dios.get(ApiBaseUrl().baseUrl + ApiEndPoints.category);
      if (response.statusCode == 200 || response.statusCode == 201) {
        
        log(response.data.toString());
        final List<CategoryModel> listCategory = (response.data as List)
            .map((e) => CategoryModel.fromJson(e))
            .toList();
        return listCategory;
      } else {
        return null;
      }
    } on DioError catch (e) {
      log(e.message);
      DioException().dioError(e, );
    }
    return null;
  }
}
