import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_anime_list/screens/favorite_screen.dart';
import 'package:my_anime_list/screens/anime_screens/more_anime_screen.dart';
import 'widgets/navigation_bar_widget.dart';
import 'screens/splash_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Anime',
      initialRoute: SplashScreen.splashScreenRoute,
      getPages: [
        GetPage(
          name: SplashScreen.splashScreenRoute,
          page: () => const SplashScreen(),
        ),
        GetPage(
          name: NavigationBarWidget.homeRoute,
          page: () => const NavigationBarWidget(),
        ),
        GetPage(
          name: FavoriteScreen.favoriteScreenRoute,
          page: () => const FavoriteScreen(),
        ),
        GetPage(
          name: MoreAnimeScreen.moreAnimeScreenRoute,
          page: () => const MoreAnimeScreen(),
        ),
      ],
    );
  }
}
