import 'package:formz/formz.dart';

enum PriorityError { empty }

class Priority extends FormzInput<String, PriorityError> {
  const Priority.pure() : super.pure('');

  const Priority.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == PriorityError.empty) return 'El campo es requerido';

    return null;
  }

  @override
  PriorityError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return PriorityError.empty;

    return null;
  }
}
