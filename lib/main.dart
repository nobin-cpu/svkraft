import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sv_craft/Features/auth/view/signin_screen.dart';
import 'package:sv_craft/Features/auth/view/signup_screen.dart';
import 'package:sv_craft/Features/cart/view/cart_screen.dart';
import 'package:sv_craft/Features/cart/view/checkout_screen.dart';
import 'package:sv_craft/Features/home/controller/home_controller.dart';
import 'package:sv_craft/Features/home/home_screen.dart';
import 'package:sv_craft/Features/market_place/view/market_place.dart';
import 'package:sv_craft/Features/profile/view/address_page.dart';
import 'package:sv_craft/Features/profile/view/profile_screen.dart';
import 'package:sv_craft/Features/seller_profile/view/profile.dart';
import 'package:sv_craft/Features/special_day/view/special_home_screen.dart';
import 'package:sv_craft/app/ControllerBinging/all_controller_binding.dart';
import 'package:sv_craft/common/test.dart';
import 'package:sv_craft/constant/color.dart';
import 'package:sv_craft/localString.dart';
import 'package:sv_craft/splash_screen.dart';
import 'Features/auth/view/forgate_password_screen.dart';
import 'Features/auth/view/forgate_otp.dart';
import 'Features/auth/view/signup_otp.dart';
import 'Features/grocery/view/grocery_product.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Features/home/my_home_test.dart';
import 'Features/seller_profile/view/conto.dart';
import 'firebase_options.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

var mainUserID;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  OneSignal.shared.setAppId('8e1e8772-aef1-4002-9728-719a3f8e6dae');

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final HomeController _homeController = Get.put(HomeController());
  late int userId = 0;
  late String tokens;
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      setTokenToVariable();
    });
  }

  Future<void> setTokenToVariable() async {
    final userid = await _homeController.getUserId();
    mainUserID = userid;
    token = await _homeController.getToken();
    if (userid != null) {
      setState(() {
        userId = userid;
      });
    }
  }

  // getToken() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? token = prefs.getString('auth-token');
  //   print(token);
  //   return token;
  // }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        // localizationsDelegates: GlobalMaterialLocalizations.delegates,
        supportedLocales: [const Locale('en'), const Locale('ar')],
        translations: LocalString(),
        locale: Locale("arabic"),
        initialBinding: AllControllerBinding(),
        debugShowCheckedModeBanner: false,
        title: 'SV Kraft',
        theme: ThemeData(
          fontFamily: "Cabin-Regular",
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Appcolor.primaryColor,
            secondary: Appcolor.primaryColor,
          ),
          // Add font family
          // fontFamily: 'AbyssinicaSIL',
        ),
        // initialRoute: "/signup",
        getPages: [
          GetPage(name: "/", page: () => const SplashScreen()),
          GetPage(name: "/signin", page: () => SigninScreen()),
          GetPage(name: "/signup", page: () => SignupScreen()),
          GetPage(name: "/forgatepass", page: () => ForgatePasswordScreen()),
          GetPage(name: "/forgateotp", page: () => OtpSendScreen()),
          // GetPage(name: "/signupotp", page: () => OtpToHomeScreen()),
          GetPage(name: "/home", page: () => const HomeScreen()),
          // GetPage(name: "/bottombar", page: () => const BottomBar()),
          GetPage(name: "/groceryproduct", page: () => GroceryProduct()),
          // GetPage(name: "/filtercateogory", page: () => FilterCatogory()),
          GetPage(name: "/cart", page: () => const CartScreen()),
          GetPage(name: "/specialhome", page: () => SpecialHomeScreen()),
          // GetPage(
          //     name: "/specialcategoryproduct",
          //     page: () => CategoryProuctScreen()),
          // GetPage(
          //     name: "/specialproductdetails",
          //     page: () => const ProductDetails()),
          GetPage(name: "/marketplace", page: () => MarketPlace()),
          //GetPage(name: "/marketfilter", page: () => const MarketFilter()),
          GetPage(name: "/profile", page: () => ProfileScreen()),
          // GetPage(name: "/editprofile", page: () => EditProfile()),
          GetPage(name: "/test", page: () => TestPage()),
          GetPage(name: "/hometest", page: () => MyHomePage()),
        ],
        home: userId == 0 ? SigninScreen() : SplashScreen());
  }
}
