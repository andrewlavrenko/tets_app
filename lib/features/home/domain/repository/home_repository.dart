import 'package:test_app/features/home/domain/models/weather.dart';

abstract class HomeRepository {
  Future<Weather> getWeather({required double lat, required double lon});
  Future<List<HourlyWeather>> getHourlyWeathers({required double lat, required double lon});
  Future<Weather?> getLocalWeather();
  Future<List<HourlyWeather>?> getLocalHourlyWeathers();
}
