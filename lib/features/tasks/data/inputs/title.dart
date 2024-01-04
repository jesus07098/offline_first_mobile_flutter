import 'package:formz/formz.dart';

enum TitleInputError { empty }

class Title extends FormzInput<String, TitleInputError> {
  const Title.pure() : super.pure('');

  const Title.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == TitleInputError.empty) return 'El campo es requerido';

    return null;
  }

  @override
  TitleInputError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) {
      return TitleInputError.empty;
    }

    return null;
  }
}
