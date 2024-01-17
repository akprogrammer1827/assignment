import 'package:assignment/app/data/model/response_weather_model.dart';
import 'package:assignment/app/data/providers/api_get_weather_forecast.dart';
import 'package:assignment/app/data/repository/api_get_weather_forecast.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  List<String> favorites = [];

  bool markedFavorite = false;

  onTapFavoriteButton(String location) {
    favorites.add(location);
    markedFavorite = true;
    update();
  }

  ResponseWeatherModel? responseWeatherModel;
  late WeatherForecastRepository weatherForecastRepository;

  TextEditingController searchController = TextEditingController();

  bool onTapDegree = false;

  onTapDegreeTrue() {
    onTapDegree = true;
    update();
  }

  onTapDegreeFalse() {
    onTapDegree = false;
    update();
  }

  getWeatherForecastApi(String query) async {
    markedFavorite = false;
    update();
    responseWeatherModel =
        await weatherForecastRepository.getWeatherForecastApi(query);
    if (responseWeatherModel != null &&
        responseWeatherModel!.statusCode == 200) {}
    update();
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    weatherForecastRepository =
        WeatherForecastRepository(apiClient: WeatherForecastApiClient());
    getCurrentPosition();
  }

  void handleClick(String value) {
    switch (value) {
      case 'Logout':
        navigateToLogin();
        break;
      case 'Settings':
        break;
    }
    update();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  String? currentAddress;
  Position? currentPosition;

  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> getCurrentPosition() async {
    final hasPermission = await handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      currentPosition = position;
      update();
      getAddressFromLatLng(currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            currentPosition!.latitude, currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      currentAddress =
          '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}, ${place.country}';

      getWeatherForecastApi(currentAddress!);
      update();
    }).catchError((e) {
      debugPrint(e);
    });
  }

  navigateToLogin() {
    Get.offAllNamed(Routes.LOGIN);
  }
}
