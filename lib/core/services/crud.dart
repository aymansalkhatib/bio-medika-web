import 'dart:convert';
 import 'package:bio_medika_web/models/image_upload.dart';
import 'package:http/http.dart' as http;
import 'package:bio_medika_web/core/helpers/handler_response.dart';
import 'package:bio_medika_web/models/response_data.dart';

class Crud {
  Future<ResponseData> postData({
    required String linkUrl,
    Map data = const {},
    bool token = false,
  }) async {
    return handleRequest(
        function: (Map<String, String> headers) async {
          return await http.post(
            Uri.parse(linkUrl),
            body: jsonEncode(data),
            headers: headers,
          );
        },
        token: token);
  }

  Future<ResponseData> deleteData({required String linkUrl, Map data = const {}, bool token = false}) async {
    return handleRequest(
        function: (Map<String, String> headers) async {
          return await http.delete(
            Uri.parse(linkUrl),
            body: jsonEncode(data),
            headers: headers,
          );
        },
        token: token);
  }

  Future<ResponseData> putData({required String linkUrl, Map data = const {}, bool token = false}) async {
    return handleRequest(
        function: (Map<String, String> headers) async {
          return await http.put(
            Uri.parse(linkUrl),
            body: jsonEncode(data),
            headers: headers,
          );
        },
        token: token);
  }

  Future<ResponseData> getData({required String linkUrl, bool token = false}) async {
    return handleRequest(
        function: (Map<String, String> headers) async {
          return await http.get(Uri.parse(linkUrl), headers: headers);
        },
        token: token);
  }

  Future<ResponseData> postWithImageData(
      {required String linkUrl,
      required Map<String, dynamic> data,
      required ImageUpload? image,
      String fieldName = 'files',
      bool token = false}) async {

    return handleRequest(
        function: (Map<String, String> headers) async {
          final uri = Uri.parse(linkUrl);
          final request = http.MultipartRequest("POST", uri);
          request.headers.addAll(headers);
          if (image != null) {
            http.MultipartFile multipartFile = http.MultipartFile.fromBytes(
              fieldName,
              image.image,
              filename: image.name,
            );
            request.files.add(multipartFile);
          }
          data.forEach((key, value) {
            request.fields[key] = value;
          });

          final myRequest = await request.send();
          return await http.Response.fromStream(myRequest);
        },
        token: token);
  }
}
