// ignore_for_file: body_might_complete_normally_catch_error

import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:hp_finance/Constants/routing_constants.dart';
import 'package:hp_finance/Constants/sharedpreference_constants.dart';
import 'package:hp_finance/Routing/navigation_service.dart';
import 'package:hp_finance/Utils/clear_user_data.dart';
import 'package:hp_finance/Utils/print_util.dart';
import 'package:hp_finance/Utils/sharedpreferences_util.dart';
import 'package:http/http.dart' as http;

class Network {
  PrintUtil printUtil = PrintUtil();

  /* Singleton Class */
  static final Network _networkSingleton = Network._internal();
  Network._internal();
  factory Network() => _networkSingleton;

  /* Json Decoder */
  final JsonDecoder _decoder = const JsonDecoder();
  final dio = Dio();

  BaseOptions options = BaseOptions(
    validateStatus: (val) {
      return (val == 200 || val == 401);
    },
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  );

  /* Get Http Call */
  Future<dynamic>? get(int apiTimeout, String url) async {
    try {
      dio.options = options;

      Response response = await dio.get(url);
      final int statusCode = response.statusCode ?? 401;

      printUtil.printMsg("<<<  Method GET  >>>");
      printUtil.printMsg("<<< API Call Start to $url >>");
      printUtil.printMsg("<<< API Status Code $statusCode >>>");
      printUtil.printMsg("<<< Response >>> ");
      printUtil.printMsg(response.data);
      final Map<String, dynamic> res = _decoder.convert(response.data);
      printUtil.printMsg("<<< API Call End >>>");
      if (res['logout'] != null && res['logout'] == true) {
        _clearSession("");
        return {"status": false, "logout": true};
      } else {
        return res;
      }
    } on DioException catch (e) {
      String erMessage = e.error.toString();
      String erType = "Other";
      String erStatusCode = e.response?.statusCode.toString() ?? "";
      if (e.type == DioExceptionType.badResponse) {
        erMessage = e.message ?? "";
        erType = "BadResponse";
      } else if (e.type == DioExceptionType.connectionTimeout) {
        erMessage = e.message ?? "";
        erType = "ConnectionTimeOut";
      } else if (e.type == DioExceptionType.receiveTimeout) {
        erMessage = e.message ?? "";
        erType = "ReceiveTimeOut";
      } else if (e.type == DioExceptionType.badCertificate) {
        erMessage = e.message ?? "";
        erType = "BadCertificate";
      } else if (e.type == DioExceptionType.connectionError) {
        erMessage = e.message ?? "";
        erType = "ConnectionError";
      }
      _triggerAPIErrorLog(
        apiName: url,
        errorMessage: erMessage,
        errorType: erType,
        postData: "",
        errorStatusCode: erStatusCode,
      );
      return {"status": false, "logout": false};
    }
  }

  /* Post Http Call */
  Future<dynamic> post(int apiTimeout, String url, {body}) async {
    try {
      dio.options = options;

      FormData formRequest = FormData.fromMap(body);

      Response response = await dio.post(
        url,
        data: formRequest,
      );
      final int statusCode = response.statusCode ?? 401;

      printUtil.printMsg("<<<  Method POST  >>>");
      printUtil.printMsg("<<< API Call Start to $url >>");
      printUtil.printMsg("<<< Request >>>");
      printUtil.printMsg(body.toString());
      printUtil.printMsg("<<< API Status Code $statusCode >>>");
      printUtil.printMsg("<<< Response >>>");
      printUtil.printMsg(response.data);
      try {
        final Map<String, dynamic> res = _decoder.convert(response.data);
        printUtil.printMsg("<<< API Call End >>>");
        if (res['logout'] != null && res['logout'] == true) {
          _clearSession("");
          return {"status": false, "logout": true};
        } else {
          return res;
        }
      } catch (e) {
        PrintUtil().printMsg("NTE $e");
        return {"status": false, "logout": false};
      }
    } on DioException catch (e) {
      String erMessage = e.error.toString();
      String erType = "Other";
      String erStatusCode = e.response?.statusCode.toString() ?? "";
      if (e.type == DioExceptionType.badResponse) {
        erMessage = e.message ?? "";
        erType = "BadResponse";
      } else if (e.type == DioExceptionType.connectionTimeout) {
        erMessage = e.message ?? "";
        erType = "ConnectionTimeOut";
      } else if (e.type == DioExceptionType.receiveTimeout) {
        erMessage = e.message ?? "";
        erType = "ReceiveTimeOut";
      } else if (e.type == DioExceptionType.badCertificate) {
        erMessage = e.message ?? "";
        erType = "BadCertificate";
      } else if (e.type == DioExceptionType.connectionError) {
        erMessage = e.message ?? "";
        erType = "ConnectionError";
      }
      _triggerAPIErrorLog(
        apiName: url,
        errorMessage: erMessage,
        errorType: erType,
        postData: body,
        errorStatusCode: erStatusCode,
      );
      return {"status": false, "logout": false};
    }
  }

