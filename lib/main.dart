import 'package:dineout/Getx_Controller/Controller.dart';
import 'package:dineout/Getx_Controller/location_controller.dart';
import 'package:dineout/HomeScreen/Map.dart';
import 'package:dineout/HomeScreen/add_address_screen.dart';
import 'package:dineout/Hotel%20Menu/showPdf.dart';
import 'package:dineout/LoginFlow/Verify_Account.dart';
import 'package:dineout/Search/screens/search_screen.dart';
import 'package:dineout/Utils/dark_light_mode.dart';
import 'package:dineout/IntroScreen/IntroScreen.dart';
import 'package:dineout/all_bindings.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'Utils/language_translate.dart';
import 'api/Data_save.dart';
import 'api/confrigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // await Firebase.initializeApp();
  await GetStorage.init();
  initPlatformState();
  // Get.put(LocationController());
  // Get.put(HomeController());
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ColorNotifier())],
      child: GetMaterialApp(
        initialBinding: AllBindings(),
        title: "Eat In Out",
        translations: LocaleString(),
        locale: getData.read("lan2") != null
            ? Locale(getData.read("lan2"), getData.read("lan1"))
            : const Locale('en_US', 'en_US'),
        theme: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          dividerColor: Colors.transparent,
          useMaterial3: false,
        ),
        debugShowCheckedModeBanner: false,
        home: const onbording(),
        // home: VerifyAccount(),
        // home: Menu(
        // pdfUrl: "http://www.pdf995.com/samples/pdf.pdf",
        // ),
      ),
    ),
  );
}
// Future<void> initPlatformState() async {
//   OneSignal.shared.setAppId(AppUrl.oneSignel);
//   OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {});
//   OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
//     print("Accepted OSPermissionStateChanges : $changes");
//   });
//
// }

Future<void> initPlatformState() async {
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize(AppUrl.oneSignel);
  OneSignal.Notifications.requestPermission(true).then(
    (value) {
      // ignore: avoid_print
      print("Signal value:- $value");
    },
  );
}
