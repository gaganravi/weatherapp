import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weatherapp/current_weather.dart';
import 'package:weatherapp/model/weather_model.dart';

class WeatherApiClient{
  Future<Weather>? getCurrentWeather (String? location) async{
    var endPoint = Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=Bangalore,IN&appid=0737c4fdaa11f09ad732a32769e0d3a6");
        var response = await http.get(endPoint);
        var body=jsonDecode(response.body);
        print(Weather.fromJson(body).cityName);
        return Weather.fromJson(body);
  }
}
