import 'package:bio_medika_web/core/services/app_link.dart';
import 'package:bio_medika_web/core/services/crud.dart';
import 'package:bio_medika_web/models/image_upload.dart';
import 'package:bio_medika_web/models/response_data.dart';

class CategoriesData {
  Crud crud;
  CategoriesData(this.crud);

  Future<ResponseData> getAllCategories() async {
    return await crud.getData(linkUrl: AppLink.getAllCategories, token: true);
  }

  Future<ResponseData> deleteAllCategories(int id) async {
    return await crud.deleteData(linkUrl: AppLink.deleteCategories, token: true, data: {"id": id});
  }

  Future<ResponseData> updateAllCategories({required Map<String, dynamic> data, ImageUpload? image}) async {
    return await crud.postWithImageData(
        linkUrl: AppLink.updateCategories, token: true, data: data, image: image, fieldName: "image");
  }

  Future<ResponseData> createAllCategories({required Map<String, dynamic> data, ImageUpload? image}) async {
    return await crud.postWithImageData(
        linkUrl: AppLink.createCategories, token: true, data: data, image: image, fieldName: "image");
  }
}
