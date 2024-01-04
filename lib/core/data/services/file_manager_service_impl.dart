import 'dart:io';

import 'file_manager_service.dart';

class FileManagerServiceImpl extends FileManagerService {
  @override
  Future<String> deleteFile(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        file.delete();

        return 'Archivo eliminado correctamente';
      }
    } catch (e) {
      return 'Ocurrió un error al eliminar el archivo del dispositivo';
    }

    return 'Ocurrió un error al eliminar el archivo del dispositivo';
  }
}
