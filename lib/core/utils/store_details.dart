import 'package:shared_preferences/shared_preferences.dart';

class StoreDetails {
  Future<void> storeDetails({required String data}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("alldetails", data);
  }
}
