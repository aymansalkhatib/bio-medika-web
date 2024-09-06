import 'package:bio_medika_web/core/services/my_services.dart';
import 'package:get/get.dart';

class AdminModel {
  final String id;
  final String name;
  final String email;
  final String token;

  AdminModel({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
  });

  factory AdminModel.fromJson(Map<String, dynamic> json) {
    return AdminModel(
      id: json['id'].toString(),
      name: json['name'],
      email: json['email'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'token': token,
    };
  }

  Future<AdminModel> save() async {
    MyAppServices myAppServices = Get.find();
    await myAppServices.putValue('id', id.toString());
    await myAppServices.putValue('name', name);
    await myAppServices.putValue('email', email);

    await myAppServices.putValue('token', token);

    return get();
  }

  static AdminModel get() {
    MyAppServices myAppServices = Get.find();

    return AdminModel(
      id: myAppServices.getValue('id'),
      name: myAppServices.getValue('name'),
      email: myAppServices.getValue('email'),
      token: myAppServices.getValue('token'),
    );
  }

  static void clean() {
    MyAppServices myAppServices = Get.find();
    myAppServices.removeValue('id');
    myAppServices.removeValue('name');
    myAppServices.removeValue('email');

    myAppServices.removeValue('token');
  }
}
