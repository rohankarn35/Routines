import 'package:shared_preferences/shared_preferences.dart';

class CheckAllDetailsAvailable {
  Future<bool> checkAllDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final allDetails = prefs.getString("alldetails");
    return allDetails != null;
  }
}