  /* Get Http Call to check internet connectivity */
  Future<bool> checkNetworkConnection(int apiTimeout, String url) async {
    try {
      dio.options = options;

      Response response = await dio.get(
        url,
      );
      final int statusCode = response.statusCode ?? 401;
      printUtil.printMsg("<<<  Method GET Internet Status>>>");
      printUtil.printMsg("<<< API Call Start to $url >>");
      printUtil.printMsg("<<< API Status Code $statusCode >>>");
      printUtil.printMsg("<<< Response >>> ");
      printUtil.printMsg(response.data);
      printUtil.printMsg("<<< API Call End >>>");
      if (statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      String erMessage = e.error.toString();
      String erType = "Other";
      String erStatusCode = e.response?.statusCode.toString() ?? "";
      if (e.type == DioExceptionType.badResponse) {
        erMessage = e.message ?? "";
        erType = "BadResponse";
      } else if (e.type == DioExceptionType.connectionTimeout) {
        erMessage = e.message ?? "";
        erType = "ConnectionTimeOut";
      } else if (e.type == DioExceptionType.receiveTimeout) {
        erMessage = e.message ?? "";
        erType = "ReceiveTimeOut";
      } else if (e.type == DioExceptionType.badCertificate) {
        erMessage = e.message ?? "";
        erType = "BadCertificate";
      } else if (e.type == DioExceptionType.connectionError) {
        erMessage = e.message ?? "";
        erType = "ConnectionError";
      }
      _triggerAPIErrorLog(
        apiName: url,
        errorMessage: erMessage,
        errorType: erType,
        postData: "",
        errorStatusCode: erStatusCode,
      );
      return false;
    }
  }

  /* Post with Retry */
  Future<dynamic> postRetry(int apiTimeout, String url, {body}) async {
    int attemptedRetry = 0;
    try {
      final dioClientRetry = Dio();
      dioClientRetry.options = options;

      dioClientRetry.interceptors.add(
        RetryInterceptor(
          dio: dioClientRetry,
          logPrint: (val) {
            printUtil.printMsg("<<<  Method POST RETRY LOG >>>");
            printUtil.printMsg("<<< API Call Start to $url >>");
            printUtil.printMsg("<<< Request >>>");
            printUtil.printMsg(body.toString());
            attemptedRetry++;
          },
          retries: 3,
          retryDelays: const [
            Duration(seconds: 1),
            Duration(seconds: 2),
            Duration(seconds: 3),
          ],
        ),
      );

      FormData formRequest = FormData.fromMap(body);

      printUtil.printMsg("<<<  Method POST RETRY >>>");
      printUtil.printMsg("<<< API Call Start to $url >>");
      printUtil.printMsg("<<< Request >>>");
      printUtil.printMsg(body.toString());

      Response response = await dioClientRetry.post(url, data: formRequest);
      final int statusCode = response.statusCode ?? 401;
      printUtil.printMsg("<<< API RETRY Status Code $statusCode >>>");
      printUtil.printMsg("<<< Response RETRY >>>");
      printUtil.printMsg(response.data);
      final Map<String, dynamic> res = _decoder.convert(response.data);
      printUtil.printMsg("<<< API RETRY Call End >>>");
      if (res['logout'] != null && res['logout'] == true) {
        _clearSession("");
        return {"status": false, "logout": true};
      } else {
        return res;
      }
    } on DioException catch (e) {
      print("Error: ${e.toString()}");
      String erMessage = e.error.toString();
      String erType = "Other";
      String erStatusCode = e.response?.statusCode.toString() ?? "";
      if (e.type == DioExceptionType.badResponse) {
        erMessage = e.message ?? "";
        erType = "BadResponse";
      } else if (e.type == DioExceptionType.connectionTimeout) {
        erMessage = e.message ?? "";
        erType = "ConnectionTimeOut";
      } else if (e.type == DioExceptionType.receiveTimeout) {
        erMessage = e.message ?? "";
        erType = "ReceiveTimeOut";
      } else if (e.type == DioExceptionType.badCertificate) {
        erMessage = e.message ?? "";
        erType = "BadCertificate";
      } else if (e.type == DioExceptionType.connectionError) {
        erMessage = e.message ?? "";
        erType = "ConnectionError";
      }
      _triggerAPIErrorLog(
        apiName: url,
        errorMessage: erMessage,
        errorType: erType,
        postData: body,
        errorStatusCode: erStatusCode,
      );
      return {"status": false, "logout": false};
    }
  }

  /* Post Http Call Streaming */
  Future<dynamic> postStream(int apiTimeout, String url, {body}) async {
    try {
      dio.options = options;
      FormData formRequest = FormData.fromMap(body);
      dio.post(
        url,
        data: formRequest,
      );
      printUtil.printMsg("<<<  Method POST Stream  >>>");
      printUtil.printMsg("<<< API Call Start to $url >>");
      printUtil.printMsg("<<< Request >>>");
      printUtil.printMsg(body.toString());

      return {"status": true, "logout": false};
    } on DioException {
      return {"status": true, "logout": false};
    }
  }

  _triggerAPIErrorLog({
    required String errorType,
    required String errorMessage,
    required String apiName,
    required postData,
    required String errorStatusCode,
  }) {}

  _clearSession(String msg) async {
    bool isCleared = await clearUserData();
    if (isCleared) {
      /* Logout API */
      Map<String, dynamic> data = {};
      data = {
        "msg": msg,
      };

      NavigationService.navigatePRN(
        RoutingConstants.routeSessionExpired,
        {
          "data": data,
        },
      );
    }
  }

  Future<dynamic> httpPost(int apiTimeout, String url, {body}) async {
    try {
      // Logging the start of the API call
      printUtil.printMsg("<<< Method POST >>>");
      printUtil.printMsg("<<< API Call Start to $url >>>");
      printUtil.printMsg("<<< Request >>>");
      printUtil.printMsg(body.toString());

      String? secKey = await SharedPreferencesUtil.getSharedPref(
              SharedPreferenceConstants.prefSecretKey) ??
          "";

      // Set the request headers and make the POST request
      final response = await http
          .post(
            Uri.parse(url),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $secKey',
            },
            body: jsonEncode(body),
          )
          .timeout(Duration(seconds: apiTimeout)); // Applying timeout

      final int statusCode = response.statusCode;

      // Logging the response status
      printUtil.printMsg("<<< API Status Code $statusCode >>>");

      // Logging the raw response
      printUtil.printMsg("<<< Response >>>");
      printUtil.printMsg(response.body);

      // If the status code is not 200, return the predefined response
      if (statusCode != 200) {
        final Map<String, dynamic> res = jsonDecode(response.body);
        printUtil.printMsg(
            "<<< Response ERROR: $statusCode => ${response.body} >>>");
        printUtil.printMsg({
          "status": false,
          "logout": false,
          "message": "Something went wrong. Please try again"
        });
        return res;
        // {
        //   "status": false,
        //   "logout": false,
        //   "message": "Something went wrong. Please try again"
        // };
      }

      // Handle the response
      try {
        final Map<String, dynamic> res = jsonDecode(response.body);
        printUtil.printMsg("<<< API Call End >>>");

        // Check for logout flag in the response
        if (res['logout'] != null && res['logout'] == true) {
          _clearSession("");
          return {
            "status": false,
            "logout": true,
            "message": "Something went wrong. Please try again"
          };
        } else {
          return res;
        }
      } catch (e) {
        printUtil.printMsg("Error parsing response: $e");
        return {
          "status": false,
          "logout": false,
          "message": "Something went wrong. Please try again"
        };
      }
    } catch (e) {
      String erMessage = e.toString();
      String erType = "Other";
      String erStatusCode = "";

      // Handling different types of exceptions
      if (e is http.ClientException) {
        erMessage = e.message;
        erType = "ClientException";
      } else if (e is TimeoutException) {
        erMessage = "Connection timeout";
        erType = "Timeout";
      }

      // Logging the error
      printUtil.printMsg("<<< Error: $erMessage >>>");

      _triggerAPIErrorLog(
        apiName: url,
        errorMessage: erMessage,
        errorType: erType,
        postData: body,
        errorStatusCode: erStatusCode,
      );

      return {
        "status": false,
        "logout": false,
        "message": "Something went wrong. Please try again"
      };
    }
  }

