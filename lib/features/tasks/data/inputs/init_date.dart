import 'package:formz/formz.dart';

// Define input validation errors
enum InitDateInputError { empty }

// Extend FormzInput and provide the input type and error type.
class InitDate extends FormzInput<DateTime?, InitDateInputError> {
  // Call super.pure to represent an unmodified form input.
  const InitDate.pure([super.value]) : super.pure();

  // Call super.dirty to represent a modified form input.
  const InitDate.dirty([super.value]) : super.dirty();

  // Override validator to handle validating a given input value.
  @override
  InitDateInputError? validator(DateTime? value) {
    if (value==null) {
      return InitDateInputError.empty;
    }

    return null;
  }
}
