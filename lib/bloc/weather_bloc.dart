import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

import '../data/my_data.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    emit(WeatherLoading());
    on<FetchWeather>((event, emit) async {
      try {
        WeatherFactory wf =
            WeatherFactory(apiKey, language: Language.UKRAINIAN);

        Weather weather = await wf.currentWeatherByLocation(
          event.position.latitude,
          event.position.longitude,
        );
        print(weather);
        emit(WeatherSuccess(weather));
      } catch (e) {
        emit(WeatherFailure());
      }
    });
  }
}
