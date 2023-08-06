import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:test_app/features/home/domain/models/weather.dart';
import 'package:test_app/features/home/domain/repository/home_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

@Injectable()
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository repository;
  HomeBloc(this.repository) : super(HomeInitial()) {
    on<GetWeatherEvent>(_onGetWeatherEvent);
  }

  void _onGetWeatherEvent(GetWeatherEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    final isConnected = await InternetConnectionChecker().hasConnection;
    if (isConnected) {
      final isGranted = await _checkLocationPermission();
      if (isGranted) {
        final position = await Geolocator.getCurrentPosition();
        final address = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
          localeIdentifier: 'ru_RU',
        );
        await repository.getHourlyWeathers(lat: position.latitude, lon: position.longitude).then(
          (list) async {
            await repository.getWeather(lat: position.latitude, lon: position.longitude).then(
                  (weather) => emit(
                    HomeLoaded(
                      weather: weather.copyWith(address: '${weather.address ?? ''}, ${address.first.country ?? ''}'),
                      hourlyWeathers: list,
                    ),
                  ),
                  onError: (error) => emit(const HomeError(message: 'Ошибка приложения')),
                );
          },
          onError: (error) => emit(const HomeError(message: 'Ошибка приложения')),
        );
      } else {
        emit(const HomeError(message: 'Отсутсвует разрешение на определение геопозиции.'));
      }
    } else {
      await repository.getLocalHourlyWeathers().then(
        (list) async {
          await repository.getLocalWeather().then(
            (weather) {
              if (weather != null && list != null) {
                emit(
                  HomeLoaded(
                    weather: weather,
                    hourlyWeathers: list,
                  ),
                );
              } else {
                emit(const HomeError(message: 'Отсутствует соединение с интернетом. Локальные данные отсутсвуют'));
              }
            },
            onError: (error) => emit(const HomeError(message: 'Ошибка получения локальных данных')),
          );
        },
        onError: (error) => emit(const HomeError(message: 'Ошибка получения локальных данных')),
      );
    }
  }

  Future<bool> _checkLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }
}
