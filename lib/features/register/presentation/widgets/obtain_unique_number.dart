import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/cache_constants.dart';
import '../../../../core/api_services/api.dart';
import '../../../../injection_container.dart';

class UniqueNumber {

  Future<String> getUnique() async {
    final uniqueNumber = sl<GetUnique>;
    final result = await uniqueNumber().obtaunUniqueNumber();
    
    // Guardar el valor único en cache
    await setValue(result);

    return result;
  }

  Future<void> setValue(String number) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(codeCache, number);
  }

  // obtener el valor único del dispositivo de cache
  Future<String> getValue() async {
    final prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString(codeCache);
    if (value != null) {
      return value;
    } else {
      return "";
    }
  }
}
