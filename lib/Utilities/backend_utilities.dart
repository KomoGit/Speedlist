import 'package:http/http.dart' as http;
import 'package:pocketbase/pocketbase.dart';

class BackendUtilities {
  static PocketBase getBackendAccess() {
    return PocketBase("http://192.168.0.104:8090");
  }

  static Future<bool> getBackendStatus() async {
    const url = "http://192.168.0.104:8090";
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
