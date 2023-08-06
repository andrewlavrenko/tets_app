import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
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
    final isGranted = await _checkLocationPermission();
    if (isGranted) {
      final position = await Geolocator.getCurrentPosition();
      final address = await placemarkFromCoordinates(position.latitude, position.longitude, localeIdentifier: 'ru_RU');
      await repository.getHourlyWeathers(lat: position.latitude, lon: position.longitude).then(
        (list) async {
          await repository.getWeather(lat: position.latitude, lon: position.longitude).then(
                (weather) => emit(
                  HomeLoaded(
                    weather: weather.copyWith(address: '${weather.address ?? ''}, ${address.first.country ?? ''}'),
                    hourlyWeathers: list,
                  ),
                ),
                onError: (error) => emit(HomeError()),
              );
        },
        onError: (error) => emit(HomeError()),
      );
    } else {
      emit(HomeError());
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
