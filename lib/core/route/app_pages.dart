import 'package:bridges_of_glory/core/common_widgets/info_widget.dart';
import 'package:bridges_of_glory/core/route/app_routes.dart';
import 'package:bridges_of_glory/views/auth/select_user.dart';
import 'package:bridges_of_glory/views/auth/signup/check_email_screen.dart';
import 'package:bridges_of_glory/views/auth/signup/signup_screen.dart';
import 'package:bridges_of_glory/views/auth/splash/splash_screen.dart';
import 'package:bridges_of_glory/views/info_screen.dart';
import 'package:get/get.dart';

import '../../views/auth/login/login_screen.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.splashScreen, page: () => SplashScreen()),
    GetPage(name: AppRoutes.infoScreen, page: () => InfoScreen()),
    GetPage(name: AppRoutes.selectUser, page: () => SelectUserScreen()),
    GetPage(name: AppRoutes.login, page: () => LoginScreen()),
    GetPage(name: AppRoutes.signup, page: () => SignupScreen()),
    GetPage(name: AppRoutes.checkEmail, page: () => CheckEmailScreen()),
  ];
}
