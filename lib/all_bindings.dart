import 'package:dineout/Getx_Controller/Controller.dart';
import 'package:dineout/Getx_Controller/location_controller.dart';
import 'package:get/get.dart';

class AllBindings extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => AuthController(), fenix: true);
    Get.put(HomeController(), permanent: true);

    // Get.put(AuthController());
    // Get.put(LocationController(), permanent: true);
    // Get.put(WalletController());
    // Get.put(CouponController());
    // Get.put(ShopController());
    // Get.put(ProfileController());
  }
}
