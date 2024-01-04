import 'package:formz/formz.dart';

// Define input validation errors
enum CircuitError { empty, length }

// Extend FormzInput and provide the input type and error type.
class Circuit extends FormzInput<String, CircuitError> {
  // Call super.pure to represent an unmodified form input.
  const Circuit.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Circuit.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == CircuitError.empty) return 'El campo es requerido';
    // if ( displayError == Circuit.length ) return 'Mínimo 6 caracteres';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  CircuitError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return CircuitError.empty;
    // if ( value.length < 6 ) return Circuit.length;

    return null;
  }
}
