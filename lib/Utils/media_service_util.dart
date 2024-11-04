// import 'dart:io';

// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_ffreedom_app/ExternalServices/analytics_service.dart';
// import 'package:flutter_ffreedom_app/ResourceConstants/firebase_moengage_constants.dart';
// import 'package:flutter_ffreedom_app/ResourceConstants/routing_constants.dart';
// import 'package:flutter_ffreedom_app/ResourceConstants/shared_pref_constants.dart';
// import 'package:flutter_ffreedom_app/Routers/navigation_service.dart';
// import 'package:flutter_ffreedom_app/Utils/helper_util.dart';
// import 'package:flutter_ffreedom_app/Utils/permission_service_util.dart';
// import 'package:flutter_ffreedom_app/Utils/print_util.dart';
// import 'package:flutter_ffreedom_app/Utils/sharedpreferences_util.dart';
// import 'package:flutter_ffreedom_app/Utils/toast_util.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:hp_finance/Utils/helper_util.dart';
// import 'package:hp_finance/Utils/print_util.dart';
// import 'package:hp_finance/Utils/toast_util.dart';
// import 'package:light_compressor/light_compressor.dart';
// import 'package:permission_handler/permission_handler.dart';

// class MediaServiceUtil {
//   static RegExp regExpImg = RegExp(
//     r'.png|.jp|.heic',
//     caseSensitive: false,
//     multiLine: false,
//   );

//   static List<String>? allowedDocumentExt = [
//     'PDF',
//     'pdf',
//     // 'doc',
//     // 'docx',
//     // 'csv',
//     // 'gif',
//     // 'GIF',
//     // 'xls',
//     // 'xlsx',
//     // 'pptx',
//     // 'ppt',
//     // 'rtf',
//     // 'txt',
//   ];

//   // Record Video
//   static Future<String> recordVideo({
//     required int minDurationVideo,
//     required int maxDurationVideo,
//     required BuildContext context,
//   }) async {
//     // File videoFile;
//     String videoPath = "";

//     Map<String, dynamic> data = {};
//     data = {
//       "miniDuration": minDurationVideo,
//       "maxDuration": maxDurationVideo,
//     };
//     try {
//       String? video = await Navigator.pushNamed(
//         context,
//         RoutingConstants.routeCustomCamera,
//         arguments: {'data': data},
//       );
//       HelperUtil.changeStatusBarColor();
//       if (video != null) {
//         videoPath = video;
//       } else {
//         // ignore: use_build_context_synchronously
//         Navigator.pop(context);
//       }
//       return videoPath;
//     } catch (e) {
//       return videoPath;
//     }
//   }

//   static Future<List<PlatformFile>?>? pickVideoWithoutCompression(
//       {required BuildContext? context,
//       required int maxtime,
//       required String screenName}) async {
//     List<PlatformFile>? videoList = [];
//     try {
//       Map<Permission, PermissionStatus> permissionStatus;
//       bool isGrantedPermission = false;
//       if (Platform.isAndroid) {
//         List<String> tempPer = await SharedPreferencesUtil.getListSharedPref(
//                 SharedPreferenceConstants.perfPermissionShown) ??
//             [];
//         final androidInfo = await DeviceInfoPlugin().androidInfo;

//         if (androidInfo.version.sdkInt <= 32) {
//           bool denied = await Permission.storage.isGranted;
//           if (!tempPer.contains("2") && !denied) {
//             AnalyticsService().logFirebaseAnalyticsEvent(
//               actionName: FirebaseMoengageConstants.ffProDisShown,
//               actionProperty: {
//                 "pd_type": "storage",
//                 "source": screenName,
//               },
//             );
//             PermissionServiceUtil.popUpAlert(
//               type: 2,
//               onTap: null,
//               request: "",
//               onPrimaryBtnTap: () async {
//                 permissionStatus =
//                     await PermissionServiceUtil.permissionServices(
//                         permissionRequestList: [
//                       Permission.storage,
//                     ],
//                         type: 2,
//                         screenName: screenName);
//                 isGrantedPermission =
//                     (permissionStatus[Permission.storage]!.isGranted);
//                 if (isGrantedPermission) {
//                   FilePickerResult? result =
//                       await FilePicker.platform.pickFiles(
//                     type: FileType.video,
//                     allowCompression: true,
//                     allowMultiple: false,
//                   );
//                   videoList = result?.files;

