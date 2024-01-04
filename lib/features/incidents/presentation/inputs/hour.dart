import 'package:formz/formz.dart';

enum HourError { empty, length }

class Hour extends FormzInput<String?, HourError> {
  const Hour.pure() : super.pure(null);

  const Hour.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == HourError.empty) return 'El campo es requerido';
    return null;
  }

  @override
  HourError? validator(String? value) {
    if (value == null) return HourError.empty;

    return null;
  }
}
