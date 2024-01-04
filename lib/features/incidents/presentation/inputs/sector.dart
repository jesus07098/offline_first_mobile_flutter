import 'package:formz/formz.dart';

enum SectorError { empty, length }

class Sector extends FormzInput<String, SectorError> {

  const Sector.pure() : super.pure('');

  const Sector.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == SectorError.empty) return 'El campo es requerido';
    // if ( displayError == Sector.length ) return 'Mínimo 6 caracteres';

    return null;
  }

  @override
  SectorError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return SectorError.empty;
    // if ( value.length < 6 ) return Title.length;

    return null;
  }
}