//                   HelperUtil.changeStatusBarColor();
//                   return videoList;
//                 }
//               },
//             );
//           } else {
//             permissionStatus = await PermissionServiceUtil.permissionServices(
//                 permissionRequestList: [
//                   Permission.storage,
//                 ],
//                 type: 2,
//                 screenName: screenName);
//             isGrantedPermission =
//                 (permissionStatus[Permission.storage]!.isGranted);
//           }
//         } else {
//           bool denied = await Permission.videos.isGranted;

//           if (!tempPer.contains("2") && !denied) {
//             AnalyticsService().logFirebaseAnalyticsEvent(
//               actionName: FirebaseMoengageConstants.ffProDisShown,
//               actionProperty: {
//                 "pd_type": "storage",
//                 "source": screenName,
//               },
//             );
//             PermissionServiceUtil.popUpAlert(
//               type: 2,
//               onTap: null,
//               request: "",
//               onPrimaryBtnTap: () async {
//                 permissionStatus =
//                     await PermissionServiceUtil.permissionServices(
//                         permissionRequestList: [
//                       Permission.videos,
//                     ],
//                         type: 2,
//                         screenName: screenName);
//                 isGrantedPermission =
//                     (permissionStatus[Permission.videos]!.isGranted);
//                 if (isGrantedPermission) {
//                   FilePickerResult? result =
//                       await FilePicker.platform.pickFiles(
//                     type: FileType.video,
//                     allowCompression: true,
//                     allowMultiple: false,
//                   );
//                   videoList = result?.files;

//                   HelperUtil.changeStatusBarColor();
//                   return videoList;
//                 }
//               },
//             );
//           } else {
//             permissionStatus = await PermissionServiceUtil.permissionServices(
//                 permissionRequestList: [
//                   Permission.videos,
//                 ],
//                 type: 2,
//                 screenName: screenName);
//             isGrantedPermission =
//                 (permissionStatus[Permission.videos]!.isGranted);
//           }
//         }
//       } else {
//         permissionStatus = await PermissionServiceUtil.permissionServices(
//             permissionRequestList: [
//               Permission.photos,
//             ],
//             type: 2,
//             screenName: screenName);
//         isGrantedPermission = (permissionStatus[Permission.photos]!.isGranted);
//       }
//       if (isGrantedPermission) {
//         FilePickerResult? result = await FilePicker.platform.pickFiles(
//           type: FileType.video,
//           allowCompression: true,
//           allowMultiple: false,
//         );
//         videoList = result?.files;

//         HelperUtil.changeStatusBarColor();
//         return videoList;
//       }
//     } catch (e) {
//       return videoList;
//     }
//     return videoList;
//   }

//   static Future<List<File>> pickVideo({
//     required BuildContext? context,
//     required List<File> compressedVideoList,
//     required int maxtime,
//     required String screenName,
//   }) async {
//     try {
//       Map<Permission, PermissionStatus> permissionStatus;
//       bool isGrantedPermission = false;
//       if (Platform.isAndroid) {
//         List<String> tempPer = await SharedPreferencesUtil.getListSharedPref(
//                 SharedPreferenceConstants.perfPermissionShown) ??
//             [];
//         final androidInfo = await DeviceInfoPlugin().androidInfo;
//         if (androidInfo.version.sdkInt <= 32) {
//           bool denied = await Permission.photos.isGranted;
//           if (!tempPer.contains("2") && !denied) {
//             AnalyticsService().logFirebaseAnalyticsEvent(
//               actionName: FirebaseMoengageConstants.ffProDisShown,
//               actionProperty: {
//                 "pd_type": "storage",
//                 "source": screenName,
//               },
//             );
//             PermissionServiceUtil.popUpAlert(
//               type: 2,
//               onTap: null,
//               request: "",
//               onPrimaryBtnTap: () async {
//                 permissionStatus =
//                     await PermissionServiceUtil.permissionServices(
//                         permissionRequestList: [
//                       Permission.photos,
//                     ],
//                         type: 2,
//                         screenName: screenName);
//                 isGrantedPermission =
//                     (permissionStatus[Permission.photos]!.isGranted);
//                 if (isGrantedPermission) {
//                   compressedVideoList = [];
//                   List<PlatformFile>? videoList = [];
//                   FilePickerResult? result =
//                       await FilePicker.platform.pickFiles(
//                     type: FileType.video,
//                     allowCompression: true,
//                     allowMultiple: false,
//                   );
//                   videoList = result?.files;
//                   // videoList = await ImagesPicker?.pick(
//                   //   pickType: PickType.video,
//                   //   quality: 0.5,
//                   //   language: Language.System,
//                   //   maxTime: maxtime,
//                   //   cropOpt: CropOption(
//                   //     aspectRatio: const CropAspectRatio(1080, 1080),
//                   //   ),
//                   // );
//                   HelperUtil.changeStatusBarColor();
//                   if (videoList != null && videoList.isNotEmpty) {
//                     for (int i = 0; i < videoList.length; i++) {
//                       File? videoCompressedFile = await compressVideoFile(
//                           videoFile: File(videoList[i].path ?? ""));

