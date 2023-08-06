import 'package:equatable/equatable.dart';
import 'package:test_app/common/enums/weather_unit.dart';
import 'package:test_app/common/utils/weather_status_by_id.dart';

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
  final double? temp;
  final double? minTemp;
  final double? maxTemp;

  const Temperature({
    required this.temp,
    required this.minTemp,
    required this.maxTemp,
  });

  factory Temperature.fromJson(Map<String, dynamic> json) => Temperature(
        temp: json['temp'],
        minTemp: json['temp_min'],
        maxTemp: json['temp_max'],
      );

  @override
  List<Object?> get props => [
        temp,
        minTemp,
        maxTemp,
      ];
}

class Wind extends Equatable {
  final double? speed;
  final int? deg;

  const Wind({
    required this.speed,
    required this.deg,
  });

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: json['speed'],
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
