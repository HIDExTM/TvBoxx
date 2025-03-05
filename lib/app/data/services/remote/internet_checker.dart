import 'dart:io' show InternetAddress;

import 'package:http/http.dart' as http;
import 'package:universal_platform/universal_platform.dart';

class InternetChecked {
  Future<bool> hasInternet() async {
    try {
      if (UniversalPlatform.isWeb) {
        // ✅ Nueva URL sin restricciones CORS
        final response =
            await http.get(Uri.parse('https://www.gstatic.com/generate_204'));
        return response.statusCode == 204;
      } else {
        // ✅ Verificación para móviles
        final list = await InternetAddress.lookup('google.com');
        return list.isNotEmpty && list.first.rawAddress.isNotEmpty;
      }
    } catch (e) {
      return false;
    }
  }
}
