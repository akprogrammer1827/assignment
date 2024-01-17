import 'package:assignment/app/data/model/response_weather_model.dart';
import 'package:assignment/app/data/providers/api_get_weather_forecast.dart';

class WeatherForecastRepository {
  final WeatherForecastApiClient apiClient;
  WeatherForecastRepository({required this.apiClient});

  getWeatherForecastApi(String query) async {
    ResponseWeatherModel? responseWeatherModel =
        await apiClient.getWeatherForecast(query);
    return responseWeatherModel;
  }
}
