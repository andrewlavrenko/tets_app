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
}
