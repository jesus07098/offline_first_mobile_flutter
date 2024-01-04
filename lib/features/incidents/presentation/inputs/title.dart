import 'package:formz/formz.dart';

enum TitleError { empty, length }

class TitleInspec extends FormzInput<String, TitleError> {

  const TitleInspec.pure() : super.pure('');

  const TitleInspec.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == TitleError.empty) return 'El campo es requerido';
    // if ( displayError == Title.length ) return 'Mínimo 6 caracteres';

    return null;
  }

  @override
  TitleError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return TitleError.empty;
    // if ( value.length < 6 ) return Title.length;

    return null;
  }
}
