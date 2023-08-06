import 'package:injectable/injectable.dart';
import 'package:test_app/features/home/data/source/home_source.dart';
import 'package:test_app/features/home/domain/models/weather.dart';
import 'package:test_app/features/home/domain/repository/home_repository.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImpl extends HomeRepository {
  final HomeSource _source;
  HomeRepositoryImpl(this._source);

  @override
  Future<Weather> getWeather({required double lat, required double lon}) {
    return _source.getWeather(lat: lat, lon: lon);
  }

  @override
  Future<List<HourlyWeather>> getHourlyWeathers({required double lat, required double lon}) {
    return _source.getHourlyWeathers(lat: lat, lon: lon);
  }


  @override
  Future<Weather?> getLocalWeather() {
    return _source.getLocalWeather();
  }


  @override
  Future<List<HourlyWeather>?> getLocalHourlyWeathers() {
    return _source.getLocalHourlyWeathers();
  }
}