//                       compressedVideoList.insert(
//                         0,
//                         videoCompressedFile!,
//                       );
//                     }
//                   }
//                   return compressedVideoList;
//                 }
//               },
//             );
//           } else {
//             permissionStatus = await PermissionServiceUtil.permissionServices(
//                 permissionRequestList: [
//                   Permission.photos,
//                 ],
//                 type: 2,
//                 screenName: screenName);
//             isGrantedPermission =
//                 (permissionStatus[Permission.photos]!.isGranted);
//           }
//         } else {
//           bool denied = await Permission.videos.isGranted;
//           if (!tempPer.contains("2") && !denied) {
//             AnalyticsService().logFirebaseAnalyticsEvent(
//               actionName: FirebaseMoengageConstants.ffProDisShown,
//               actionProperty: {
//                 "pd_type": "storage",
//                 "source": screenName,
//               },
//             );
//             PermissionServiceUtil.popUpAlert(
//               type: 2,
//               onTap: null,
//               request: "",
//               onPrimaryBtnTap: () async {
//                 permissionStatus =
//                     await PermissionServiceUtil.permissionServices(
//                         permissionRequestList: [
//                       Permission.videos,
//                     ],
//                         type: 2,
//                         screenName: screenName);
//                 isGrantedPermission =
//                     (permissionStatus[Permission.videos]!.isGranted);
//                 if (isGrantedPermission) {
//                   compressedVideoList = [];
//                   List<PlatformFile>? videoList = [];
//                   FilePickerResult? result =
//                       await FilePicker.platform.pickFiles(
//                     type: FileType.video,
//                     allowCompression: true,
//                     allowMultiple: false,
//                   );
//                   videoList = result?.files;
//                   // videoList = await ImagesPicker?.pick(
//                   //   pickType: PickType.video,
//                   //   quality: 0.5,
//                   //   language: Language.System,
//                   //   maxTime: maxtime,
//                   //   cropOpt: CropOption(
//                   //     aspectRatio: const CropAspectRatio(1080, 1080),
//                   //   ),
//                   // );
//                   HelperUtil.changeStatusBarColor();
//                   if (videoList != null && videoList.isNotEmpty) {
//                     for (int i = 0; i < videoList.length; i++) {
//                       File? videoCompressedFile = await compressVideoFile(
//                           videoFile: File(videoList[i].path ?? ""));

