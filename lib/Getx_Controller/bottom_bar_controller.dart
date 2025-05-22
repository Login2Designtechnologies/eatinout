import 'package:get/get.dart';

class BottomBarController extends GetxController {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  setSelectedIndex(selectedIndex) {
    print('changing index from bottom bar controller');
    _selectedIndex = selectedIndex;
    update();
  }
}
