import 'package:formz/formz.dart';

enum TypeIncidentError { empty }

class TypeIncident extends FormzInput<String, TypeIncidentError> {
  const TypeIncident.pure() : super.pure('');

  const TypeIncident.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == TypeIncidentError.empty) return 'El campo es requerido';

    return null;
  }

  @override
  TypeIncidentError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return TypeIncidentError.empty;

    return null;
  }
}