  Future<dynamic> httpGet(int apiTimeout, String url, {body}) async {
    try {
      // Logging the start of the API call
      printUtil.printMsg("<<< Method POST >>>");
      printUtil.printMsg("<<< API Call Start to $url >>>");
      printUtil.printMsg("<<< Request >>>");
      printUtil.printMsg(body.toString());

      String? secKey = await SharedPreferencesUtil.getSharedPref(
              SharedPreferenceConstants.prefSecretKey) ??
          "";

      // Set the request headers and make the POST request
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $secKey',
        },
        // body: jsonEncode(body),
      ).timeout(Duration(seconds: apiTimeout)); // Applying timeout

      final int statusCode = response.statusCode;

      // Logging the response status
      printUtil.printMsg("<<< API Status Code $statusCode >>>");

      // Logging the raw response
      printUtil.printMsg("<<< Response >>>");
      printUtil.printMsg(response.body);

      // If the status code is not 200, return the predefined response
      if (statusCode != 200) {
        final Map<String, dynamic> res = jsonDecode(response.body);
        printUtil.printMsg(
            "<<< Response ERROR: $statusCode => ${response.body} >>>");
        printUtil.printMsg({
          "status": false,
          "logout": false,
          "message": "Something went wrong. Please try again"
        });
        return res;
        // {
        //   "status": false,
        //   "logout": false,
        //   "message": "Something went wrong. Please try again"
        // };
      }

