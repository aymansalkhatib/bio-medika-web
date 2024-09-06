import 'dart:io';
import 'dart:typed_data';

class ImageUpload {
  final File imageFile;
  final Uint8List image;
  final String name;

  ImageUpload({required this.imageFile, required this.image, required this.name});
}
