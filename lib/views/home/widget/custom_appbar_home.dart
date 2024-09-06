import 'package:bio_medika_web/controllers/auth/appbar_controller.dart';
import 'package:bio_medika_web/controllers/categories_controller.dart';
import 'package:bio_medika_web/controllers/medication/medication_controller.dart';
import 'package:bio_medika_web/controllers/order_controller.dart';
import 'package:bio_medika_web/core/constant/app_assets_png.dart';
import 'package:bio_medika_web/core/constant/app_colors.dart';
import 'package:bio_medika_web/core/constant/app_constant.dart';
import 'package:bio_medika_web/core/constant/app_route.dart';
import 'package:bio_medika_web/core/constant/app_texts.dart';
import 'package:bio_medika_web/core/enum/medication.dart';
import 'package:bio_medika_web/core/enum/order.dart';
import 'package:bio_medika_web/core/services/my_services.dart';
import 'package:bio_medika_web/core/ui/shared/custom_search_bar.dart';
import 'package:bio_medika_web/core/ui/shared/custom_text_appbar.dart';
import 'package:bio_medika_web/models/admin_model.dart';
import 'package:bio_medika_web/views/auth/login/widget/custom_buttom_login.dart';
import 'package:bio_medika_web/views/home/widget/menu_item_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomAppBarHome extends GetView<AppBarControllerImp> {
  const CustomAppBarHome({super.key});
  @override
  Widget build(BuildContext context) {
    bool isArabic = Get.find<MyAppServices>().appIsArabic();

    return SizedBox(
        width: 100.w,
        height: 8.5.h,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 1.5.w),
            //! LOGO
            GetBuilder<AppBarControllerImp>(builder: (contrller) {
              return Visibility(
                visible: Get.routing.current == AppRoutes.home,
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.val_10),
                  child: Image.asset(
                    AppAssetsPng.bioMedika,
                    width: 13.w,
                  ),
                ),
              );
            }),
            //! Search
            GetBuilder<AppBarControllerImp>(builder: (contrller) {
              String title = AppTextsEnglish.Search_for_medicines.tr;
              if (Get.routing.current == AppRoutes.categories) {
                title = AppTextsEnglish.Search_for_categories.tr;
              } else if (Get.routing.current == AppRoutes.order) {
                title = AppTextsEnglish.Search_by_username.tr;
              }

              return Visibility(
                  visible: AdminModel.get().id.isNotEmpty && Get.routing.current != AppRoutes.home,
                  child: Padding(
                    padding: EdgeInsets.only(left: isArabic ? 2.w : 0, right: isArabic ? 0 : 2.w),
                    child: CustomSearchBarWidget(
                      hint: title,
                      onChanged: (value) {
                        if (Get.routing.current == AppRoutes.medication) {
                          Get.find<MedicationControllerImp>().search(value);
                        } else if (Get.routing.current == AppRoutes.order) {
                          Get.find<OrderControllerImp>().search(value);
                        } else if (Get.routing.current == AppRoutes.categories) {
                          Get.find<CategoriesControllerImp>().search(value);
                        }
                      },
                    ),
                  ));
            }),
            const Spacer(),

            SizedBox(width: 3.w),
            CustomTextAppBar(
              text: AppTextsEnglish.Orders.tr,
              onTap: controller.goToOrder,
              route: AppRoutes.order,
            ),
            SizedBox(width: 3.w),
            CustomTextAppBar(
                text: AppTextsEnglish.Medications.tr,
                onTap: controller.goToMedicatiom,
                route: AppRoutes.medication),
            SizedBox(width: 3.w),
            CustomTextAppBar(
              text: AppTextsEnglish.Categories.tr,
              onTap: controller.goToCategory,
              route: AppRoutes.categories,
            ),
            SizedBox(width: 3.w),
            GetBuilder<AppBarControllerImp>(builder: (contrller) {
              return Visibility(
                  visible:
                      Get.routing.current != AppRoutes.home && Get.routing.current != AppRoutes.categories,
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: Get.find<MyAppServices>().appIsArabic() ? 0 : 4.w,
                      left: !Get.find<MyAppServices>().appIsArabic() ? 0 : 4.w,
                    ),
                    child: PopupMenuButton(
                      tooltip: '',
                      itemBuilder: (BuildContext context) => items,

                      child: CustomTextAppBar(
                        text: AppTextsEnglish.Sort_by.tr,
                        route: "",
                      ),
                      //
                    ),
                  ));
            }),

            GetBuilder<AppBarControllerImp>(builder: (contrller) {
              return Visibility(visible: AdminModel.get().id.isEmpty, child: const CustomButtomLogin());
            }),
            GetBuilder<AppBarControllerImp>(builder: (contrller) {
              return Visibility(visible: AdminModel.get().id.isNotEmpty, child: const MenuItemHome());
            }),
            SizedBox(width: 1.5.w),
          ],
        ));
  }
}

