import 'package:test_app/features/home/domain/models/weather.dart';

abstract class HomeRepository {
  Future<Weather> getWeather({required double lat, required double lon});
}
