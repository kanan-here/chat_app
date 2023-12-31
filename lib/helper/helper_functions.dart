import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions{
  static String sharedPreferenceUserLoggedInKey='ISLOGGEDIN';
  static String sharedPreferenceUserNameKey='USERNAMEKEY';
  static String sharedPreferenceUserEmailKey='USEREMAILKEY';
  // saving data to SharedPreference
static Future<bool> saveUserLoggedInSharedPreference(
    bool isUserLoggedIn
    )
async{
  SharedPreferences prefs=await SharedPreferences.getInstance();
  return await prefs.setBool(sharedPreferenceUserLoggedInKey,isUserLoggedIn);
}

  static Future<bool> saveUserNameSharedPreference(
      String userName
      )
  async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserNameKey,userName);
  }
  static Future<bool> saveUserEmailSharedPreference(
      String userEmail
      )
  async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserNameKey,userEmail);
  }
  // getting data from shared preference
  static Future<bool?> getUserLoggedInSharedPreference()
  async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return await prefs.getBool(sharedPreferenceUserLoggedInKey);
  }
  static Future<bool?> getUserNameSharedPreference()
  async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return await prefs.getBool(sharedPreferenceUserNameKey);
  }
  static Future<String?> getUserEmailSharedPreference()
  async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return await prefs.getString(sharedPreferenceUserEmailKey);
  }
}