import 'dart:developer';

import 'package:assignment/app/data/model/response_weather_model.dart';
import 'package:assignment/app/data/providers/api_parent.dart';
import 'package:http/http.dart' as http;

import '../../utils/connection.dart';
import '../../utils/ui.dart';

class WeatherForecastApiClient extends ApiParent {
  WeatherForecastApiClient();
  Future<ResponseWeatherModel?> getWeatherForecast(String query) async {
    if (!hasInternetConnection()) {
      return null;
    }
    UI.showLoading();
    try {
      var url = Connection.weatherForecastUrl + query;
      log("weatherForecastUrl $url");
      var response = await http.get(Uri.parse(url));
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      UI.hideLoading();
      if (response.statusCode == 200) {
        ResponseWeatherModel responseObj =
            ResponseWeatherModel.fromJson(jsonResponse);
        log("ResponseNewToken ${responseObj.toJson()}");
        responseObj.statusCode = 200;
        return responseObj;
      } else {
        log("ResponseNewToken $jsonResponse");
      }
    } catch (error) {
      UI.hideLoading();
      log(error.toString());
    }
    return null;
  }
}
