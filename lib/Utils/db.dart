import 'package:dineout/Utils/String.dart';
import 'package:shared_preferences/shared_preferences.dart';

saveCountryCode(String cCode) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  try {
    await pref.setString(provider.COUNTRY_CODE, cCode);
    return true;
  } catch (e) {
    print('error in save user email function');
    return false;
  }
}

getCountryCode() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  try {
    return await pref.getString(provider.COUNTRY_CODE);
  } catch (e) {
    print('error in getiing user email from local db');
  }
}

savePhoneNumber(String value) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  try {
    await pref.setString(provider.USER_PHONE, value);
    return true;
  } catch (e) {
    print('error in save phone');
    return false;
  }
}

getPhoneNumber() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  try {
    String? phone = await pref.getString(provider.USER_PHONE);
    print('number is ');
    print(phone);
    return await pref.getString(provider.USER_PHONE);
  } catch (e) {
    print('error in getiing phone');
  }
}

saveUserPass(String pass) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  try {
    await pref.setString(provider.USER_PASS, pass);
    return true;
  } catch (e) {
    print('error in save user email function');
    return false;
  }
}

getUserPassword() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  try {
    return await pref.getString(provider.USER_PASS);
  } catch (e) {
    print('error in getiing user password from local db');
  }
}

// removeUserEmail() async {
//   SharedPreferences pref = await SharedPreferences.getInstance();
//   try {
//     await pref.remove(EMAIL);
//   } catch (e) {
//     print('error in remove user email function');
//   }
// }

// removeUserPass() async {
//   SharedPreferences pref = await SharedPreferences.getInstance();
//   try {
//     await pref.remove(PASSWORD);
//   } catch (e) {
//     print('error in remove user email function');
//   }
// }

// saveToken(String token) async {
//   SharedPreferences pref = await SharedPreferences.getInstance();
//   try {
//     await pref.setString(TOKEN, token);
//     return true;
//   } catch (e) {
//     print('error in save user email function');
//     return false;
//   }
// }

// getToken() async {
//   SharedPreferences pref = await SharedPreferences.getInstance();
//   try {
//     return await pref.getString(TOKEN);
//   } catch (e) {
//     print('error in getiing user email from local db');
//   }
// }

// savePasscode(String passcode) async {
//   SharedPreferences pref = await SharedPreferences.getInstance();
//   try {
//     await pref.setString(PASSCODE, passcode);
//     return true;
//   } catch (e) {
//     print('error in save passcode');
//     return false;
//   }
// }

// getPasscode() async {
//   SharedPreferences pref = await SharedPreferences.getInstance();
//   try {
//     String? passcode = await pref.getString(PASSCODE);
//     print('passcode is 09090909090909');
//     print(passcode);
//     return await pref.getString(PASSCODE);
//   } catch (e) {
//     print('error in getiing passcode');
//   }
// }

// saveUserName(String value) async {
//   SharedPreferences pref = await SharedPreferences.getInstance();
//   try {
//     await pref.setString(USERNAME, value);
//     return true;
//   } catch (e) {
//     print('error in save phone');
//     return false;
//   }
// }

// getUserName() async {
//   SharedPreferences pref = await SharedPreferences.getInstance();
//   try {
//     String? phone = await pref.getString(USERNAME);
//     print('number is ');
//     print(phone);
//     return await pref.getString(USERNAME);
//   } catch (e) {
//     print('error in getiing phone');
//   }
// }
