import 'package:get/get.dart';
import 'package:linpo_user/app/modules/MyWashingMachine/retreat_screen.dart';
import 'package:linpo_user/app/modules/MyWashingMachine/shipment_screen.dart';
import 'package:linpo_user/app/modules/MyWashingMachine/step3_Web_Payment_Screen/web_payment_screen.dart';
import 'package:linpo_user/app/modules/address/service_area_check_screen.dart';
import 'package:linpo_user/app/modules/address/no_service_screen.dart';
import 'package:linpo_user/app/modules/address/service_area_screen.dart';
import 'package:linpo_user/app/modules/authentication/forgot_password/forgot_password_screen.dart';
import 'package:linpo_user/app/modules/authentication/forgot_password/verify_password/verify_password_screen.dart';
import 'package:linpo_user/app/modules/authentication/sign_In/sign_in_screen.dart';
import 'package:linpo_user/app/modules/authentication/sign_up/sign_up_screen.dart';
import 'package:linpo_user/app/modules/bottomBar/bottom_bar_screen.dart';

import 'package:linpo_user/app/modules/howdoeswork/how_does_work.dart';
import 'package:linpo_user/app/modules/plans/choose_plan_screen.dart';
import 'package:linpo_user/app/modules/plans/contract_plan/contract_plan_screen.dart';
import 'package:linpo_user/app/modules/plans/our_plan_screen.dart';
import 'package:linpo_user/app/modules/plans/contract_plan/retreat_plan_screen.dart';
import 'package:linpo_user/app/modules/plans/contract_plan/successful_screen.dart';
import 'package:linpo_user/app/modules/plans/terms_condition_screen.dart';

import 'package:linpo_user/app/modules/plus/change_password/change_password.dart';
import 'package:linpo_user/app/modules/plus/contact_us/contact_us_screen.dart';

import 'package:linpo_user/app/modules/plus/my_account/my_account_screen.dart';
import 'package:linpo_user/app/modules/plus/my_address/add_address.dart';
import 'package:linpo_user/app/modules/plus/my_address/my_address_screen.dart';
import 'package:linpo_user/app/modules/plus/my_orders/my_order_screen.dart';
import 'package:linpo_user/app/modules/plus/my_plan/my_plan_screen.dart';
import 'package:linpo_user/app/modules/plus/my_plan/retreat_my_plan_screen.dart';

import 'package:linpo_user/app/modules/plus/payment/payment_screen.dart';
import 'package:linpo_user/app/modules/plus/payment/web_view_screen.dart';
import 'package:linpo_user/app/modules/services/product_details_screen.dart';
import 'package:linpo_user/app/modules/services/services_screen.dart';

import 'package:linpo_user/app/modules/splash/no_internet_screen.dart';
import 'package:linpo_user/app/modules/otp/otp_screen.dart';
import 'package:linpo_user/app/modules/splash/splash_screen.dart';

part './app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.initial,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: Routes.serviceCheckAreaScreen,
      page: () => const ServiceAreaCheckScreen(),
    ),
    GetPage(
      name: Routes.noServiceScreen,
      page: () => const NoServiceScreen(),
    ),
    GetPage(
      name: Routes.serviceAreaScreen,
      page: () => const ServiceAreaScreen(),
    ),
    GetPage(
      name: Routes.signIn,
      page: () => const SignInScreen(),
    ),
    GetPage(
      name: Routes.signUp,
      page: () => const SignUpScreen(),
    ),
    GetPage(
      name: Routes.forgot,
      page: () => const ForgotScreen(),
    ),
    GetPage(
      name: Routes.verifyEmailScreen,
      page: () => const VerifyPasswordScreen(),
    ),
    GetPage(
      name: Routes.bottomBarScreen,
      page: () => const BottomBarScreen(),
    ),
    // GetPage(
    //   name: Routes.mycoupon,
    //   page: () => const MyCouponScreen(),
    // ),
    GetPage(
      name: Routes.contactUs,
      page: () => const ContactUsScreen(),
    ),
    GetPage(
      name: Routes.productDetails,
      page: () => ProductDetailsScreen(),
    ),
    GetPage(
      name: Routes.myAccountScreen,
      page: () => const MyAccountScreen(),
    ),
    GetPage(
      name: Routes.changePassword,
      page: () => const ChangePassword(),
    ),
    GetPage(
      name: Routes.myAddress,
      page: () => const MyAddressScreen(),
    ),
    GetPage(
      name: Routes.addAddress,
      page: () => const AddAddress(),
    ),
    GetPage(
      name: Routes.myPlan,
      page: () => const MyPlanScreen(),
    ),
    GetPage(
      name: Routes.successfulScreen,
      page: () => SuccessfulScreen(),
    ),
    GetPage(
      name: Routes.myOrder,
      page: () => MyOrderScreen(),
    ),
    GetPage(
      name: Routes.serviceScreen,
      page: () => ServiceScreen(),
    ),
    GetPage(
      name: Routes.howDoesWorkScreen,
      page: () => const HowDoesWorkScreen(),
    ),
    GetPage(
      name: Routes.retreatScreen,
      page: () => const RetreatScreen(),
    ),
    GetPage(
      name: Routes.retreatPlan,
      page: () => const RetreatPlan(),
    ),
    GetPage(
      name: Routes.retreatMyPlanScreen,
      page: () => const RetreatMyPlanScreen(),
    ),
    GetPage(
      name: Routes.ourPlanScreen,
      page: () => OurPlanScreen(),
    ),
    GetPage(
      name: Routes.choosePlanScreen,
      page: () => ChoosePlanScreen(),
    ),
    GetPage(
      name: Routes.contractPlanScreen,
      page: () => ContractPlanScreen(),
    ),
    GetPage(
      name: Routes.termsCondition,
      page: () => TermsCondition(),
    ),
    GetPage(
      name: Routes.paymentScreen,
      page: () => const PaymentScreen(),
    ),
    GetPage(
      name: Routes.webViewScreen,
      page: () => WebViewScreen(),
    ),
    GetPage(
      name: Routes.noInternetScreen,
      page: () => const NoInternetConnectionScreen(),
    ),
    GetPage(
      name: Routes.shipmentScreen,
      page: () => ShipmentScreen(),
    ),
    GetPage(
      name: Routes.otpScreen,
      page: () => const OTPScreen(),
    ),
    GetPage(
      name: Routes.webPayMentScreen,
      page: () => WebPayMentScreen(),
    ),
  ];
}
