import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controller/anime_list_controller.dart';
import '../locale/locale.dart';
import '../locale/locale_controller.dart';
import '../screens/sign_in_up_screen/forgot_password_screen.dart';
import '../screens/sign_in_up_screen/sign_in_screen.dart';
import '../screens/sign_in_up_screen/sign_up_screen.dart';
import '../screens/more_media_screen/more_anime_screen.dart';
import '../screens/more_media_screen/more_movie_screen.dart';
import '../screens/watch_trailer_screen.dart';
import '../themes/my_app_theme.dart';
import 'controller/favorite_controller.dart';
import 'controller/manga_controller.dart';
import 'controller/theme_controller.dart';
import 'widgets/navigation_bar_widget.dart';
import 'screens/splash_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put<ThemeController>(ThemeController(), permanent: true);
  Get.put<FavoriteController>(FavoriteController(), permanent: true);
  Get.put<AnimeListController>(AnimeListController(), permanent: true);
  Get.put<MangaController>(MangaController(), permanent: true);
  Get.put<MyLocaleController>(MyLocaleController(), permanent: true);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'My Anime',
          theme: Get.find<ThemeController>().isDarkMode.value
              ? MyAppTheme.customDarkTheme
              : MyAppTheme.customLightTheme,
          locale: Get.find<MyLocaleController>().getCurrentLocale(),
          translations: MyLocale(),
          fallbackLocale: const Locale('en'),
          initialRoute: SplashScreen.splashScreenRoute,
          getPages: [
            GetPage(
              name: SplashScreen.splashScreenRoute,
              page: () => const SplashScreen(),
            ),
            GetPage(
              name: SignInScreen.singInScreenRoute,
              page: () => SignInScreen(),
            ),
            GetPage(
              name: SignUpScreen.signUpScreenRoute,
              page: () => SignUpScreen(),
            ),
            GetPage(
              name: ForgotPasswordScreen.forgotPasswordScreenRoute,
              page: () => const ForgotPasswordScreen(),
            ),
            GetPage(
              name: NavigationBarWidget.homeRoute,
              page: () => const NavigationBarWidget(),
            ),
            GetPage(
              name: MoreAnimeScreen.moreAnimeScreenRoute,
              page: () => const MoreAnimeScreen(),
            ),
            GetPage(
              name: MoreMovieScreen.moreMovieScreen,
              page: () => const MoreMovieScreen(),
            ),
            GetPage(
              name: WatchTrailerScreen.watchMoreScreen,
              page: () => const WatchTrailerScreen(),
            ),
          ],
        );
      },
    );
  }
}
