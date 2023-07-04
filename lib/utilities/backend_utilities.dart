import 'package:http/http.dart' as http;

class BackendUtilities {

  static Future<bool> getBackendStatus() async {
    const url = "http://192.168.0.104:8090/api/health";
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 5));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
