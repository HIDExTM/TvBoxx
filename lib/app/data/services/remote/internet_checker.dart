import 'dart:io' show InternetAddress; // Solo se usa en móviles

import 'package:http/http.dart' as http;
import 'package:universal_platform/universal_platform.dart'; // ✅ Agregar esta librería

class InternetChecked {
  Future<bool> hasInternet() async {
    try {
      if (UniversalPlatform.isWeb) {
        // ✅ Verificación para Web (incluido Vercel)
        final response = await http
            .get(Uri.parse('https://clients3.google.com/generate_204'));
        return response.statusCode == 204;
      } else {
        // ✅ Verificación para móviles (Android/iOS)
        final list = await InternetAddress.lookup('google.com');
        return list.isNotEmpty && list.first.rawAddress.isNotEmpty;
      }
    } catch (e) {
      return false;
    }
  }
}
