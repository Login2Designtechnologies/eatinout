// ignore_for_file: non_constant_identifier_names, file_names

import 'package:get_storage/get_storage.dart';

final getData = GetStorage();
save(Key, val) {
  final data = GetStorage();
  data.write(Key, val);
}

bool? getBool(String key) {
  final value = getData.read(key);
  if (value is String) {
    if (value.toString().toLowerCase().trim() == "true") {
      return true;
    } else {
      return false;
    }
  } else {
    return getData.read(key);
  }
}

Future<void> setBool(String key, bool value) async {
  return await getData.write(key, value);
}
