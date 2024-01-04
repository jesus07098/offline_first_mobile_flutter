import 'package:formz/formz.dart';

enum VehicleError { empty }

class Vehicle extends FormzInput<String, VehicleError> {
  const Vehicle.pure() : super.pure('');

  const Vehicle.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == VehicleError.empty) return 'El campo es requerido';

    return null;
  }

  @override
  VehicleError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return VehicleError.empty;

    return null;
  }
}
