import 'package:flutter/foundation.dart';

printf(s) {
  if (kDebugMode) {
    print(s.toString());
  }
}
