// To parse this JSON data, do
//
//     final responseWeatherModel = responseWeatherModelFromJson(jsonString);

import 'dart:convert';

ResponseWeatherModel responseWeatherModelFromJson(String str) =>
    ResponseWeatherModel.fromJson(json.decode(str));

String responseWeatherModelToJson(ResponseWeatherModel data) =>
    json.encode(data.toJson());

class ResponseWeatherModel {
  Location? location;
  Current? current;
  Forecast? forecast;
  int statusCode = -1;

  ResponseWeatherModel({
    this.location,
    this.current,
    this.forecast,
  });

  factory ResponseWeatherModel.fromJson(Map<String, dynamic> json) =>
      ResponseWeatherModel(
        location: Location.fromJson(json["location"]),
        current: Current.fromJson(json["current"]),
        forecast: Forecast.fromJson(json["forecast"]),
      );

  Map<String, dynamic> toJson() => {
        "location": location!.toJson(),
        "current": current!.toJson(),
        "forecast": forecast!.toJson(),
      };
}

class Current {
  dynamic lastUpdatedEpoch;
  dynamic lastUpdated;
  dynamic tempC;
  dynamic tempF;
  dynamic isDay;
  Condition? condition;
  dynamic windMph;
  dynamic windKph;
  dynamic windDegree;
  dynamic windDir;
  dynamic pressureMb;
  dynamic pressureIn;
  dynamic precipMm;
  dynamic precipIn;
  dynamic humidity;
  dynamic cloud;
  dynamic feelslikeC;
  dynamic feelslikeF;
  dynamic visKm;
  dynamic visMiles;
  dynamic uv;
  dynamic gustMph;
  dynamic gustKph;

  Current({
    this.lastUpdatedEpoch,
    this.lastUpdated,
    this.tempC,
    this.tempF,
    this.isDay,
    this.condition,
    this.windMph,
    this.windKph,
    this.windDegree,
    this.windDir,
    this.pressureMb,
    this.pressureIn,
    this.precipMm,
    this.precipIn,
    this.humidity,
    this.cloud,
    this.feelslikeC,
    this.feelslikeF,
    this.visKm,
    this.visMiles,
    this.uv,
    this.gustMph,
    this.gustKph,
  });

  factory Current.fromJson(Map<String, dynamic> json) => Current(
        lastUpdatedEpoch: json["last_updated_epoch"],
        lastUpdated: json["last_updated"],
        tempC: json["temp_c"],
        tempF: json["temp_f"],
        isDay: json["is_day"],
        condition: Condition.fromJson(json["condition"]),
        windMph: json["wind_mph"],
        windKph: json["wind_kph"],
        windDegree: json["wind_degree"],
        windDir: json["wind_dir"],
        pressureMb: json["pressure_mb"],
        pressureIn: json["pressure_in"],
        precipMm: json["precip_mm"],
        precipIn: json["precip_in"],
        humidity: json["humidity"],
        cloud: json["cloud"],
        feelslikeC: json["feelslike_c"],
        feelslikeF: json["feelslike_f"],
        visKm: json["vis_km"],
        visMiles: json["vis_miles"],
        uv: json["uv"],
        gustMph: json["gust_mph"],
        gustKph: json["gust_kph"],
      );

  Map<String, dynamic> toJson() => {
        "last_updated_epoch": lastUpdatedEpoch,
        "last_updated": lastUpdated,
        "temp_c": tempC,
        "temp_f": tempF,
        "is_day": isDay,
        "condition": condition!.toJson(),
        "wind_mph": windMph,
        "wind_kph": windKph,
        "wind_degree": windDegree,
        "wind_dir": windDir,
        "pressure_mb": pressureMb,
        "pressure_in": pressureIn,
        "precip_mm": precipMm,
        "precip_in": precipIn,
        "humidity": humidity,
        "cloud": cloud,
        "feelslike_c": feelslikeC,
        "feelslike_f": feelslikeF,
        "vis_km": visKm,
        "vis_miles": visMiles,
        "uv": uv,
        "gust_mph": gustMph,
        "gust_kph": gustKph,
      };
}

