import 'package:test_app/common/theme/assets.dart';
import 'package:test_app/common/enums/weather_unit.dart';

String weatherImageByStatus(WeatherStatus? status) {
  switch (status) {
    case WeatherStatus.thunderstorm:
      return AssetIcons.imThunderstorm;
    case WeatherStatus.drizzle:
      return AssetIcons.imDrizzle;
    case WeatherStatus.rain:
      return AssetIcons.imRain;
    case WeatherStatus.rainWithSun:
      return AssetIcons.imRainWithSun;
    case WeatherStatus.snow:
      return AssetIcons.imSnow;
    case WeatherStatus.sun:
      return AssetIcons.imSun;
    default:
      return AssetIcons.imSun;
  }
}