import 'package:formz/formz.dart';

// Define input validation errors
enum DueDateInputError { empty }

// Extend FormzInput and provide the input type and error type.
class DueDate extends FormzInput<DateTime?, DueDateInputError> {
  // Call super.pure to represent an unmodified form input.
  const DueDate.pure([super.value]) : super.pure();

  // Call super.dirty to represent a modified form input.
  const DueDate.dirty([super.value]) : super.dirty();

  // Override validator to handle validating a given input value.
  @override
  DueDateInputError? validator(DateTime? value) {
    if (value == null) {
      return DueDateInputError.empty;
    }
    return null;
  }
}
