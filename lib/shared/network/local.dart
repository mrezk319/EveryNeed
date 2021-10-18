import 'package:shared_preferences/shared_preferences.dart';
class CacheHelper{
  static SharedPreferences? sharedPreferences ;
  static init() async{
    sharedPreferences = await SharedPreferences.getInstance();
  }


  static Future saveData({required key,required value})async{
    if(value is bool) {
      return await sharedPreferences!.setBool(key, value);
    }
    if(value is String) {
      return await sharedPreferences!.setString(key, value);
    }
  }
  static getData({required key}){
    return sharedPreferences!.get(key);
  }

  // static delete(key1,key2,key3,key4){
  //   sharedPreferences!.remove(key1);
  //   sharedPreferences!.remove(key2);
  //   sharedPreferences!.remove(key3);
  //   sharedPreferences!.remove(key4);
  // }
}