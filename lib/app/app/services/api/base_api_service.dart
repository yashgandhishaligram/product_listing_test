import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../data/models/base_response_entity.dart';

class BaseApiService extends GetxService {
  static String baseUrl = "https://dummyjson.com";
  static Map<String, dynamic> commonAPIHeader = {
    "accept": "text/plain",
    "Content-Type": "application/json"
  };

  Future<GenericResponseEntity> baseGetAPICall(
      {bool isAuthToken = true,
        Map<String, String>? headers,
        required String path}) async {
    try {
      if (kDebugMode) {
        print("GET $baseUrl/$path");
      }
      final dio = Dio();

      if (isAuthToken) {
        const authToken = "";
        print("authToken :$authToken");
        commonAPIHeader.addAll({"Authorization": "Bearer $authToken"});
      }
      // if (headers != null) {
      //   commonAPIHeader.addAll(headers);
      // }
      dio.options.headers = commonAPIHeader;
      final response = await dio.get('$baseUrl/$path');
      if (kDebugMode) {
        print(
            "GET $baseUrl/$path: ${response.statusCode} : ${response.data}");
        print("Header $commonAPIHeader");
      }
      return GenericResponseEntity(
          data: response.data,
          message: response.data["message"],
          statusCode: response.statusCode,
          success: (response.statusCode == 200 || response.statusCode == 201));
    } catch (e) {
      e.printError();
      return GenericResponseEntity(
          message: "Unknown Error While Connecting to Server.",
          statusCode: 2000,
          success: false);
    }
  }

  // Future<GenericResponseEntity> basePostAPICall(
  //     {bool isAuthToken = true,
  //       Map<String, String>? headers,
  //       required String path,
  //       dynamic data}) async {
  //   try {
  //     if (kDebugMode) {
  //       print("Post $baseUrl/$path");
  //     }
  //     final dio = Dio();
  //
  //     if (isAuthToken) {
  //       final authToken = GetStorageHelper().getAppToken();
  //       print("authToken :$authToken");
  //       commonAPIHeader.addAll({"Authorization": "Bearer $authToken"});
  //     }
  //     // if (headers != null) {
  //     //   commonAPIHeader.addAll(headers);
  //     // }
  //     if (kDebugMode) {
  //       print("header $commonAPIHeader");
  //     }
  //     dio.options.headers = commonAPIHeader;
  //     final response = await dio.post('$baseUrl/$path', data: data);
  //     if (kDebugMode) {
  //       print("Post: ${response.statusCode} : ${response.data}");
  //     }
  //     return GenericResponseEntity(
  //         data: response.data,
  //         message: response.data["message"],
  //         statusCode: response.statusCode,
  //         success: (response.statusCode == 200 || response.statusCode == 201));
  //   } on DioError catch (exception) {
  //     exception.printError();
  //     final response = exception.response;
  //     return GenericResponseEntity(
  //         data: response?.data,
  //         message: response?.data["message"],
  //         statusCode: response?.statusCode,
  //         success: false);
  //   } catch (e) {
  //     e.printError();
  //     return GenericResponseEntity(
  //         message: "Unknown Error While Connecting to Server.",
  //         statusCode: 2000,
  //         success: false);
  //   }
  // }
  //
  // Future<GenericResponseEntity> baseDeleteAPICall(
  //     {bool isAuthToken = true,
  //       bool isPatientBound = false,
  //       Map<String, String>? headers,
  //       required String path,
  //       dynamic data}) async {
  //   try {
  //     if (kDebugMode) {
  //       print("Delete $baseUrl/$path");
  //     }
  //     final dio = Dio();
  //
  //     if (isAuthToken) {
  //       final authToken = GetStorageHelper().getAppToken();
  //       print("authToken :$authToken");
  //       commonAPIHeader.addAll({"Authorization": "Bearer $authToken"});
  //     }
  //     // if (headers != null) {
  //     //   commonAPIHeader.addAll(headers);
  //     // }
  //     if (kDebugMode) {
  //       print("header $commonAPIHeader");
  //     }
  //     dio.options.headers = commonAPIHeader;
  //     final response = await dio.delete('$baseUrl/$path', data: data);
  //     if (kDebugMode) {
  //       print("Delete: ${response.statusCode} : ${response.data}");
  //     }
  //     return GenericResponseEntity(
  //         data: response.data,
  //         message: response.data["message"],
  //         statusCode: response.statusCode,
  //         success: (response.statusCode == 200 || response.statusCode == 201));
  //   } on DioError catch (exception) {
  //     exception.printError();
  //     final response = exception.response;
  //     return GenericResponseEntity(
  //         data: response?.data,
  //         message: response?.data["message"],
  //         statusCode: response?.statusCode,
  //         success: false);
  //   } catch (e) {
  //     e.printError();
  //     return GenericResponseEntity(
  //         message: "Unknown Error While Connecting to Server.",
  //         statusCode: 2000,
  //         success: false);
  //   }
  // }
  //
  // Future<GenericResponseEntity> baseUpdateAPICall(
  //     {bool isAuthToken = true,
  //       bool isPatientBound = false,
  //       Map<String, String>? headers,
  //       required String path,
  //       dynamic data}) async {
  //   try {
  //     if (kDebugMode) {
  //       print("Update $baseUrl/$path");
  //     }
  //     final dio = Dio();
  //
  //     if (isAuthToken) {
  //       final authToken = GetStorageHelper().getAppToken();
  //       print("authToken :$authToken");
  //       commonAPIHeader.addAll({"Authorization": "Bearer $authToken"});
  //     }
  //     // if (isPatientBound) {
  //     //   commonAPIHeader.addAll({"patientId": appStateService.getPatient().id!});
  //     // }
  //     // if (headers != null) {
  //     //   commonAPIHeader.addAll(headers);
  //     // }
  //     if (kDebugMode) {
  //       print("header $commonAPIHeader");
  //     }
  //     dio.options.headers = commonAPIHeader;
  //     final response = await dio.put('$baseUrl/$path', data: data);
  //     if (kDebugMode) {
  //       print("Update: ${response.statusCode} : ${response.data}");
  //     }
  //     return GenericResponseEntity(
  //         data: response.data,
  //         message: response.data["message"],
  //         statusCode: response.statusCode,
  //         success: (response.statusCode == 200 || response.statusCode == 201));
  //   } on DioError catch (exception) {
  //     exception.printError();
  //     final response = exception.response;
  //     return GenericResponseEntity(
  //         data: response?.data,
  //         message: response?.data["message"],
  //         statusCode: response?.statusCode,
  //         success: false);
  //   } catch (e) {
  //     e.printError();
  //     return GenericResponseEntity(
  //         message: "Unknown Error While Connecting to Server.",
  //         statusCode: 2000,
  //         success: false);
  //   }
  // }
}