class Condition {
  dynamic text;
  dynamic icon;
  dynamic code;

  Condition({
    this.text,
    this.icon,
    this.code,
  });

  factory Condition.fromJson(Map<String, dynamic> json) => Condition(
        text: json["text"],
        icon: json["icon"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "icon": icon,
        "code": code,
      };
}

class Forecast {
  List<Forecastday>? forecastday;

  Forecast({
    this.forecastday,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) => Forecast(
        forecastday: List<Forecastday>.from(
            json["forecastday"].map((x) => Forecastday.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "forecastday": List<dynamic>.from(forecastday!.map((x) => x.toJson())),
      };
}

class Forecastday {
  DateTime? date;
  dynamic dateEpoch;
  Day? day;
  Astro? astro;
  List<Hour>? hour;

  Forecastday({
    this.date,
    this.dateEpoch,
    this.day,
    this.astro,
    this.hour,
  });

  factory Forecastday.fromJson(Map<String, dynamic> json) => Forecastday(
        date: DateTime.parse(json["date"]),
        dateEpoch: json["date_epoch"],
        day: Day.fromJson(json["day"]),
        astro: Astro.fromJson(json["astro"]),
        hour: List<Hour>.from(json["hour"].map((x) => Hour.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "date_epoch": dateEpoch,
        "day": day!.toJson(),
        "astro": astro!.toJson(),
        "hour": List<dynamic>.from(hour!.map((x) => x.toJson())),
      };
}

class Astro {
  dynamic sunrise;
  dynamic sunset;
  dynamic moonrise;
  dynamic moonset;
  dynamic moonPhase;
  dynamic moonIllumination;
  dynamic isMoonUp;
  dynamic isSunUp;

  Astro({
    this.sunrise,
    this.sunset,
    this.moonrise,
    this.moonset,
    this.moonPhase,
    this.moonIllumination,
    this.isMoonUp,
    this.isSunUp,
  });

  factory Astro.fromJson(Map<String, dynamic> json) => Astro(
        sunrise: json["sunrise"],
        sunset: json["sunset"],
        moonrise: json["moonrise"],
        moonset: json["moonset"],
        moonPhase: json["moon_phase"],
        moonIllumination: json["moon_illumination"],
        isMoonUp: json["is_moon_up"],
        isSunUp: json["is_sun_up"],
      );

  Map<String, dynamic> toJson() => {
        "sunrise": sunrise,
        "sunset": sunset,
        "moonrise": moonrise,
        "moonset": moonset,
        "moon_phase": moonPhase,
        "moon_illumination": moonIllumination,
        "is_moon_up": isMoonUp,
        "is_sun_up": isSunUp,
      };
}

class Day {
  dynamic maxtempC;
  dynamic maxtempF;
  dynamic mintempC;
  dynamic mintempF;
  dynamic avgtempC;
  dynamic avgtempF;
  dynamic maxwindMph;
  dynamic maxwindKph;
  dynamic totalprecipMm;
  dynamic totalprecipIn;
  dynamic totalsnowCm;
  dynamic avgvisKm;
  dynamic avgvisMiles;
  dynamic avghumidity;
  dynamic dailyWillItRain;
  dynamic dailyChanceOfRain;
  dynamic dailyWillItSnow;
  dynamic dailyChanceOfSnow;
  Condition? condition;
  dynamic uv;

  Day({
    this.maxtempC,
    this.maxtempF,
    this.mintempC,
    this.mintempF,
    this.avgtempC,
    this.avgtempF,
    this.maxwindMph,
    this.maxwindKph,
    this.totalprecipMm,
    this.totalprecipIn,
    this.totalsnowCm,
    this.avgvisKm,
    this.avgvisMiles,
    this.avghumidity,
    this.dailyWillItRain,
    this.dailyChanceOfRain,
    this.dailyWillItSnow,
    this.dailyChanceOfSnow,
    this.condition,
    this.uv,
  });

  factory Day.fromJson(Map<String, dynamic> json) => Day(
        maxtempC: json["maxtemp_c"],
        maxtempF: json["maxtemp_f"],
        mintempC: json["mintemp_c"],
        mintempF: json["mintemp_f"],
        avgtempC: json["avgtemp_c"],
        avgtempF: json["avgtemp_f"],
        maxwindMph: json["maxwind_mph"],
        maxwindKph: json["maxwind_kph"],
        totalprecipMm: json["totalprecip_mm"],
        totalprecipIn: json["totalprecip_in"],
        totalsnowCm: json["totalsnow_cm"],
        avgvisKm: json["avgvis_km"],
        avgvisMiles: json["avgvis_miles"],
        avghumidity: json["avghumidity"],
        dailyWillItRain: json["daily_will_it_rain"],
        dailyChanceOfRain: json["daily_chance_of_rain"],
        dailyWillItSnow: json["daily_will_it_snow"],
        dailyChanceOfSnow: json["daily_chance_of_snow"],
        condition: Condition.fromJson(json["condition"]),
        uv: json["uv"],
      );

  Map<String, dynamic> toJson() => {
        "maxtemp_c": maxtempC,
        "maxtemp_f": maxtempF,
        "mintemp_c": mintempC,
        "mintemp_f": mintempF,
        "avgtemp_c": avgtempC,
        "avgtemp_f": avgtempF,
        "maxwind_mph": maxwindMph,
        "maxwind_kph": maxwindKph,
        "totalprecip_mm": totalprecipMm,
        "totalprecip_in": totalprecipIn,
        "totalsnow_cm": totalsnowCm,
        "avgvis_km": avgvisKm,
        "avgvis_miles": avgvisMiles,
        "avghumidity": avghumidity,
        "daily_will_it_rain": dailyWillItRain,
        "daily_chance_of_rain": dailyChanceOfRain,
        "daily_will_it_snow": dailyWillItSnow,
        "daily_chance_of_snow": dailyChanceOfSnow,
        "condition": condition!.toJson(),
        "uv": uv,
      };
}

class Hour {
  dynamic timeEpoch;
  dynamic time;
  dynamic tempC;
  dynamic tempF;
  dynamic isDay;
  Condition? condition;
  dynamic windMph;
  dynamic windKph;
  dynamic windDegree;
  dynamic windDir;
  dynamic pressureMb;
  dynamic pressureIn;
  dynamic precipMm;
  dynamic precipIn;
  dynamic snowCm;
  dynamic humidity;
  dynamic cloud;
  dynamic feelslikeC;
  dynamic feelslikeF;
  dynamic windchillC;
  dynamic windchillF;
  dynamic heatindexC;
  dynamic heatindexF;
  dynamic dewpointC;
  dynamic dewpointF;
  dynamic willItRain;
  dynamic chanceOfRain;
  dynamic willItSnow;
  dynamic chanceOfSnow;
  dynamic visKm;
  dynamic visMiles;
  dynamic gustMph;
  dynamic gustKph;
  dynamic uv;
  dynamic shortRad;
  dynamic diffRad;

  Hour({
    this.timeEpoch,
    this.time,
    this.tempC,
    this.tempF,
    this.isDay,
    this.condition,
    this.windMph,
    this.windKph,
    this.windDegree,
    this.windDir,
    this.pressureMb,
    this.pressureIn,
    this.precipMm,
    this.precipIn,
    this.snowCm,
    this.humidity,
    this.cloud,
    this.feelslikeC,
    this.feelslikeF,
    this.windchillC,
    this.windchillF,
    this.heatindexC,
    this.heatindexF,
    this.dewpointC,
    this.dewpointF,
    this.willItRain,
    this.chanceOfRain,
    this.willItSnow,
    this.chanceOfSnow,
    this.visKm,
    this.visMiles,
    this.gustMph,
    this.gustKph,
    this.uv,
    this.shortRad,
    this.diffRad,
  });

  factory Hour.fromJson(Map<String, dynamic> json) => Hour(
        timeEpoch: json["time_epoch"],
        time: json["time"],
        tempC: json["temp_c"],
        tempF: json["temp_f"],
        isDay: json["is_day"],
        condition: Condition.fromJson(json["condition"]),
        windMph: json["wind_mph"],
        windKph: json["wind_kph"],
        windDegree: json["wind_degree"],
        windDir: json["wind_dir"],
        pressureMb: json["pressure_mb"],
        pressureIn: json["pressure_in"],
        precipMm: json["precip_mm"],
        precipIn: json["precip_in"],
        snowCm: json["snow_cm"],
        humidity: json["humidity"],
        cloud: json["cloud"],
        feelslikeC: json["feelslike_c"],
        feelslikeF: json["feelslike_f"],
        windchillC: json["windchill_c"],
        windchillF: json["windchill_f"],
        heatindexC: json["heatindex_c"],
        heatindexF: json["heatindex_f"],
        dewpointC: json["dewpoint_c"],
        dewpointF: json["dewpoint_f"],
        willItRain: json["will_it_rain"],
        chanceOfRain: json["chance_of_rain"],
        willItSnow: json["will_it_snow"],
        chanceOfSnow: json["chance_of_snow"],
        visKm: json["vis_km"],
        visMiles: json["vis_miles"],
        gustMph: json["gust_mph"],
        gustKph: json["gust_kph"],
        uv: json["uv"],
        shortRad: json["short_rad"],
        diffRad: json["diff_rad"],
      );

  Map<String, dynamic> toJson() => {
        "time_epoch": timeEpoch,
        "time": time,
        "temp_c": tempC,
        "temp_f": tempF,
        "is_day": isDay,
        "condition": condition!.toJson(),
        "wind_mph": windMph,
        "wind_kph": windKph,
        "wind_degree": windDegree,
        "wind_dir": windDir,
        "pressure_mb": pressureMb,
        "pressure_in": pressureIn,
        "precip_mm": precipMm,
        "precip_in": precipIn,
        "snow_cm": snowCm,
        "humidity": humidity,
        "cloud": cloud,
        "feelslike_c": feelslikeC,
        "feelslike_f": feelslikeF,
        "windchill_c": windchillC,
        "windchill_f": windchillF,
        "heatindex_c": heatindexC,
        "heatindex_f": heatindexF,
        "dewpoint_c": dewpointC,
        "dewpoint_f": dewpointF,
        "will_it_rain": willItRain,
        "chance_of_rain": chanceOfRain,
        "will_it_snow": willItSnow,
        "chance_of_snow": chanceOfSnow,
        "vis_km": visKm,
        "vis_miles": visMiles,
        "gust_mph": gustMph,
        "gust_kph": gustKph,
        "uv": uv,
        "short_rad": shortRad,
        "diff_rad": diffRad,
      };
}

class Location {
  dynamic name;
  dynamic region;
  dynamic country;
  dynamic lat;
  dynamic lon;
  dynamic tzId;
  dynamic localtimeEpoch;
  dynamic localtime;

  Location({
    this.name,
    this.region,
    this.country,
    this.lat,
    this.lon,
    this.tzId,
    this.localtimeEpoch,
    this.localtime,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json["name"],
        region: json["region"],
        country: json["country"],
        lat: json["lat"],
        lon: json["lon"],
        tzId: json["tz_id"],
        localtimeEpoch: json["localtime_epoch"],
        localtime: json["localtime"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "region": region,
        "country": country,
        "lat": lat,
        "lon": lon,
        "tz_id": tzId,
        "localtime_epoch": localtimeEpoch,
        "localtime": localtime,
      };
}
