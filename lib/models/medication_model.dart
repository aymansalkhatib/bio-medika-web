import 'package:bio_medika_web/core/services/app_link.dart';

class MedicationModel {
  late String id;
  late String categoryId;
  late String scientificNameAr;
  late String scientificNameEn;
  late String commercialNameAr;
  late String commercialNameEn;
  late String companyNameAr;
  late String companyNameEn;
  late String detailsAr;
  late String detailsEn;
  late double price;
  late int quantity;
  late String expiryDate;
  late String imageUrl;
  late String createdAt;
  late String updatedAt;
  late int daysBeforeExpiration;
  late int monthsBeforeExpiration;
  late int dailySale;
  late int sale;
  late bool favorate;

  late double finalPrice;

  MedicationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    categoryId = json['category_id'].toString();
    scientificNameAr = json['scientific_name_ar'];
    scientificNameEn = json['scientific_name_en'];
    commercialNameAr = json['commercial_name_ar'];
    commercialNameEn = json['commercial_name_en'];
    companyNameAr = json['company_name_ar'];
    companyNameEn = json['company_name_en'];
    detailsAr = json['details_ar'];
    detailsEn = json['details_en'];
    price = double.tryParse(json['price'].toString()) ?? 0;
    quantity = int.tryParse(json['quantity'].toString()) ?? 0;
    expiryDate = json['expiry_date'].toString();
    imageUrl = AppLink.prefixPathImage + json['image_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    daysBeforeExpiration = int.tryParse(json['days_before_expiration'].toString()) ?? 0;
    monthsBeforeExpiration = int.tryParse(json['months_before_expiration'].toString()) ?? 0;
    dailySale = int.tryParse(json['daily_sale'].toString()) ?? 0;
    sale = int.tryParse(json['sale'].toString()) ?? 0;
    finalPrice = double.tryParse(json['final_price'].toString()) ?? 0.0;
    favorate = json['favorite'] ?? true;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_id': categoryId,
      'scientific_name_ar': scientificNameAr,
      'scientific_name_en': scientificNameEn,
      'commercial_name_ar': commercialNameAr,
      'commercial_name_en': commercialNameEn,
      'company_name_ar': companyNameAr,
      'company_name_en': companyNameEn,
      'details_ar': detailsAr,
      'details_en': detailsEn,
      'price': price.toString(),
      'quantity': quantity.toString(),
      'expiry_date': expiryDate,
      'image_url':
          imageUrl.replaceFirst(AppLink.prefixPathImage, ''), // Assuming you want to store the relative path
      'created_at': createdAt,
      'updated_at': updatedAt,
      'days_before_expiration': daysBeforeExpiration,
      'months_before_expiration': monthsBeforeExpiration,
      'daily_sale': dailySale,
      'sale': sale,
      'final_price': finalPrice.toString(),
      'favorite': favorate,
    };
  }

  static List<MedicationModel> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => MedicationModel.fromJson(json)).toList();
  }
}
