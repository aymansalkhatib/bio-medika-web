import 'package:bio_medika_web/core/services/app_link.dart';
import 'package:bio_medika_web/core/services/crud.dart';
import 'package:bio_medika_web/models/response_data.dart';

class OrderData {
  Crud crud;
  OrderData(this.crud);

  Future<ResponseData> getAllOrder() async {
    return await crud.getData(linkUrl: AppLink.getAllOrder, token: true);
  }

  Future<ResponseData> cancelOrder(String id) async {
    return await crud.postData(linkUrl: AppLink.cancelOrder, token: true, data: {"id": id});
  }

  Future<ResponseData> shippedOrder(String id) async {
    return await crud.postData(linkUrl: AppLink.shipOrder, token: true, data: {"id": id});
  }

  Future<ResponseData> deliverOrder(String id) async {
    return await crud.postData(linkUrl: AppLink.deliverOrder, token: true, data: {"id": id});
  }

  Future<ResponseData> payOrder(String id) async {
    return await crud.postData(linkUrl: AppLink.payOrder, token: true, data: {"order_id": id});
  }
}
