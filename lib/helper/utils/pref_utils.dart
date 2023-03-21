import 'package:get_storage/get_storage.dart';
import 'package:linpo_user/helper/utils/common_functions.dart';

class PrefUtils {
  static PrefUtils? _shared;

  PrefUtils._();

  static PrefUtils get getInstance => _shared = _shared ?? PrefUtils._();

  final _box = GetStorage();

  final credential = GetStorage();

  String get accessToken => "accessToken";
  String get profile => "profile";
   String get profileName => "profileName";
  String get isUserLoginKey => "isUserLogin";
  String get googleId => "googleId";
  String get facebookId => "facebookId";
  String get serviceArea => "serviceArea";
  String get generalSetting => "generalSetting";
  String get otpLoader => "otpLoader";

  String get userId => "userId";

  apiConfig() {
    final apiConfig = readData(PrefUtils.getInstance.userId);

    return apiConfig;
  }

  isUserLogin() {
    return !isNullEmptyOrFalse(readData(PrefUtils.getInstance.profile));
  }

  writeData(String key, dynamic value) async {
    await _box.write(key, value);
  }

  readData(String key) {
    dynamic jsonData = _box.read(key);
    return jsonData;
  }

  Future<void> clearLocalStorage() async {
    await _box.erase();
  }
}
