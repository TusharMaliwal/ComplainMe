import 'package:complain_me/models/complain.dart';
import 'package:flutter/material.dart';


const Color kColorYellow = Color(0xffffc700);
const Color kColorRed = Color(0xffff403b);
const Color kColorBlack = Color(0xff000000);
const Color kColorGrey = Color(0xffeeeeee);
const Color kColorShadow = Color(0x03000000);

const kHostUrl = 'http://192.168.43.50/complain_me-app';
const String kRegisterUrl = "$kHostUrl/registration.php";
const String kLoginUrl = "$kHostUrl/login_user.php";
const String kSaveDetailsUrl = "$kHostUrl/save_user_details.php";
const String kLoadUserDetailsUrl = "$kHostUrl/load_user_details.php";
const String kCheckUserDetailsUrl = "$kHostUrl/check_user_details.php";
const String kLoadCategoriesUrl = "$kHostUrl/load_categories.php";
const String kLoadDishesUrl = "$kHostUrl/load_dishes.php";
const String kLoadRestaurantsUrl = "$kHostUrl/load_restaurants.php";
const String kMostPopularDishUrl = "$kHostUrl/load_most_popular.php";
const String kLoadRestaurantMenuUrl = "$kHostUrl/load_restaurant_menu.php";
const String kOpenRestaurantUrl = "$kHostUrl/load_dish_restaurant.php";
const String kPlaceOrderUrl = "$kHostUrl/place_order.php";
const String kGetOrdersUrl = "$kHostUrl/get_orders.php";
const String kRemoveOrderUrl = "$kHostUrl/remove_order.php";
const String kUpdateAddressUrl = "$kHostUrl/update_address.php";
const String kHostDeliveryLocationUrl = "$kHostUrl/host_delivery_location.php";
const String kReceiveDeliveryLocationUrl = "$kHostUrl/receive_delivery_location.php";
const String kSendOtpUrl = "$kHostUrl/send_sms.php";
const String kVerifyOtpUrl = "$kHostUrl/verify_otp.php";

const TextStyle kHeadingStyle = TextStyle(
  fontFamily: 'GT Eesti',
  color: kColorBlack,
  fontSize: 24,
  fontWeight: FontWeight.w600,
);
const TextStyle kLabelStyle = TextStyle(
  fontFamily: 'GT Eesti',
  color: kColorBlack,
  fontSize: 24,
);
const TextStyle kItemStyle = TextStyle(
  fontFamily: 'GT Eesti',
  color: kColorBlack,
  fontSize: 20,
);

const List<Complain> kCommonCategories = [
  Complain(id: 'complain_corrupt',name: 'Corruption'),
  Complain(id: 'complain_roads',name: 'Road Quality'),
  Complain(id: 'complain_traffic',name: 'Traffic Problems'),
  Complain(id: 'complain_dessert',name: 'Desserts'),
  Complain(id: 'complain_fries',name: 'Fries'),
  Complain(id: 'complain_shake',name: 'Shakes'),
];