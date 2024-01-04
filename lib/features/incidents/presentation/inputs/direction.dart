import 'package:formz/formz.dart';

enum DirectionError { empty, length }

class Direction extends FormzInput<String, DirectionError> {

  const Direction.pure() : super.pure('');

  const Direction.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == DirectionError.empty) return 'El campo es requerido';

    return null;
  }

  @override
  DirectionError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return DirectionError.empty;
    return null;
  }
}
