import 'package:bio_medika_web/controllers/order_controller.dart';
import 'package:bio_medika_web/core/constant/app_colors.dart';
import 'package:bio_medika_web/core/constant/app_texts.dart';
import 'package:bio_medika_web/core/enum/order.dart';
import 'package:bio_medika_web/views/order/widget/awesom_details_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Ordertable extends StatelessWidget {
  const Ordertable({super.key});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<OrderControllerImp>(builder: (contrller) {
        return ListView(
          shrinkWrap: true,
          children: [
            DataTable(
              // headingRowColor: MaterialStatePropertyAll(
              //   AppColor.primary.withOpacity(0.2),
              // ),
              columns: [
                column(AppTextsEnglish.Index.tr),
                column(AppTextsEnglish.Name.tr),
                column(AppTextsEnglish.Pharmacy.tr),
                column(AppTextsEnglish.Phone.tr),
                column(AppTextsEnglish.City.tr),
                column(AppTextsEnglish.Landmark.tr),
                column(AppTextsEnglish.Price.tr),
                column(AppTextsEnglish.Request_date.tr),
                column(AppTextsEnglish.Payment.tr),
                column(AppTextsEnglish.Status.tr),
                column(AppTextsEnglish.Num_medication.tr),
              ],
              rows: [
                ...List.generate(
                  contrller.listOrder.length,
                  (index) {
                    int quanMed = 0;
                    for (int i = 0; i < contrller.listOrder[index].details.length; i++) {
                      quanMed += contrller.listOrder[index].details[i].quantity;
                    }
                    return DataRow(
                      onLongPress: () {
                        awesomeDetailsOrder(contrller.listOrder[index].details);
                      },
                      cells: [
                        row(
                          '${(index + 1)}',
                        ),
                        row(contrller.listOrder[index].user.name),
                        row(contrller.listOrder[index].user.pharmacy),
                        row(contrller.listOrder[index].user.phone),
                        row(contrller.listOrder[index].user.city),
                        row(contrller.listOrder[index].user.landmark),
                        row(contrller.listOrder[index].finalPrice.toString()),
                        row(contrller.listOrder[index].createdAt.toString().substring(0, 10)),
                        row(contrller.listOrder[index].status,
                            isStatusOrder: true, id: contrller.listOrder[index].id.toString()),
                        row(contrller.listOrder[index].paid,
                            isStatusPay: true,
                            status: contrller.listOrder[index].status,
                            id: contrller.listOrder[index].id.toString()),
                        row(
                          "${AppTextsEnglish.Num_medication.tr}: $quanMed",
                        ),
                      ],
                    );
                  },
                ),
                // Add more DataRows for more entries
              ],
            ),
          ],
        );
      }),
    );
  }

  DataCell row(String body,
          {String id = "1", bool isStatusOrder = false, bool isStatusPay = false, String? status}) =>
      DataCell(
        Center(
          child: (isStatusOrder && body != "Delivered" && body != "Cancelled") ||
                  (isStatusPay && body != "Paid" && status != "Cancelled")
              ? PopupMenuButton(
                  enableFeedback: false,
                  tooltip: isStatusPay ? "Change status Payment" : "Change stsus order",
                  itemBuilder: (_) => isStatusPay ? itemsPaid(id) : itemsStatus(body, id),
                  child: Text(
                    body.tr,
 
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 0.8.w,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              : Text(
                   body.tr,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 0.8.w,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      );

  DataColumn column(String title) => DataColumn(
        label: Expanded(
          child: Center(
            child: Text(
              title.tr,
              style:   TextStyle(
                color: AppColor.primary,
                fontWeight: FontWeight.w800,
                fontSize: 1.w,
              ),
            ),
          ),
        ),
      );
}

List<PopupMenuEntry<String>> itemsStatus(String body, String id) {
  final controller = Get.find<OrderControllerImp>();
  return <PopupMenuEntry<String>>[
    PopupMenuItem<String>(
      onTap: () {
        controller.changeStatus(statusOrder: StatusOrder.Cancelled, id: id);
      },
      padding: EdgeInsets.zero,
      child: Text(
        "  ${AppTextsEnglish.Cancelled.tr}",
        style: const TextStyle(
          color: AppColor.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    if (body == AppTextsEnglish.Pending)
      PopupMenuItem<String>(
        onTap: () {
          controller.changeStatus(statusOrder: StatusOrder.Shipped, id: id);
        },
        padding: EdgeInsets.zero,
        child: Text(
          "  ${AppTextsEnglish.Shipped.tr}",
          style: const TextStyle(
            color: AppColor.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    if (body == AppTextsEnglish.Shipped)
      PopupMenuItem<String>(
        onTap: () {
          controller.changeStatus(statusOrder: StatusOrder.Delivered, id: id);
        },
        padding: EdgeInsets.zero,
        child: Text(
          "  ${AppTextsEnglish.Delivered.tr}",
          style: const TextStyle(
            color: AppColor.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
  ];
}

List<PopupMenuEntry<String>> itemsPaid(String id) {
  final controller = Get.find<OrderControllerImp>();

  return <PopupMenuEntry<String>>[
    PopupMenuItem<String>(
      onTap: () {
        controller.changeStatus(statusOrder: StatusOrder.Paid, id: id);
      },
      padding: EdgeInsets.zero,
      child: Text(
        "  ${AppTextsEnglish.Paid.tr}",
        style: const TextStyle(
          color: AppColor.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ];
}
