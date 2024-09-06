import 'package:bio_medika_web/core/helpers/pc.dart';
import 'package:bio_medika_web/core/services/app_link.dart';
import 'package:bio_medika_web/core/services/crud.dart';
import 'package:bio_medika_web/models/response_data.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationData {
  Crud crud;
  NotificationData(this.crud);

  Future<ResponseData> upToken() async {
    await FirebaseMessaging.instance.requestPermission().then((NotificationSettings settings) {});
    String? token = await FirebaseMessaging.instance
        .getToken();
    pc(token.toString());
    return await crud.postData(linkUrl: AppLink.upToken, token: true, data: {"token": token});
  }
}
