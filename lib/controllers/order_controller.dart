import 'package:bio_medika_web/core/data/order.dart';
import 'package:bio_medika_web/core/enum/order.dart';
import 'package:bio_medika_web/core/enum/status_request_enum.dart';
import 'package:bio_medika_web/core/helpers/checker_date.dart';
import 'package:bio_medika_web/models/categories_model.dart';
import 'package:bio_medika_web/models/order_model.dart';
import 'package:bio_medika_web/models/response_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

abstract class OrderController extends GetxController {
      getAllOrder();
 
  changeStatus({required StatusOrder statusOrder, required String id});
}

class OrderControllerImp extends OrderController {
  late List<(String, String, TextEditingController, FocusNode, Function(String?), List<TextInputFormatter>)>
      field;
  late StatusRequest statusRequest;
  late List<OrderModel> listOrder;
  late List<OrderModel> fullOrder;
  late OrderData orderData;

  @override
  void onInit() {
    statusRequest = StatusRequest.loading;
    listOrder = fullOrder = [];
    orderData = OrderData(Get.find());
    getAllOrder();
    super.onInit();
  }

  sort(SortOrder sortOrder) {
    if (sortOrder == SortOrder.Cancelled ||
        sortOrder == SortOrder.Delivered ||
        sortOrder == SortOrder.Pending ||
        sortOrder == SortOrder.Shipped) {
      listOrder = fullOrder.where((element) => element.status == sortOrder.name).toList();
    } else if (sortOrder == SortOrder.Paid || sortOrder == SortOrder.Unpaid) {
      listOrder = fullOrder.where((element) => element.paid == sortOrder.name).toList();
    } else if (sortOrder == SortOrder.Quantity) {
      listOrder = fullOrder;
      listOrder.sort((a, b) => a.medicationsCount.compareTo(b.medicationsCount));
    } else if (sortOrder == SortOrder.Price) {
      listOrder = fullOrder;
      listOrder.sort((a, b) => a.finalPrice.compareTo(b.finalPrice));
    } else if (sortOrder == SortOrder.Date) {
      listOrder = fullOrder;
      listOrder.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    } else {
      listOrder = fullOrder;
    }
    update();
  }

  @override
  getAllOrder() async {
    ResponseData responseData = await orderData.getAllOrder();
    if (responseData.statusRequest == StatusRequest.success) {
      fullOrder = OrderModel.listFromJson(responseData.data);
      listOrder = OrderModel.listFromJson(responseData.data);
      update();
    }
  }

  @override
  changeStatus({required StatusOrder statusOrder, required String id}) async {
    late ResponseData responseData;
    if (statusOrder == StatusOrder.Cancelled) {
      responseData = await orderData.cancelOrder(id);
    }
    if (statusOrder == StatusOrder.Shipped) {
      responseData = await orderData.shippedOrder(id);
    }
    if (statusOrder == StatusOrder.Paid) {
      responseData = await orderData.payOrder(id);
    }
    if (statusOrder == StatusOrder.Delivered) {
      responseData = await orderData.deliverOrder(id);
    }

    if (responseData.statusRequest == StatusRequest.success) {
      for (int i = 0; i < fullOrder.length; i++) {
        if (fullOrder[i].id.toString() == id) {
          if (statusOrder == StatusOrder.Paid) {
            fullOrder[i].paid = statusOrder.name;
          } else {
            fullOrder[i].status = statusOrder.name;
          }
        }
      }
      for (int i = 0; i < listOrder.length; i++) {
        if (listOrder[i].id.toString() == id) {
          if (statusOrder == StatusOrder.Paid) {
            listOrder[i].paid = statusOrder.name;
          } else {
            listOrder[i].status = statusOrder.name;
          }
        }
      }
      update();
    }
  }

  search(String query) {
    if (query.length == 22 && isDateRangeFormatCorrect(query)) {
      listOrder = fullOrder
          .where((element) => isDateInRange(element.createdAt.toString().substring(0, 10), query))
          .toList();
    } else if (query.length == 11 && areFormatsCorrectForBeforeAfterCheck(query)) {
      listOrder = fullOrder
          .where((element) => isDateBeforeOrAfter(element.createdAt.toString().substring(0, 10), query))
          .toList();
    } else if (query.isEmpty) {
      listOrder = fullOrder;
    } else {
      listOrder = searchMedications(fullOrder, query);
    }
    update();
  }

  List<OrderModel> searchMedications(List<OrderModel> orders, String query) {
    query = query.toLowerCase().trim();
    return orders.where((order) {
      bool name = order.user.name.toLowerCase().contains(query);
      bool pharmacy = order.user.pharmacy.toLowerCase().contains(query);

      return name || pharmacy;
    }).toList();
  }

  List<CategoriesModel> searchCategory(List<CategoriesModel> categories, String query) {
    query = query.toLowerCase().trim();
    return categories.where((category) {
      String simplifiedArabicQuery = simplifyArabic(query);
      bool matchesEnglishName = category.nameEn.toLowerCase().contains(query);
      bool matchesArabicName = category.nameAr.contains(simplifiedArabicQuery);

      return matchesEnglishName || matchesArabicName;
    }).toList();
  }

  String simplifyArabic(String input) {
    const arabicSimplificationMap = {
      'أ': 'ا',
      'إ': 'ا',
      'آ': 'ا',
    };
    return input.split('').map((char) => arabicSimplificationMap[char] ?? char).join();
  }
}
