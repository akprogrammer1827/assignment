class Connection {
  //Api Key
  static String apiKey = "898ea973160847a78e080924241701";

  //Main Url
  static String mainUrl = "http://api.weatherapi.com/v1/";

  //Api Url
  static String weatherForecastUrl =
      "${mainUrl}forecast.json?key=$apiKey&days=7&q=";
}
