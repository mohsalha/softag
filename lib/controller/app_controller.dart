import 'package:shared_preferences/shared_preferences.dart';
import 'package:softag/screens/login_screen/models.dart';

class AppController{

  AppController._(){
    init();
  }

  static AppController _instance = AppController._();

  static AppController get instance => _instance;

  late SharedPreferences _sharedPreferences;

  Future init() async{

    _sharedPreferences = await SharedPreferences.getInstance();

  }

  Future savaUser(UserData user)async{
    await _sharedPreferences.setBool('loggedIn', true);
    await _sharedPreferences.setString('name', user.name ?? '');
    await _sharedPreferences.setString('email', user.email ?? '');
    await _sharedPreferences.setString('token', user.token ?? '');
    await _sharedPreferences.setString('image', user.image ?? '');
    await _sharedPreferences.setString('phone', user.phone ?? '');

  }

  bool loggedIn(){
    return  _sharedPreferences.getBool('loggedIn') ?? false;
  }

  String getName(){
    return  _sharedPreferences.getString('name') ?? '';
  }
  String getEmail(){
    return  _sharedPreferences.getString('email') ?? '';
  }
  String getToken(){
    return  _sharedPreferences.getString('token') ?? '';
  }
  String getImage(){
    return  _sharedPreferences.getString('image') ?? '';
  }
  String getPhone(){
    return  _sharedPreferences.getString('phone') ?? '';
  }

  Future logout()async{
    await _sharedPreferences.clear();
  }


}