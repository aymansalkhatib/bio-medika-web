import 'package:bio_medika_web/core/services/app_link.dart';
import 'package:bio_medika_web/core/services/crud.dart';
import 'package:bio_medika_web/models/image_upload.dart';
import 'package:bio_medika_web/models/response_data.dart';

class MedicationData {
  Crud crud;
  MedicationData(this.crud);

  Future<ResponseData> getAllMedication() async {
    return await crud.getData(linkUrl: AppLink.getAllMedication, token: true);
  }

  Future<ResponseData> deleteMedication({required String id}) async {
    return await crud.deleteData(linkUrl: AppLink.deleteMedication, token: true, data: {"id": id});
  }

  updateMedication({ImageUpload? image, required Map<String, dynamic> data}) async {
    return await crud.postWithImageData(
      linkUrl: AppLink.updateMedication,
      token: true,
      data: data,
      image: image,
      fieldName: "image",
    );
  }

  createMedication({required ImageUpload image, required Map<String, dynamic> data}) async {
    return await crud.postWithImageData(
      linkUrl: AppLink.createMedication,
      token: true,
      data: data,
      image: image,
      fieldName: "image",
    );
  }
}
