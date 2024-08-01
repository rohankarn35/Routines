import 'package:shared_preferences/shared_preferences.dart';

class GetAllDetails {
  Future<String> getAllDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final String? allDetails = prefs.getString("alldetails");
    return allDetails ?? "";
  }
}
