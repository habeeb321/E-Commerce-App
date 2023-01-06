import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:scotch/common/api/api_baseurl.dart';
import 'package:scotch/common/api/api_endpoints.dart';
import 'package:scotch/util/dio_exception.dart';
import 'package:scotch/util/dio_interceptor.dart';
import 'package:scotch/view/screens/home_screen/model/carosel_model.dart';

class CarousalService {
  Future<List<CarousalModel>?> homeCarousel(context) async {
    Dio dios = await ApiInterceptor().getApiUser(context);
    log(' entered');
    try {
      log(' try');
      final Response response = await dios.get(
        ApiBaseUrl().baseUrl + ApiEndPoints.carousal,
      );
      log('status code in carousal service function');
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        log(response.data.toString());
        final List<CarousalModel> carousel = (response.data as List)
            .map((e) => CarousalModel.fromJson(e))
            .toList();
        log('carousal in decoded format');
        log(carousel[0].id.toString());
        return carousel;
      } else {
        return null;
      }
    } on DioError catch (e) {
      log(e.message);
      DioException().dioError(e, context);
    }
    return null;
  }
}
