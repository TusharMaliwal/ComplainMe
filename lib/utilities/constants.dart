
import 'package:flutter/material.dart';

const Color kColorYellow = Color(0xffffc700);
const Color kColorRed = Color(0xffff403b);
const Color kColorBlack = Color(0xff000000);
const Color kColorGrey = Color(0xffeeeeee);
const Color kColorShadow = Color(0x03000000);
const Color kColorWhite = Color(0xFFFFFFFF);
const Color kColorLight = Color(0xFFEFDCF9);
const Color kColorDark = Color(0xFF323E42);
const Color kColorPrimary = Color(0xFFC55FFC);
const Color kColorPrimaryDark = Color(0xFF7954A1);

const kSpace10Ver = SizedBox(
  height: 10,
);

const kSpace30Ver = SizedBox(
  height: 30,
);

const kSpace50Ver = SizedBox(
  height: 50,
);

const kSpace10Hor = SizedBox(
  width: 10,
);



const kHostUrl = 'http://10.0.1.84:8000/complain_me-app';
const String kRegisterUrl = "$kHostUrl/save_user_details.php";
const String kLoginUrl = "$kHostUrl/login_user.php";
const String kLoadUserDetailsUrl = "$kHostUrl/load_user_details.php";

const String kCheckUserDetailsUrl = "$kHostUrl/check_user_details.php";
const String kLoadPostUrl = "$kHostUrl/load_posts.php";
const String kRemovePostLikeUrl = "$kHostUrl/remove_post_like.php";
const String kLikePostUrl = "$kHostUrl/like_post.php";
const String kDeletePostUrl = "$kHostUrl/delete_post.php";
const String kUploadPostUrl = "$kHostUrl/upload_post.php";
const String kLoadCommentsUrl = "$kHostUrl/load_comment_post.php";
const String kPostCommentUrl = "$kHostUrl/post_comment.php";
const String kGetOrdersUrl = "$kHostUrl/get_orders.php";
const String kRemoveOrderUrl = "$kHostUrl/remove_order.php";
const String kUpdateAddressUrl = "$kHostUrl/update_address.php";
const String kHostDeliveryLocationUrl = "$kHostUrl/host_delivery_location.php";
const String kReceiveDeliveryLocationUrl =
    "$kHostUrl/receive_delivery_location.php";
const String kSendOtpUrl = "$kHostUrl/send_sms.php";
const String kVerifyOtpUrl = "$kHostUrl/verify_otp.php";
const String kValidateUrl = "$kHostUrl/validate_user.php";

const String kProfImageUrl = "$kHostUrl/Profilepics/";
const String kPostImageUrl = "$kHostUrl/PostPics/";

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