      // Handle the response
      try {
        final Map<String, dynamic> res = jsonDecode(response.body);
        printUtil.printMsg("<<< API Call End >>>");

        // Check for logout flag in the response
        if (res['logout'] != null && res['logout'] == true) {
          _clearSession("");
          return {
            "status": false,
            "logout": true,
            "message": "Something went wrong. Please try again"
          };
        } else {
          return res;
        }
      } catch (e) {
        printUtil.printMsg("Error parsing response: $e");
        return {
          "status": false,
          "logout": false,
          "message": "Something went wrong. Please try again"
        };
      }
    } catch (e) {
      String erMessage = e.toString();
      String erType = "Other";
      String erStatusCode = "";

      // Handling different types of exceptions
      if (e is http.ClientException) {
        erMessage = e.message;
        erType = "ClientException";
      } else if (e is TimeoutException) {
        erMessage = "Connection timeout";
        erType = "Timeout";
      }

      // Logging the error
      printUtil.printMsg("<<< Error: $erMessage >>>");

      _triggerAPIErrorLog(
        apiName: url,
        errorMessage: erMessage,
        errorType: erType,
        postData: body,
        errorStatusCode: erStatusCode,
      );

      return {
        "status": false,
        "logout": false,
        "message": "Something went wrong. Please try again"
      };
    }
  }

  Future<dynamic> httpPut(int apiTimeout, String url, {body}) async {
    try {
      // Logging the start of the API call
      printUtil.printMsg("<<< Method POST >>>");
      printUtil.printMsg("<<< API Call Start to $url >>>");
      printUtil.printMsg("<<< Request >>>");
      printUtil.printMsg(body.toString());

      String? secKey = await SharedPreferencesUtil.getSharedPref(
              SharedPreferenceConstants.prefSecretKey) ??
          "";

      // Set the request headers and make the POST request
      final response = await http
          .put(
            Uri.parse(url),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $secKey',
            },
            body: jsonEncode(body),
          )
          .timeout(Duration(seconds: apiTimeout)); // Applying timeout

      final int statusCode = response.statusCode;

      // Logging the response status
      printUtil.printMsg("<<< API Status Code $statusCode >>>");

      // Logging the raw response
      printUtil.printMsg("<<< Response >>>");
      printUtil.printMsg(response.body);

      // If the status code is not 200, return the predefined response
      if (statusCode != 200) {
        final Map<String, dynamic> res = jsonDecode(response.body);
        printUtil.printMsg(
            "<<< Response ERROR: $statusCode => ${response.body} >>>");
        printUtil.printMsg({
          "status": false,
          "logout": false,
          "message": "Something went wrong. Please try again"
        });
        return res;
        // {
        //   "status": false,
        //   "logout": false,
        //   "message": "Something went wrong. Please try again"
        // };
      }

      // Handle the response
      try {
        final Map<String, dynamic> res = jsonDecode(response.body);
        printUtil.printMsg("<<< API Call End >>>");

        // Check for logout flag in the response
        if (res['logout'] != null && res['logout'] == true) {
          _clearSession("");
          return {
            "status": false,
            "logout": true,
            "message": "Something went wrong. Please try again"
          };
        } else {
          return res;
        }
      } catch (e) {
        printUtil.printMsg("Error parsing response: $e");
        return {
          "status": false,
          "logout": false,
          "message": "Something went wrong. Please try again"
        };
      }
    } catch (e) {
      String erMessage = e.toString();
      String erType = "Other";
      String erStatusCode = "";

      // Handling different types of exceptions
      if (e is http.ClientException) {
        erMessage = e.message;
        erType = "ClientException";
      } else if (e is TimeoutException) {
        erMessage = "Connection timeout";
        erType = "Timeout";
      }

      // Logging the error
      printUtil.printMsg("<<< Error: $erMessage >>>");

      _triggerAPIErrorLog(
        apiName: url,
        errorMessage: erMessage,
        errorType: erType,
        postData: body,
        errorStatusCode: erStatusCode,
      );

      return {
        "status": false,
        "logout": false,
        "message": "Something went wrong. Please try again"
      };
    }
  }
}
