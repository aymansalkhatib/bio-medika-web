import 'package:bio_medika_web/core/constant/app_colors.dart';
import 'package:bio_medika_web/views/home/widget/custom_appbar_home.dart';
import 'package:bio_medika_web/views/order/widget/order_table.dart';
import 'package:flutter/material.dart';

class OrderBody extends StatelessWidget {
  const OrderBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          AppColor.primary,
          AppColor.secondary,
        ])),
        child: const CustomAppBarHome(),
      ),
      const Ordertable(),
    ]);
  }
}
