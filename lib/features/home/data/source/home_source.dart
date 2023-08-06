import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/common/constants/config.dart';
import 'package:test_app/features/home/domain/models/weather.dart';

@Injectable()
class HomeSource {
  static const weatherKey = 'weather_key';
  static const hourlyWeathersKey = 'hourly_weathers_key';

  Future<Weather> getWeather({required double lat, required double lon}) async {
    try {
      var response = await http.get(
        Uri.parse(
          '${Config.api}weather?lat=$lat&lon=$lon&appid=${Config.key}&units=${Config.units}&lang=${Config.lang}',
        ),
      );
      await _saveLocalWeather(response.body);
      Map<String, dynamic> data = jsonDecode(response.body);
      return Weather.fromJson(data);
    } catch (_) {
      rethrow;
    }
  }

  Future<void> _saveLocalWeather(String weather) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(weatherKey, weather);
    } catch (_) {
      rethrow;
    }
  }

  Future<Weather?> getLocalWeather() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final weather = prefs.getString(weatherKey);
      if (weather != null) {
        return Weather.fromJson(jsonDecode(weather));
      } else {
        return null;
      }
    } catch (_) {
      rethrow;
    }
  }

  Future<List<HourlyWeather>> getHourlyWeathers({required double lat, required double lon}) async {
    try {
      var response = await http.get(
        Uri.parse(
          '${Config.api}forecast?lat=$lat&lon=$lon&appid=${Config.key}&units=${Config.units}&lang=${Config.lang}',
        ),
      );
      await _saveLocalHourlyWeathers(response.body);
      Map<String, dynamic> data = jsonDecode(response.body);
      return List.from(data['list']).map((el) => HourlyWeather.fromJson(el)).toList();
    } catch (_) {
      rethrow;
    }
  }

  Future<void> _saveLocalHourlyWeathers(String weather) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(hourlyWeathersKey, weather);
    } catch (_) {
      rethrow;
    }
  }

  Future<List<HourlyWeather>?> getLocalHourlyWeathers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final hourlyWeathers = prefs.getString(hourlyWeathersKey);
      if (hourlyWeathers != null) {
        return List.from(jsonDecode(hourlyWeathers)['list']).map((el) => HourlyWeather.fromJson(el)).toList();
      } else {
        return null;
      }
    } catch (_) {
      rethrow;
    }
  }
}
