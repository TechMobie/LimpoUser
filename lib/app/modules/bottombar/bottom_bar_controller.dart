
import 'package:get/get.dart';
import 'package:linpo_user/helper/utils/images.dart';



class BottomBarController extends GetxController {
  RxInt currentIndex = 0.obs;
  RxInt current = 0.obs;
  final RxList<String> images =
      [ImageConstants.banner1, ImageConstants.banner2,ImageConstants.banner3].obs;
}