//                       compressedVideoList.insert(
//                         0,
//                         videoCompressedFile!,
//                       );
//                     }
//                   }
//                   return compressedVideoList;
//                 }
//               },
//             );
//           } else {
//             permissionStatus = await PermissionServiceUtil.permissionServices(
//                 permissionRequestList: [
//                   Permission.videos,
//                 ],
//                 type: 2,
//                 screenName: screenName);
//             isGrantedPermission =
//                 (permissionStatus[Permission.videos]!.isGranted);
//           }
//         }
//       } else {
//         permissionStatus = await PermissionServiceUtil.permissionServices(
//             permissionRequestList: [
//               Permission.photos,
//             ],
//             type: 2,
//             screenName: screenName);
//         isGrantedPermission = (permissionStatus[Permission.photos]!.isGranted);
//       }
//       if (isGrantedPermission) {
//         compressedVideoList = [];
//         List<PlatformFile>? videoList = [];
//         FilePickerResult? result = await FilePicker.platform.pickFiles(
//           type: FileType.video,
//           allowCompression: true,
//           allowMultiple: false,
//         );
//         videoList = result?.files;
//         // videoList = await ImagesPicker?.pick(
//         //   pickType: PickType.video,
//         //   quality: 0.5,
//         //   language: Language.System,
//         //   maxTime: maxtime,
//         //   cropOpt: CropOption(
//         //     aspectRatio: const CropAspectRatio(1080, 1080),
//         //   ),
//         // );
//         HelperUtil.changeStatusBarColor();
//         if (videoList != null && videoList.isNotEmpty) {
//           for (int i = 0; i < videoList.length; i++) {
//             File? videoCompressedFile = await compressVideoFile(
//                 videoFile: File(videoList[i].path ?? ""));

//             compressedVideoList.insert(
//               0,
//               videoCompressedFile!,
//             );
//           }
//         }
//         return compressedVideoList;
//       }
//     } catch (e) {
//       return compressedVideoList;
//     }
//     return compressedVideoList;
//   }

//   static compressVideoFile({required File? videoFile}) async {
//     late String desFile;
//     File? compressedFile;
//     if (videoFile == null) {
//       return;
//     }
//     desFile = await HelperUtil.destinationFile;
//     final dynamic response = await LightCompressor().compressVideo(
//         path: videoFile.path,
//         destinationPath: desFile,
//         videoQuality: VideoQuality.medium,
//         isMinBitrateCheckEnabled: false,
//         frameRate: 24 /* or ignore it */);
//     if (response is OnSuccess) {
//       compressedFile = File(response.destinationPath);
//     } else if (response is OnFailure) {
//       // failure message
//       PrintUtil().printMsg(response.message);
//     } else if (response is OnCancelled) {
//       PrintUtil().printMsg(response.isCancelled);
//     }
//     PrintUtil().printMsg(
//         "msg: $desFile || Or: ${videoFile.path} ||| Compress ${compressedFile?.path}  ");

//     return compressedFile;
//   }

//   /* Capture Picture */
//   static Future<List<File>> capturePhoto(
//       {required maxImagesCount,
//       required BuildContext? context,
//       required List<File> compressedPhotosList,
//       required int type, // 1: means  default, 2 : means only picture
//       required String screenName}) async {
//     try {
//       PrintUtil().printMsg("type       $type");
//       Map<Permission, PermissionStatus> permissionStatus;
//       bool isGrantedPermission = false;
//       permissionStatus = await PermissionServiceUtil.permissionServices(
//           permissionRequestList: [
//             Permission.camera,
//             if (type != 2) Permission.microphone,
//           ],
//           type: 5,
//           screenName: screenName);
//       isGrantedPermission = ((type != 2)
//           ? (permissionStatus[Permission.camera]!.isGranted &&
//               permissionStatus[Permission.microphone]!.isGranted)
//           : (permissionStatus[Permission.camera]!.isGranted));

//       if (isGrantedPermission) {
//         PrintUtil().printMsg("enter granted");
//         if (maxImagesCount == 1) {
//           compressedPhotosList = [];
//         }
//         if (compressedPhotosList.length != maxImagesCount) {
//           List photosList = [];
//           Map<String, dynamic> data = {};
//           data = {
//             "type": type,
//           };

//           var res = await Navigator.pushNamed(
//             context!,
//             RoutingConstants.routeCapturePhotoCamera,
//             arguments: {'data': data},
//           );

//           if (res != null) {
//             photosList.add(res);
//           }

