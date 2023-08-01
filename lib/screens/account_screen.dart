import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_anime/constants.dart';
import 'package:my_anime/controller/feed_back_controller.dart';
import 'package:my_anime/controller/theme_controller.dart';
import 'package:get/get.dart';
import 'package:my_anime/screens/sign_in_up_screen/sign_in_screen.dart';
import '../../auth.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key, required this.themeController})
      : super(key: key);
  final ThemeController themeController;

  @override
  AccountScreenState createState() => AccountScreenState();
}

class AccountScreenState extends State<AccountScreen> {
  String? userProfileImageUrl;

  @override
  void initState() {
    super.initState();
    loadUserProfileImageUrl();
  }

  Future<void> loadUserProfileImageUrl() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String? imageUrl = await Auth().getUserProfileImageUrl(user.uid);
        setState(() {
          userProfileImageUrl = imageUrl;
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error loading user profile image: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    final FeedbackController feedbackController = Get.find();
    return Scaffold(
      backgroundColor:
          themeController.isDarkMode.value ? kDarkColor : kPaleLavender,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor:
            themeController.isDarkMode.value ? kDarkColor : kPaleLavender,
        title: Text(
          'Account',
          style: kBoldText(themeController, kBigText + 2.5),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0.h),
          child: Container(
            color: themeController.isDarkMode.value ? kLightColor : kDarkColor,
            height: 1.0.h,
          ),
        ),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(kDefaultPadding * 2),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: kDefaultPadding * 2),
                child: CircleAvatar(
                  radius: 50.w,
                  child: ClipOval(
                    child: userProfileImageUrl != null
                        ? Image.network(
                            userProfileImageUrl!,
                            fit: BoxFit.cover,
                            width: 100.w,
                            height: 100.h,
                          )
                        : Image.asset(
                            'assets/images/anime_icon.jpg',
                            fit: BoxFit.cover,
                            width: 100.w,
                            height: 100.h,
                          ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: kDefaultPadding * 2),
                child: TextFormField(
                  style: kBoldText(themeController, kSmallText),
                  onChanged: (value) {
                    if (value.length > 200) {
                      value = value.substring(0, 200);
                    }
                    feedbackController.updateFeedbackText(value);
                  },
                  maxLength: 200,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Enter Your Feedback Here',
                    hintStyle: kLightText(themeController, kSmallText),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kBorderRadius),
                    ),
                    counter: const SizedBox
                        .shrink(), // Hide the built-in character counter
                    suffix: Obx(
                      () => Text(
                        '${feedbackController.feedbackText.value.length}/200',
                        style: kBoldText(themeController, kSmallText),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 150.w,
                height: 40.h,
                child: ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Get.offAllNamed(SignInScreen.singInScreenRoute);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text(
                    'Sign Out',
                    style: TextStyle(color: kLightColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
