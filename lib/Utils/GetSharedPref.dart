import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences sharedpref;
String soccodesp, phonesp;

initial() async {
  sharedpref = await SharedPreferences.getInstance();
  soccodesp = sharedpref.getString('soccode');
  phonesp = sharedpref.getString('phone');
}