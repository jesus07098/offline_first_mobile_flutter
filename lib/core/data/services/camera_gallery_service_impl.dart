import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';

import 'camera_gallery_service.dart';

class CameraGalleryServiceImpl extends CameraGalleryService {
  final ImagePicker _picker = ImagePicker();
  @override
  Future<List<String>?> selectPhotos() async {
    try {
      final List<XFile?> photos = await _picker.pickMultiImage(
        imageQuality: 80,
      );
      List<String> photoPaths = [];

      for (XFile? photo in photos) {
        if (photo != null) {
          photoPaths.add(photo.path);
        }
      }
      return photoPaths;
    } catch (e) {
      Exception('Error al seleccionar fotos $e');
    }
    return null;
  }

  String getExtension(String route) {
    String fileName = path.basename(route);
    String extension = path.extension(fileName).substring(1);
    return extension;
  }

  @override
  Future<String?> takePhoto() async {
    final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        preferredCameraDevice: CameraDevice.rear);

    if (photo == null) return null;

    return photo.path;
  }
}
