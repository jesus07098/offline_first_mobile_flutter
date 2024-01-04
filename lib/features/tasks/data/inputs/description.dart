import 'package:formz/formz.dart';

// Define input validation errors
enum DescriptionInputError { empty }

// Extend FormzInput and provide the input type and error type.
class Description extends FormzInput<String, DescriptionInputError> {
  // Call super.pure to represent an unmodified form input.
  const Description.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Description.dirty(String value) : super.dirty(value);

  // Override validator to handle validating a given input value.
  @override
  DescriptionInputError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) {
      return DescriptionInputError.empty;
    }

    return null;
  }
}
