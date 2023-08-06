import 'package:test_app/common/theme/assets.dart';
import 'package:test_app/common/enums/weather_unit.dart';

String hourlyWeatherImageByStatus(WeatherStatus? status, bool isNight) {
  switch (status) {
    case WeatherStatus.thunderstorm:
      return AssetIcons.icCloudLightning;
    case WeatherStatus.drizzle:
      return AssetIcons.icCloudRain;
    case WeatherStatus.rain:
      return AssetIcons.icCloudRain;
    case WeatherStatus.rainWithSun:
      return AssetIcons.icCloudRain;
    case WeatherStatus.snow:
      return AssetIcons.icCloudSnow;
    case WeatherStatus.sun:
      return AssetIcons.icSun;
    case WeatherStatus.cloud:
      return isNight? AssetIcons.icCloudMoon : AssetIcons.icCloudSun;
    default:
      return AssetIcons.icSun;
  }
}