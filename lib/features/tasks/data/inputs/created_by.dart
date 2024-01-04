import 'package:formz/formz.dart';


enum CreatedByInputError { empty }

class CreatedBy extends FormzInput<String, CreatedByInputError> {

  const CreatedBy.pure() : super.pure('');

  const CreatedBy.dirty(String value) : super.dirty(value);

  @override
  CreatedByInputError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) {
      return CreatedByInputError.empty;
    }

    return null;
  }
}
