import 'package:bridges_of_glory/core/common_widgets/info_widget.dart';
import 'package:bridges_of_glory/core/route/app_routes.dart';
import 'package:bridges_of_glory/views/auth/forgot/reset_password_screen.dart';
import 'package:bridges_of_glory/views/auth/forgot/verify_email_screen.dart';
import 'package:bridges_of_glory/views/auth/forgot/verify_otp_screen.dart';
import 'package:bridges_of_glory/views/auth/select_user.dart';
import 'package:bridges_of_glory/views/auth/signup/check_email_screen.dart';
import 'package:bridges_of_glory/views/auth/signup/signup_screen.dart';
import 'package:bridges_of_glory/views/auth/splash/splash_screen.dart';
import 'package:bridges_of_glory/views/donation/bottom_nav_donation.dart';
import 'package:bridges_of_glory/views/donation/explore/adopt_project_screen.dart';
import 'package:bridges_of_glory/views/donation/explore/adopt_detail_screen.dart';
import 'package:bridges_of_glory/views/donation/explore/empowerment_detail_screen.dart';
import 'package:bridges_of_glory/views/donation/explore/empowerment_screen.dart';
import 'package:bridges_of_glory/views/donation/explore/explore_screen.dart';
import 'package:bridges_of_glory/views/donation/explore/witness_women_detail_screen.dart';
import 'package:bridges_of_glory/views/donation/explore/witness_women_screen.dart';
import 'package:bridges_of_glory/views/donation/home/donar_home_screen.dart';
import 'package:bridges_of_glory/views/donation/library/library_screen.dart';
import 'package:bridges_of_glory/views/donation/library/view_book_screen.dart';
import 'package:bridges_of_glory/views/donation/payment/payment_screen.dart';
import 'package:bridges_of_glory/views/donation/payment/payment_success_screen.dart';
import 'package:bridges_of_glory/views/donation/profile/donar_setting_screen.dart';
import 'package:bridges_of_glory/views/donation/profile/doner_profile_setting.dart';
import 'package:bridges_of_glory/views/info_screen.dart';
import 'package:bridges_of_glory/views/owner/bible/bible_listing_screen.dart';
import 'package:bridges_of_glory/views/owner/bible/owner_bible_reading_screen.dart';
import 'package:bridges_of_glory/views/owner/create/create_screen.dart';
import 'package:bridges_of_glory/views/owner/home/message_screen.dart';
import 'package:bridges_of_glory/views/owner/home/owner_home_screen.dart';
import 'package:bridges_of_glory/views/owner/owner_bottom_nav.dart';
import 'package:bridges_of_glory/views/owner/profile/owner_profile_screen.dart';
import 'package:bridges_of_glory/views/owner/project/owner_project_details.dart';
import 'package:get/get.dart';

import '../../views/auth/login/login_screen.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.splashScreen, page: () => SplashScreen()),
    GetPage(
      name: AppRoutes.infoScreen,
      page: () =>
          InfoScreen(onTap: () {}, title: '', information: '', description: ''),
    ),
    GetPage(name: AppRoutes.selectUser, page: () => SelectUserScreen()),
    GetPage(name: AppRoutes.login, page: () => LoginScreen()),
    GetPage(name: AppRoutes.signup, page: () => SignupScreen()),
    GetPage(name: AppRoutes.checkEmail, page: () => CheckEmailScreen()),
    GetPage(name: AppRoutes.verifyEmail, page: () => VerifyEmailScreen()),
    GetPage(name: AppRoutes.verifyOtp, page: () => VerifyOtpScreen()),
    GetPage(name: AppRoutes.resetPassword, page: () => ResetPasswordScreen()),

    /// --------------------------------- donation bottom nav -------------------------------------- ///
    GetPage(name: AppRoutes.donationBottomNav, page: () => BottomNavDonation()),

    /// ------------------------------------------- Donation ----------------------------------------///
    GetPage(name: AppRoutes.explore, page: () => ExploreScreen()),
    GetPage(name: AppRoutes.empowerment, page: () => EmpowermentScreen()),
    GetPage(name: AppRoutes.donerHome, page: () => DonerHomeScreen()),
    GetPage(name: AppRoutes.donerSettings, page: () => DonerSettingScreen()),
    GetPage(
      name: AppRoutes.donerProfileSettings,
      page: () => DonerProfileSetting(),
    ),
    GetPage(name: AppRoutes.libraryScreen, page: () => LibraryScreen()),
    GetPage(name: AppRoutes.viewBookScreen, page: () => ViewBookScreen()),
    GetPage(
      name: AppRoutes.adoptProjectScreen,
      page: () => AdoptProjectScreen(),
    ),
    GetPage(name: AppRoutes.adoptDetailScreen, page: () => AdoptDetailScreen()),
    GetPage(
      name: AppRoutes.witnessWomenScreen,
      page: () => WitnessWomenScreen(),
    ),
    GetPage(
      name: AppRoutes.witnessWomenDetailScreen,
      page: () => WitnessWomenDetailScreen(),
    ),
    GetPage(
      name: AppRoutes.empowermentDetailScreen,
      page: () => EmpowermentDetailScreen(),
    ),
    GetPage(name: AppRoutes.paymentScreen, page: () => PaymentScreen()),
    GetPage(
      name: AppRoutes.paymentSuccessScreen,
      page: () => PaymentSuccessScreen(),
    ),

    GetPage(name: AppRoutes.ownerBottomNav, page: () => OwnerBottomNav()),
    GetPage(
      name: AppRoutes.ownerProfileScreen,
      page: () => OwnerProfileScreen(),
    ),
    GetPage(
      name: AppRoutes.ownerBibleListing,
      page: () => BibleListingScreen(),
    ),
    GetPage(
      name: AppRoutes.ownerBibleReadingScreen,
      page: () => OwnerBibleReadingScreen(),
    ),
    GetPage(
      name: AppRoutes.ownerProjectScreen,
      page: () => OwnerProfileScreen(),
    ),
    GetPage(
      name: AppRoutes.ownerProjectDetailScreen,
      page: () => OwnerProjectDetails(),
    ),
    GetPage(name: AppRoutes.ownerHomeScreen, page: () => OwnerHomeScreen()),
    GetPage(name: AppRoutes.createScreen, page: () => CreateScreen()),
    GetPage(name: AppRoutes.messageScreen, page: () => MessageScreen()),
  ];
}
