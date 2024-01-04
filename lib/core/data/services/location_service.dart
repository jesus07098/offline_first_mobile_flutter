import 'package:geolocator/geolocator.dart';

Future<Position> getLocation() async {
  // Verificar y solicitar permisos de ubicación si es necesario
  await Geolocator.checkPermission();
  await Geolocator.requestPermission();

  // Obtener la posición actual
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);

  return position;
}
