// coverage:ignore-file
import 'package:http/http.dart' as http;

class InternetChecker {
  Future<bool> hasInternet() async {
    try {
      // Se usa un endpoint conocido que retorna 204 para detectar conectividad.
      final response =
          await http.get(Uri.parse('https://www.gstatic.com/generate_204'));
      return response.statusCode == 204;
    } catch (e) {
      return false;
    }
  }
}
