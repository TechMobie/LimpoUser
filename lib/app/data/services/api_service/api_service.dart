// import 'dart:convert';
// import 'dart:io';
import 'package:get/get.dart';
import 'package:linpo_user/app/routes/app_pages.dart';
//import 'package:get_storage/get_storage.dart';
import 'package:linpo_user/helper/utils/pref_utils.dart';
// import 'package:http/http.dart' as http;
// import 'package:http/io_client.dart';


class ApiMethodType {
  static const String post = "POST";
  static const String patch = "PATCH";
  static const String get = "GET";
  static const String put = "PUT";
  static const String delete = "DELETE";
}

// bool isInternetAvailable = false;

class ApiService {
  static Future getRequest(
    String endpoint, {
    Object? query,
  }) async {
    return await ApiServiceMethods()
        .makeApiCall(endpoint, ApiMethodType.get, params: query);
  }

  static Future postRequest(
    String endpoint, {
    Object? body,
  }) async {
    return await ApiServiceMethods()
        .makeApiCall(endpoint, ApiMethodType.post, params: body);
  }

  static Future putRequest(
    String endpoint, {
    Object? body,
  }) async {
    return await ApiServiceMethods()
        .makeApiCall(endpoint, ApiMethodType.put, params: body);
  }

  static Future deleteRequest(
    String endpoint, {
    Object? query,
  }) async {
    return await ApiServiceMethods()
        .makeApiCall(endpoint, ApiMethodType.delete, params: query);
  }
}

class ApiServiceMethods extends GetConnect {
  Future getRequest(String endpoint, {Object? query}) async {
    return await makeApiCall(endpoint, ApiMethodType.get, params: query);
  }

  Future postRequest(String endpoint, {Object? body}) async {
    return await makeApiCall(endpoint, ApiMethodType.post, params: body);
  }

  Future putRequest(String endpoint, {Object? body}) async {
    return await makeApiCall(endpoint, ApiMethodType.put, params: body);
  }

  Future deleteRequest(String endpoint, {Object? query}) async {
    return await makeApiCall(endpoint, ApiMethodType.delete, params: query);
  }

  Future makeApiCall(
    String baseUrl,
    String method, {
    Object? params,
    Map<String, dynamic>? headers,
  }) async {
    //For charles proxy
    Response? response;
    // String proxy = '192.168.29.142:8888';
    // HttpClient httpClient = HttpClient();
    // httpClient.findProxy = (uri) {
    //   return "PROXY $proxy;";
    // };

    //WITH PROXY
    // IOClient myClient = IOClient(httpClient);

    //WITHOUT PROXY
    // IOClient myClient = IOClient();

    // HEADER
    Map<String, String> commonHeader = <String, String>{};

    if (PrefUtils.getInstance.isUserLogin()) {
      commonHeader['token'] = PrefUtils.getInstance.readData(
        PrefUtils.getInstance.accessToken,
      );
      commonHeader['Content-Type'] = "application/json";
      commonHeader['Accept'] = "application/json";
    }

    if (method == ApiMethodType.post) {
      response = await post(
        baseUrl,
        params,
        headers: commonHeader,
      );
    } else if (method == ApiMethodType.get) {
      response = await get(
        baseUrl, headers: commonHeader,
        // query: params,
      );
    } else if (method == ApiMethodType.put) {
      response = await put(
        baseUrl,
        params,
        headers: commonHeader,
      );
    } else if (method == ApiMethodType.delete) {
      response = await delete(
        baseUrl,
        headers: commonHeader,
      );
    }
    print("url-->$baseUrl");
    print("Request-->$params");
    print("headers-->$commonHeader");
    bool success = false;
    var decodedResponse = response!.body;

    // int statuscode = decodedResponse['code'];
    if (response.statusCode == 200) {
      print("Response-->$response");

      success = decodedResponse['success'] ?? false;
      if (success == true) {
        return response.body;
      } else if (decodedResponse['error'] == "Login Expired") {
        PrefUtils.getInstance.clearLocalStorage();

        Get.offAllNamed(Routes.signIn);
      } else {
        return response.body;
      }
    }



  }
}
