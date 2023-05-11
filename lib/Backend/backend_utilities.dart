import 'package:http/http.dart' as http;

//import '../debug/print.dart';

class BackendUtilities {
  static Future<bool> checkBackendHealth() async {
    const url = "http://192.168.0.104:8090/api/health";
    final response =
        await http.get(Uri.parse(url)).timeout(const Duration(seconds: 5));
    if (response.statusCode == 200) {
      return true;
    }
    return false;
    // try {
    //   final response = await http
    //       .get(Uri.parse(url)); //.timeout(const Duration(seconds: 10));
    //   if (response.statusCode == 200) {
    //     return true;
    //   }
    // } catch (e) {
    //   Debug.printLog(e.toString());
    //   return false;
    // }
    // return false;
  }
}