List<PopupMenuEntry<String>> get items {
  if (Get.routing.current == AppRoutes.medication) {
    final controller = Get.find<MedicationControllerImp>();
    return <PopupMenuEntry<String>>[
      PopupMenuItem<String>(
        onTap: () {
          controller.sort(SortMedication.expiredData);
        },
        padding: EdgeInsets.zero,
        child: Text(
          '     ${AppTextsEnglish.Expiration_date.tr}',
          style: TextStyle(
            color: AppColor.primary,
            fontWeight: FontWeight.bold,
            fontSize: 0.8.sp,
          ),
        ),
      ),
      PopupMenuItem<String>(
        onTap: () {
          controller.sort(SortMedication.price);
        },
        padding: EdgeInsets.zero,
        child: Text(
          '     ${AppTextsEnglish.Price.tr}',
          style: TextStyle(
            color: AppColor.primary,
            fontWeight: FontWeight.bold,
            fontSize: 0.8.sp,
          ),
        ),
      ),
      PopupMenuItem<String>(
        onTap: () {
          controller.sort(SortMedication.delayPrice);
        },
        padding: EdgeInsets.zero,
        child: Text(
          '     ${AppTextsEnglish.Discount_value.tr}',
          style: TextStyle(
            color: AppColor.primary,
            fontWeight: FontWeight.bold,
            fontSize: 0.8.sp,
          ),
        ),
      ),
      PopupMenuItem<String>(
        onTap: () {
          controller.sort(SortMedication.quantity);
        },
        padding: EdgeInsets.zero,
        child: Text(
          '     ${AppTextsEnglish.Quantity_available.tr}',
          style: TextStyle(
            color: AppColor.primary,
            fontWeight: FontWeight.bold,
            fontSize: 0.8.sp,
          ),
        ),
      ),
      PopupMenuItem<String>(
        onTap: () {
          controller.sort(SortMedication.normal);
        },
        padding: EdgeInsets.zero,
        child: Text(
          '     ${AppTextsEnglish.Cancel_sorting.tr}',
          style: TextStyle(
            color: AppColor.primary,
            fontWeight: FontWeight.bold,
            fontSize: 0.8.sp,
          ),
        ),
      ),
    ];
  } else if (Get.routing.current == AppRoutes.order) {
    final controller = Get.find<OrderControllerImp>();
    return <PopupMenuEntry<String>>[
      PopupMenuItem<String>(
        onTap: () {
          controller.sort(SortOrder.Cancelled);
        },
        padding: EdgeInsets.zero,
        child: Text(
          '     ${AppTextsEnglish.Cancelled.tr}',
          style: TextStyle(
            color: AppColor.primary,
            fontWeight: FontWeight.bold,
            fontSize: 0.8.sp,
          ),
        ),
      ),
      PopupMenuItem<String>(
        onTap: () {
          controller.sort(SortOrder.Delivered);
        },
        padding: EdgeInsets.zero,
        child: Text(
          '     ${AppTextsEnglish.Delivered.tr}',
          style: TextStyle(
            color: AppColor.primary,
            fontWeight: FontWeight.bold,
            fontSize: 0.8.sp,
          ),
        ),
      ),
      PopupMenuItem<String>(
        onTap: () {
          controller.sort(SortOrder.Shipped);
        },
        padding: EdgeInsets.zero,
        child: Text(
          '     ${AppTextsEnglish.Shipped.tr}',
          style: TextStyle(
            color: AppColor.primary,
            fontWeight: FontWeight.bold,
            fontSize: 0.8.sp,
          ),
        ),
      ),
      PopupMenuItem<String>(
        onTap: () {
          controller.sort(SortOrder.Pending);
        },
        padding: EdgeInsets.zero,
        child: Text(
          '     ${AppTextsEnglish.Pending.tr}',
          style: TextStyle(
            color: AppColor.primary,
            fontWeight: FontWeight.bold,
            fontSize: 0.8.sp,
          ),
        ),
      ),
      PopupMenuItem<String>(
        onTap: () {
          controller.sort(SortOrder.Paid);
        },
        padding: EdgeInsets.zero,
        child: Text(
          '     ${AppTextsEnglish.Paid.tr}',
          style: TextStyle(
            color: AppColor.primary,
            fontWeight: FontWeight.bold,
            fontSize: 0.8.sp,
          ),
        ),
      ),
      PopupMenuItem<String>(
        onTap: () {
          controller.sort(SortOrder.Unpaid);
        },
        padding: EdgeInsets.zero,
        child: Text(
          '     ${AppTextsEnglish.Unpaid.tr}',
          style: TextStyle(
            color: AppColor.primary,
            fontWeight: FontWeight.bold,
            fontSize: 0.8.sp,
          ),
        ),
      ),
      PopupMenuItem<String>(
        onTap: () {
          controller.sort(SortOrder.Quantity);
        },
        padding: EdgeInsets.zero,
        child: Text(
          '     ${AppTextsEnglish.Required_quantity.tr}',
          style: TextStyle(
            color: AppColor.primary,
            fontWeight: FontWeight.bold,
            fontSize: 0.8.sp,
          ),
        ),
      ),
      PopupMenuItem<String>(
        onTap: () {
          controller.sort(SortOrder.Price);
        },
        padding: EdgeInsets.zero,
        child: Text(
          '     ${AppTextsEnglish.Price.tr}',
          style: TextStyle(
            color: AppColor.primary,
            fontWeight: FontWeight.bold,
            fontSize: 0.8.sp,
          ),
        ),
      ),
      PopupMenuItem<String>(
        onTap: () {
          controller.sort(SortOrder.Date);
        },
        padding: EdgeInsets.zero,
        child: Text(
          '     ${AppTextsEnglish.Request_date.tr}',
          style: TextStyle(
            color: AppColor.primary,
            fontWeight: FontWeight.bold,
            fontSize: 0.8.sp,
          ),
        ),
      ),
      PopupMenuItem<String>(
        onTap: () {
          controller.sort(SortOrder.normal);
        },
        padding: EdgeInsets.zero,
        child: Text(
          '     ${AppTextsEnglish.Cancel_sorting.tr}',
          style: TextStyle(
            color: AppColor.primary,
            fontWeight: FontWeight.bold,
            fontSize: 0.8.sp,
          ),
        ),
      ),
    ];
  } else {
    return [];
  }
}
