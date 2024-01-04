

import 'package:formz/formz.dart';

enum DateError { empty }

class Date extends FormzInput<String?, DateError> {
  const Date.pure() : super.pure(null);

  const Date.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == DateError.empty) return 'El campo es requerido';

    return null;
  }

  @override
  DateError? validator(String? value) {
    if (value==null) return DateError.empty;

    return null;
  }
}
