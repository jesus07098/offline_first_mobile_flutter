import 'package:formz/formz.dart';

enum AssignedToError { empty, length }

class AssignedTo extends FormzInput<List<String>, AssignedToError> {
  const AssignedTo.pure() : super.pure(const []);

  const AssignedTo.dirty(List<String> value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == AssignedToError.empty) return 'El campo es requerido';

    return null;
  }

  @override
  AssignedToError? validator(List<String> value) {
    if (value.isEmpty) return AssignedToError.empty;

    return null;
  }
}
