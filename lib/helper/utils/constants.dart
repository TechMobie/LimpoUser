// ignore_for_file: constant_identifier_names

import 'dart:ui';
import 'dart:io' show Platform;
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ApiConstants {
  // static const baseURL = "https://www.chktechnology.com/limpo/";
  static const baseURL = "http://limpoapp.cl/public/dev/"; //DEV
  // static const baseURL = "https://limpoapp.cl/"; //Prod

  static const String apiV1Url = "${baseURL}api/user/";
  //Authentication
  static const loginUrl = "${apiV1Url}login";
  static const registerUrl = "${apiV1Url}register";
  static const forgotPasswordUrl = "${apiV1Url}forgot-password";
  static const resetPasswordUrl = "${apiV1Url}reset-password";
  static const verifyOtpUrl = "${apiV1Url}verify-otp";
  static const resendOtpUrl = "${apiV1Url}resend-otp";
  static const editProfileUrl = "${apiV1Url}edit-profile";
  static const logoutUrl = "${apiV1Url}logout";
  static const deleteAccountUrl = "${apiV1Url}delete-account";
  static const changePasswordUrl = "${apiV1Url}change-password";
  static const contactUsUrl = "${apiV1Url}contact-us";
  static const lastLoginUrl = "${apiV1Url}last-login";
  static const checkServiceAreaUrl = "${apiV1Url}check-service-area";
  static const profileUrl = "${apiV1Url}profile/";
  static const fcmRegisterToken = "${apiV1Url}fcm/registration";
  static const coveragerequestUrl = "${apiV1Url}coverage-request";

  //Address url
  static const getAddress = "${apiV1Url}get-address";
  static const addAddress = "${apiV1Url}add-address";
  static const deleteAddress = "${apiV1Url}delete-address";
  static const editAddress = "${apiV1Url}edit-address";
  //service url
  static const getProduct = "${apiV1Url}get-products";
  static const getTypeOfServices = "${apiV1Url}get-type-of-services";
  static const addToCartServices = "${apiV1Url}add-to-cart";
  //plan url
  static const getPlans = "${apiV1Url}get-plans";
  static const getTypeOfPlans = "${apiV1Url}get-type-of-plans";
  static const checkoutPlan = "${apiV1Url}checkout-plan";
  static const getPlan = "${apiV1Url}get-plan";
  static const cancelPlan = "${apiV1Url}cancel-plan";
  static const editPlan = "${apiV1Url}edit-plan";
  static const editOrder = "${apiV1Url}edit-order";

  ///my washing machine url
  static const getCart = "${apiV1Url}get-cart";

  ///checkout api

  static const checkOut = "${apiV1Url}checkout";

  //Order
  static const getOrderDetails = "${apiV1Url}get-orders";
  static const getAllOrderStatus = "${apiV1Url}get-all-order-status";

  //payment
  static const getCard = "${apiV1Url}get-card";
  static const deleteCard = "${apiV1Url}delete-card";
  static const editCard = "${apiV1Url}edit-card";
  static const addCard = "${apiV1Url}add-card";
  static const createEnrollment = "${apiV1Url}create-enrollment";
  static const confirmEnrollment = "${apiV1Url}confirm-enrollment";
  static const createTransaction = "${apiV1Url}create-transaction";
  static const confirmTransaction = "${apiV1Url}confirm-transaction";

  //general
  static const generalSetting = "${apiV1Url}get-general-setting";
}

String fcmToken = "";
String serviceAreaName = "";
RxDouble totalQuentity = 0.0.obs;
String placeKey = Platform.isAndroid
    ? "AIzaSyCMlJbb6XFwbVMDj_msYIt_gcfhU7Rhubo"
    : "AIzaSyAjSmLSajFEGYeEX1pXnGAmBzYbVbM1YC0"; //AIzaSyD0OKN2LCMXxtgPHqHKeDgdGzsqF-bA3hE
Locale? myLocale;

final formatCurrency = NumberFormat.simpleCurrency(decimalDigits: 0);

class NotificationConsumerType {
  static const MESSAGING = 'messaging';
}
