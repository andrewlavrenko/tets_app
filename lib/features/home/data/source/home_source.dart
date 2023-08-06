import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:test_app/common/constants/config.dart';
import 'package:test_app/features/home/domain/models/weather.dart';

@Injectable()
class HomeSource {
  Future<Weather> getWeather({required double lat, required double lon}) async {
    try {
      var response = await http.get(
        Uri.parse(
          '${Config.api}weather?lat=$lat&lon=$lon&appid=${Config.key}&units=${Config.units}&lang=${Config.lang}',
        ),
      );

      Map<String, dynamic> data = jsonDecode(response.body);
      print(data);
      return Weather.fromJson(data);
    } catch (_) {
      rethrow;
    }
  }
}
