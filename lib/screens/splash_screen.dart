import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:my_anime/constants.dart';
import 'package:my_anime/controller/theme_controller.dart';
import '../../screens/sign_in_up_screen/sign_in_screen.dart';
import '../widgets/navigation_bar_widget.dart';

class SplashScreen extends StatefulWidget {
  static const String splashScreenRoute = '/splash';
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final ThemeController themeController = Get.find();

  @override
  void initState() {
    super.initState();
    navigateToHome();
  }

  void navigateToHome() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        themeController.isDarkMode();
      });
      Future.delayed(const Duration(milliseconds: 300), () {
        Get.offAllNamed(SignInScreen.singInScreenRoute);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Container(
          key: ValueKey<bool>(themeController.isDarkMode.value),
          color: themeController.isDarkMode.value ? kDarkColor : kLightColor,
          alignment: Alignment.center,
          child: SpinKitPumpingHeart(
            color: themeController.isDarkMode.value ? kDarkTeal1 : Colors.red,
            size: 50.0.sp,
          ),
        ),
      ),
    );
  }
}
