import 'package:equatable/equatable.dart';
import 'package:test_app/common/enums/weather_unit.dart';
import 'package:test_app/common/utils/weather_status_by_id.dart';

class HourlyWeather extends Equatable {
  final Temperature? temperature;
  final List<Condition> conditions;
  final DateTime? date;
  const HourlyWeather({
    required this.temperature,
    required this.conditions,
    required this.date,
  });
  HourlyWeather copyWith({
    Temperature? temperature,
    List<Condition>? conditions,
    DateTime? date,
  }) =>
      HourlyWeather(
        temperature: temperature ?? this.temperature,
        conditions: conditions ?? this.conditions,
        date: date ?? this.date,
      );

  factory HourlyWeather.fromJson(Map<String, dynamic> json) => HourlyWeather(
        temperature: Temperature.fromJson(json['main']),
        conditions: List.from(json['weather']).map((el) => Condition.fromJson(el)).toList(),
        date: json['dt'] != null ? DateTime.fromMillisecondsSinceEpoch((json['dt'] as int) * 1000) : null,
      );

  @override
  List<Object?> get props => [
        temperature,
        conditions,
        date,
      ];
}

class Weather extends Equatable {
  final Temperature? temperature;
  final Wind? wind;
  final List<Condition> conditions;
  final int? humidity;
  final String? address;

  const Weather({
    required this.temperature,
    required this.wind,
    required this.conditions,
    required this.humidity,
    required this.address,
  });

  Weather copyWith({
    Temperature? temperature,
    Wind? wind,
    List<Condition>? conditions,
    int? humidity,
    String? address,
  }) =>
      Weather(
        temperature: temperature ?? this.temperature,
        wind: wind ?? this.wind,
        conditions: conditions ?? this.conditions,
        humidity: humidity ?? this.humidity,
        address: address ?? this.address,
      );

  Map<String, dynamic> toJson() => {
        'temperature': temperature,
        'wind': wind,
        'conditions': conditions,
        'humidity': humidity,
        'address': address,
      };

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        temperature: Temperature.fromJson(json['main']),
        wind: Wind.fromJson(json['wind']),
        conditions: List.from(json['weather']).map((el) => Condition.fromJson(el)).toList(),
        humidity: json['main']['humidity'],
        address: json['name'],
      );

  @override
  List<Object?> get props => [
        temperature,
        wind,
        conditions,
        humidity,
        address,
      ];
}

class Temperature extends Equatable {
  final int? temp;
  final int? minTemp;
  final int? maxTemp;

  const Temperature({
    required this.temp,
    required this.minTemp,
    required this.maxTemp,
  });

  factory Temperature.fromJson(Map<String, dynamic> json) => Temperature(
        temp: double.tryParse(json['temp'].toString())?.round(),
        minTemp: double.tryParse(json['temp_min'].toString())?.round(),
        maxTemp: double.tryParse(json['temp_max'].toString())?.round(),
      );

  @override
  List<Object?> get props => [
        temp,
        minTemp,
        maxTemp,
      ];
}

class Wind extends Equatable {
  final int? speed;
  final int? deg;

  const Wind({
    required this.speed,
    required this.deg,
  });

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: double.tryParse(json['speed'].toString())?.round(),
        deg: json['deg'],
      );

  @override
  List<Object?> get props => [
        speed,
        deg,
      ];
}

class Condition extends Equatable {
  final WeatherStatus? status;
  final String? description;

  const Condition({
    required this.status,
    required this.description,
  });

  factory Condition.fromJson(Map<String, dynamic> json) => Condition(
        status: json['id'] != null ? weatherStatusById(json['id']) : null,
        description: json['description'],
      );

  @override
  List<Object?> get props => [
        status,
        description,
      ];
}
