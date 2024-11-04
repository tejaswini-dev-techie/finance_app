import 'dart:io';
import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:hp_finance/Constants/app_config_constants.dart';
import 'package:hp_finance/Constants/sharedpreference_constants.dart';
import 'package:hp_finance/Utils/print_util.dart';
import 'package:hp_finance/Utils/sharedpreferences_util.dart';
import 'package:intl/intl.dart';

class GetDeviceInfo {
  static final GetDeviceInfo _singleton = GetDeviceInfo._internal();

  factory GetDeviceInfo() {
    return _singleton;
  }

  GetDeviceInfo._internal();

  static Map<String, dynamic> deviceInfoData = <String, dynamic>{};
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  /* To Get Device Info */
  Future<Map<String, dynamic>> updateDeviceInfo() async {
    String? mob = await SharedPreferencesUtil.getSharedPref(
            SharedPreferenceConstants.prefMobileNumber) ??
        "";
    String? userID = await SharedPreferencesUtil.getSharedPref(
            SharedPreferenceConstants.prefUserID) ??
        "";
    String? userType = await SharedPreferencesUtil.getSharedPref(
            SharedPreferenceConstants.prefUserType) ??
        "";
    String? secKey = await SharedPreferencesUtil.getSharedPref(
            SharedPreferenceConstants.prefSecretKey) ??
        "";

    String? deviceModel = await SharedPreferencesUtil.getSharedPref(
            SharedPreferenceConstants.prefDeviceModel) ??
        "";
    String? deviceVersion = await SharedPreferencesUtil.getSharedPref(
            SharedPreferenceConstants.prefDeviceVersion) ??
        "";
    String? deviceID = await SharedPreferencesUtil.getSharedPref(
            SharedPreferenceConstants.prefDeviceID) ??
        "";
    String? deviceBrand = await SharedPreferencesUtil.getSharedPref(
            SharedPreferenceConstants.prefDeviceBrand) ??
        "";
    String? mobileAppVersion = await SharedPreferencesUtil.getSharedPref(
            SharedPreferenceConstants.prefMobileAppVersion) ??
        "";
    bool? isPhysicalDevice = await SharedPreferencesUtil.getBoolSharedPref(
            SharedPreferenceConstants.prefIsPhysicalDevice) ??
        true;

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      /* Android */
      if (deviceModel.isNotEmpty &&
          deviceVersion.isNotEmpty &&
          deviceID.isNotEmpty &&
          deviceBrand.isNotEmpty &&
          mobileAppVersion.isNotEmpty) {
        PrintUtil()
            .printMsg('Running on SharedPref Values $deviceModel >>>>>> ');
        deviceInfoData['device_type'] = '1';

        deviceInfoData['device_model'] = deviceModel;
        deviceInfoData['device_version'] = deviceVersion;
        deviceInfoData['device_id'] = deviceID;
        deviceInfoData['device_brand'] = deviceBrand;

        deviceInfoData['is_physical_device'] = '$isPhysicalDevice';
        deviceInfoData['mobile_app_version'] =
            AppConfigConstants.appVersionAndroid;
        SharedPreferencesUtil.addSharedPref(
            SharedPreferenceConstants.prefMobileAppVersion,
            deviceInfoData['mobile_app_version']!);
        deviceInfoData['mobile_number'] = mob;
        deviceInfoData['secret_key'] = secKey;
        deviceInfoData['user_id'] = userID;
        deviceInfoData['user_type'] = userType;
        /* Time Zone */
        deviceInfoData['tz_name'] = DateTime.now().timeZoneName.toString();
        deviceInfoData['tz_offset'] = DateTime.now().timeZoneOffset.toString();
        /* Time Zone */
      } else {
        PrintUtil().printMsg('Running on ${androidInfo.model} >>>>>> ');
        deviceInfoData['device_type'] = '1';
        deviceInfoData['device_model'] = androidInfo.model;
        deviceInfoData['device_version'] = androidInfo.version.release;
        String? androidId = await const AndroidId().getId();
        deviceInfoData['device_id'] = androidId;
        deviceInfoData['device_brand'] = androidInfo.brand;
        deviceInfoData['build_type'] = '${AppConfigConstants.buildCategory}';
        deviceInfoData['is_physical_device'] =
            '${androidInfo.isPhysicalDevice}';
        deviceInfoData['mobile_app_version'] =
            AppConfigConstants.appVersionAndroid;
        /* Updating Shared Pref Value */
        SharedPreferencesUtil.addSharedPref('device_type', '1');
        SharedPreferencesUtil.addSharedPref(
            SharedPreferenceConstants.prefDeviceModel, androidInfo.model);
        SharedPreferencesUtil.addSharedPref(
            SharedPreferenceConstants.prefDeviceVersion,
            androidInfo.version.release);
        SharedPreferencesUtil.addSharedPref(
            SharedPreferenceConstants.prefDeviceID, '$androidId');
        SharedPreferencesUtil.addSharedPref(
            SharedPreferenceConstants.prefDeviceBrand, androidInfo.brand);
        SharedPreferencesUtil.addBoolSharedPref(
            'is_physical_device', androidInfo.isPhysicalDevice);
        SharedPreferencesUtil.addSharedPref(
            SharedPreferenceConstants.prefMobileAppVersion,
            deviceInfoData['mobile_app_version']!);
        deviceInfoData['mobile_number'] = mob;
        deviceInfoData['secret_key'] = secKey;
        deviceInfoData['user_id'] = userID;
        deviceInfoData['user_type'] = userType;
        /* Time Zone */
        deviceInfoData['tz_name'] = DateTime.now().timeZoneName.toString();
        deviceInfoData['tz_offset'] = DateTime.now().timeZoneOffset.toString();
        /* Time Zone */
      }
    } else {
      /* IOS */
      if (deviceModel.isNotEmpty &&
          deviceVersion.isNotEmpty &&
          deviceID.isNotEmpty &&
          mobileAppVersion.isNotEmpty) {
        PrintUtil()
            .printMsg('Running on SharedPref Values $deviceModel >>>>>> ');
        deviceInfoData['device_type'] = '2';
        deviceInfoData['device_model'] = deviceModel;
        deviceInfoData['device_version'] = deviceVersion;
        deviceInfoData['device_id'] = deviceID;
        deviceInfoData['device_brand'] = 'Apple';
        deviceInfoData['build_type'] = '${AppConfigConstants.buildCategory}';
        deviceInfoData['is_physical_device'] = '$isPhysicalDevice';
        deviceInfoData['mobile_app_version'] = AppConfigConstants.appVersioniOS;
        SharedPreferencesUtil.addSharedPref(
            SharedPreferenceConstants.prefMobileAppVersion,
            deviceInfoData['mobile_app_version']!);
        deviceInfoData['mobile_number'] = mob;
        deviceInfoData['secret_key'] = secKey;
        deviceInfoData['user_id'] = userID;
        deviceInfoData['user_type'] = userType;
        /* Time Zone */
        deviceInfoData['tz_name'] = DateTime.now().timeZoneName.toString();
        deviceInfoData['tz_offset'] = DateTime.now().timeZoneOffset.toString();
        /* Time Zone */
      } else {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        PrintUtil().printMsg('Running on ${iosInfo.utsname.machine}');
        deviceInfoData['device_type'] = '2';
        deviceInfoData['device_model'] = iosInfo.model;
        deviceInfoData['device_version'] = iosInfo.systemVersion;
        deviceInfoData['device_id'] = '${iosInfo.identifierForVendor}';
        deviceInfoData['device_brand'] = 'Apple';
        deviceInfoData['build_type'] = '${AppConfigConstants.buildCategory}';
        deviceInfoData['is_physical_device'] = '${iosInfo.isPhysicalDevice}';
        deviceInfoData['mobile_app_version'] = AppConfigConstants.appVersioniOS;
        /* Updating Shared Pref Value */
        SharedPreferencesUtil.addSharedPref(
            SharedPreferenceConstants.prefDeviceType, '2');
        SharedPreferencesUtil.addSharedPref(
            SharedPreferenceConstants.prefDeviceModel, iosInfo.model);
        SharedPreferencesUtil.addSharedPref(
            SharedPreferenceConstants.prefDeviceVersion, iosInfo.systemVersion);
        SharedPreferencesUtil.addSharedPref(
            SharedPreferenceConstants.prefDeviceID,
            '${iosInfo.identifierForVendor}');
        SharedPreferencesUtil.addSharedPref(
            SharedPreferenceConstants.prefDeviceBrand, 'Apple');
        SharedPreferencesUtil.addSharedPref(
            SharedPreferenceConstants.prefMobileAppVersion,
            deviceInfoData['mobile_app_version']!);
        deviceInfoData['mobile_number'] = mob;
        deviceInfoData['secret_key'] = secKey;
        deviceInfoData['user_id'] = userID;
        deviceInfoData['user_type'] = userType;
        /* Time Zone */
        deviceInfoData['tz_name'] = DateTime.now().timeZoneName.toString();
        deviceInfoData['tz_offset'] = DateTime.now().timeZoneOffset.toString();
        /* Time Zone */
      }
    }
    return deviceInfoData;
  }

  Future<Map<String, dynamic>> getDeviceInfo() async {
    Map<String, dynamic> paramData = {};
    if (deviceInfoData.isNotEmpty) {
      paramData.addAll(deviceInfoData);
      paramData['last_live'] = AppConfigConstants.lastLive;
      paramData['network_type'] = AppConfigConstants.connectivityType;
      if (AppConfigConstants.lastLive.isEmpty) {
        DateFormat dateFormat = DateFormat("yyyy-m-d HH:mm:ss");
        String curTime = dateFormat.format(DateTime.now());
        paramData['last_live'] = curTime;
      }
      return paramData;
    } else {
      deviceInfoData = await updateDeviceInfo();
      paramData.addAll(deviceInfoData);
      paramData['last_live'] = AppConfigConstants.lastLive;
      paramData['network_type'] = AppConfigConstants.connectivityType;
      if (AppConfigConstants.lastLive.isEmpty) {
        DateFormat dateFormat = DateFormat("yyyy-m-d HH:mm:ss");
        String curTime = dateFormat.format(DateTime.now());
        paramData['last_live'] = curTime;
      }
      return paramData;
    }
  }
}