//           HelperUtil.changeStatusBarColor();
//           if (photosList.isNotEmpty) {
//             for (int i = 0; i < photosList.length; i++) {
//               if (!regExpImg.hasMatch(photosList[i].split('/').last)) {
//                 // ignore: use_build_context_synchronously
//                 ToastUtil().showSnackBar(
//                     context: context,
//                     message: "Invalid file format",
//                     isError: true);
//               } else {
//                 PrintUtil().printMsg("photoCompressedFile: ${photosList[i]}");
//                 File? photoCompressedFile =
//                     await compressImage(File(photosList[i]));
//                 PrintUtil().printMsg(
//                     "photoCompressedFile: ${photoCompressedFile?.path}");
//                 compressedPhotosList.insert(
//                   0,
//                   photoCompressedFile!,
//                 );
//               }
//             }
//           }
//         }
//         return compressedPhotosList;
//       }
//     } catch (e) {
//       return compressedPhotosList;
//     }
//     return compressedPhotosList;
//   }

//   /* Pick Image from Gallery */
//   static Future<List<File>> pickPhotos({
//     required int maxImagesCount,
//     required BuildContext? context,
//     required List<File> compressedPhotosList,
//     required String invalidFormatErrorText,
//     required String screenName,
//   }) async {
//     try {
//       Map<Permission, PermissionStatus> permissionStatus;
//       bool isGrantedPermission = false;
//       final RegExp regExpImgFor = RegExp(r'\.(jpg|jpeg|png)$');

//       if (Platform.isAndroid) {
//         final androidInfo = await DeviceInfoPlugin().androidInfo;
//         if (androidInfo.version.sdkInt <= 32) {
//           permissionStatus = await PermissionServiceUtil.permissionServices(
//               permissionRequestList: [
//                 Permission.storage,
//               ],
//               type: 2,
//               screenName: screenName);
//           isGrantedPermission =
//               (permissionStatus[Permission.storage]!.isGranted);
//         } else {
//           permissionStatus = await PermissionServiceUtil.permissionServices(
//               permissionRequestList: [
//                 Permission.photos,
//               ],
//               type: 2,
//               screenName: screenName);
//           isGrantedPermission =
//               (permissionStatus[Permission.photos]!.isGranted);
//         }
//       } else {
//         permissionStatus = await PermissionServiceUtil.permissionServices(
//             permissionRequestList: [
//               Permission.photos,
//             ],
//             type: 2,
//             screenName: screenName);
//         isGrantedPermission = (permissionStatus[Permission.photos]!.isGranted);
//       }
//       if (isGrantedPermission) {
//         List<PlatformFile>? photosList = [];
//         FilePickerResult? picResult;
//         if (Platform.isAndroid) {
//           final androidInfo = await DeviceInfoPlugin().androidInfo;
//           (androidInfo.version.sdkInt <= 29)
//               ? picResult = await FilePicker.platform.pickFiles(
//                   type: FileType.custom,
//                   allowedExtensions: ['jpg', 'jpeg', 'png'],
//                   allowCompression: true,
//                   allowMultiple: false,
//                 )
//               : picResult = await FilePicker.platform.pickFiles(
//                   type: FileType.image,
//                   allowCompression: true,
//                   allowMultiple: false,
//                 );
//         } else {
//           picResult = await FilePicker.platform.pickFiles(
//             type: FileType.image,
//             allowCompression: true,
//             allowMultiple: false,
//           );
//         }

//         photosList = picResult?.files;
//         // await ImagesPicker?.pick(
//         //   count: (compressedPhotosList.isNotEmpty)
//         //       ? (maxImagesCount - compressedPhotosList.length)
//         //       : maxImagesCount,
//         //   pickType: PickType.image,
//         //   language: Language.System,
//         //   cropOpt: CropOption(
//         //     aspectRatio: const CropAspectRatio(1080, 1080),
//         //   ),
//         // );
//         HelperUtil.changeStatusBarColor();
//         if (photosList != null && photosList.isNotEmpty) {
//           for (int i = 0; i < photosList.length; i++) {
//             if (!regExpImgFor.hasMatch(photosList[i].path!.split('/').last)) {
//               // ignore: use_build_context_synchronously
//               ToastUtil().showSnackBar(
//                   // ignore: use_build_context_synchronously
//                   context: NavigationService.navigatorKey.currentContext,
//                   message: "Invalid image format!!!",
//                   isError: true);
//             } else {
//               File? photoCompressedFile =
//                   await compressImage(File(photosList[i].path ?? ""));
//               compressedPhotosList.insert(
//                 0,
//                 photoCompressedFile!,
//               );
//             }
//           }
//         }
//         return compressedPhotosList;
//       }
//     } catch (e) {
//       return compressedPhotosList;
//     }
//     return compressedPhotosList;
//   }

