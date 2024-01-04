import 'package:formz/formz.dart';

enum ReportedByError { empty }

class ReportedBy extends FormzInput<String, ReportedByError> {
  const ReportedBy.pure() : super.pure('');

  const ReportedBy.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == ReportedByError.empty) return 'El campo es requerido';

    return null;
  }

  @override
  ReportedByError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return ReportedByError.empty;

    return null;
  }
}
