import 'package:bio_medika_web/controllers/medication/medication_controller.dart';
import 'package:bio_medika_web/core/constant/app_border_radius.dart';
import 'package:bio_medika_web/core/constant/app_constant.dart';
import 'package:bio_medika_web/core/enum/status_request_enum.dart';
import 'package:bio_medika_web/core/enum/type_widget.dart';
import 'package:bio_medika_web/core/ui/shared/shimmer.dart';
import 'package:bio_medika_web/views/medication/widget/medication_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class MedicationListItem extends StatelessWidget {
  const MedicationListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<MedicationControllerImp>(
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.only(top: AppConstants.val_18),
            child: ShimmerBioMedica(
              crossAxisCount: 100.w ~/ 300,
              loading: controller.statusRequest == StatusRequest.loading,
              borderRadius: AppBorderRadius.borderRadius_30,
              typeWidget: TypeWidget.grid,
              child: GridView.builder(
                padding: const EdgeInsets.only(
                    left: AppConstants.val_18, bottom: AppConstants.val_18, right: AppConstants.val_18),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 100.w ~/ 300,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: AppConstants.val_20,
                    mainAxisSpacing: AppConstants.val_20),
                itemCount: controller.listMedication.length,
                itemBuilder: (BuildContext context, int index) {
                  return MedicationItem(medicationModel: controller.listMedication[index]);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