//   static Future<File?> compressImage(File file) async {
//     final filePath = file.absolute.path;
//     final lastIndex = filePath.lastIndexOf(RegExp(r'.png|.jp'));
//     final splitted = filePath.substring(0, (lastIndex));
//     final outPath = "${splitted}_out${filePath.substring(lastIndex)}";

//     if (lastIndex == filePath.lastIndexOf(RegExp(r'.png'))) {
//       final compressedImage = await FlutterImageCompress.compressAndGetFile(
//           filePath, outPath,
//           minWidth: 1000,
//           minHeight: 1000,
//           quality: 50,
//           format: CompressFormat.png);
//       return compressedImage;
//     } else {
//       final compressedImage = await FlutterImageCompress.compressAndGetFile(
//         filePath,
//         outPath,
//         minWidth: 1000,
//         minHeight: 1000,
//         quality: 50,
//       );
//       return compressedImage;
//     }
//   }

//   static Future<Map<String?, String?>?> pickDocument(
//       {required BuildContext context, required String screenName}) async {
//     // Map<Permission, PermissionStatus> permissionStatus =
//     //     await PermissionServiceUtil.permissionServices(permissionRequestList: [
//     //   Permission.storage,
//     // ]);
//     Map<Permission, PermissionStatus> permissionStatus;
//     bool isGrantedPermission = false;
//     if (Platform.isAndroid) {
//       final androidInfo = await DeviceInfoPlugin().androidInfo;
//       if (androidInfo.version.sdkInt <= 32) {
//         permissionStatus = await PermissionServiceUtil.permissionServices(
//             permissionRequestList: [
//               Permission.storage,
//             ],
//             type: 2,
//             screenName: screenName);
//         isGrantedPermission = (permissionStatus[Permission.storage]!.isGranted);
//       } else {
//         isGrantedPermission = true;
//         // permissionStatus = await PermissionServiceUtil.permissionServices(
//         //     permissionRequestList: [
//         //       Permission.manageExternalStorage,
//         //     ]);
//         // isGrantedPermission =
//         //     (permissionStatus[Permission.manageExternalStorage]!.isGranted);
//       }
//     } else {
//       permissionStatus = await PermissionServiceUtil.permissionServices(
//           permissionRequestList: [
//             Permission.photos,
//           ],
//           type: 2,
//           screenName: screenName);
//       isGrantedPermission = (permissionStatus[Permission.photos]!.isGranted);
//     }
//     Map<String?, String?> result = {
//       "docPath": "",
//       "fileNameWithExtension": "",
//       "fileNameWithoutExtension": "",
//       "fileExtension": "",
//     };
//     if (isGrantedPermission) {
//       String? path;

//       try {
//         FilePickerResult? docResult = await FilePicker.platform.pickFiles(
//           type: FileType.custom,
//           allowMultiple: false,
//           allowedExtensions: allowedDocumentExt,
//         );

//         path = docResult?.paths[0].toString();
//         HelperUtil.changeStatusBarColor();
//         if (path != null) {
//           result["docPath"] = path.toString();

//           result["fileNameWithExtension"] =
//               HelperUtil.getFileNameWithExtension(filePath: result["docPath"]!);
//           result["fileNameWithoutExtension"] =
//               HelperUtil.getFileNameWithoutExtension(
//                   filePath: result["docPath"]!);
//           result["fileExtension"] =
//               HelperUtil.getFileExtension(filePath: result["docPath"]!);

//           return result;
//         } else {
//           return {};
//         }
//       } catch (e) {
//         PrintUtil().printMsg("Document Picker ERROR: $e");
//         // ignore: use_build_context_synchronously
//         ToastUtil().showSnackBar(
//             context: context, message: "Invalid Format", isError: true);
//         return {};
//       }
//     }
//     return {};
//   }
// }

// /* Example
// List compressedPhotosList = [];
// compressedPhotosList = await PickImageServiceUtil.pickPhotos(
//                     maxImagesCount: 3,
//                     context: context,
//                     compressedPhotosList: compressedPhotosList);
//  */
