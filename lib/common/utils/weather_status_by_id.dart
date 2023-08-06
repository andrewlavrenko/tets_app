import 'package:test_app/common/enums/weather_unit.dart';

WeatherStatus weatherStatusById(int id) {
  switch (id) {
    case 200 || 201 || 202 || 210 || 211 || 212 || 221 || 230 || 231 || 232:
      return WeatherStatus.thunderstorm;
    case 300 || 301 || 302 || 310 || 311 || 312 || 313 || 314 || 321 || 801 || 802 || 803 || 804:
      return WeatherStatus.drizzle;
    case 500 || 501 || 502 || 503 || 504 || 511 || 521 || 522 || 531:
      return WeatherStatus.rain;
    case 520:
      return WeatherStatus.rainWithSun;
    case 600 || 601 || 602 || 611 || 612 || 613 || 615 || 616 || 620 || 621 || 622:
      return WeatherStatus.snow;
    case 800:
      return WeatherStatus.sun;
    default:
      return WeatherStatus.cloud;
  }
}
