import 'dart:convert';

import 'package:bio_medika_web/core/constant/app_texts.dart';
import 'package:bio_medika_web/core/enum/status_request_enum.dart';
import 'package:bio_medika_web/core/utils/network_checker.dart';
import 'package:bio_medika_web/models/response_data.dart';
import 'package:bio_medika_web/models/admin_model.dart';
import 'package:get/get.dart';

Future<ResponseData> handleRequest({
  required bool token,
  required Function function,
}) async {
  final NetworkChecker networkChecker = NetworkChecker(); //todo singltone
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    if (token) 'Authorization': 'Bearer ${AdminModel.get().token}'
  };
  try {
    if (await networkChecker.isOnline()) {
      final response = await function(headers);

      final Map responseBody = jsonDecode(response.body);

      if (responseBody['status'] == "success") {
        if (responseBody['data'] is List && responseBody['data'].isEmpty) {
          return ResponseData(
            data: responseBody['data'],
            statusRequest: StatusRequest.empty,
          );
        } else {
          return ResponseData(
            data: responseBody['data'],
            statusRequest: StatusRequest.success,
          );
        }
      } else {
        return ResponseData(
          errors: responseBody['errors'],
          statusRequest: StatusRequest.serverFailure,
        );
      }
    } else {
      return ResponseData(
        errors: AppTextsEnglish.Connect_to_the_Internet_and_try_again.tr,
        statusRequest: StatusRequest.offline,
      );
    }
  } catch (err) {
    print(err);
    return ResponseData(
      errors: AppTextsEnglish.An_unexpected_error_occurred_Try_again_later.tr,
      statusRequest: StatusRequest.serverException,
    );
  }
}
