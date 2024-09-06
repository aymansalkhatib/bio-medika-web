import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bio_medika_web/core/constant/app_colors.dart';
import 'package:bio_medika_web/core/constant/app_texts.dart';
import 'package:bio_medika_web/core/helpers/get_name.dart';
import 'package:bio_medika_web/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

awesomeDetailsOrder(List<OrderDetail> orderDetail) {
  return AwesomeDialog(
      width: 45.w,
      context: Get.context!,
      animType: AnimType.scale,
      dialogType: DialogType.noHeader,
      body: SizedBox(
        height: 70.h,
        child: Expanded(
          child: ListView(
            shrinkWrap: true,
            children: [
              DataTable(columns: [
                column(AppTextsEnglish.Name.tr),
                column(AppTextsEnglish.Quantity.tr),
                column( AppTextsEnglish.Sale.tr),
                column(AppTextsEnglish.Price.tr),
                column(AppTextsEnglish.Final_price.tr),
              ], rows: [
                for (int i = 0; i < orderDetail.length; i++)
                  DataRow(cells: [
                    row(getTextLang(
                        nameEnglish: orderDetail[i].commercialNameEn,
                        nameArabic: orderDetail[i].commercialNameAr)),
                    row(orderDetail[i].quantity.toString()),
                    row(orderDetail[i].sale.toString()),
                    row(orderDetail[i].price.toString()),
                    row(orderDetail[i].finalPrice.toString()),
                  ])
              ]),
            ],
          ),
        ),
      ))
    ..show();
}

DataCell row(String body) => DataCell(
      Center(
        child: Text(
          body,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );

DataColumn column(String title) => DataColumn(
      label: Expanded(
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: AppColor.primary,
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
