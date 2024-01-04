part of 'type_incidents_bloc.dart';

enum TypeIncidentsStatus {
  none,
  waiting,
  sending,
  established,
}

class TypeIncidentsState extends Equatable {
  final TypeIncidentsStatus typeIncidentsStatus;
  final List<TypeIncidentData> incidentsTypes;
  final TypeIncidentData? currentType;
  final String message;

  const TypeIncidentsState(
      {this.typeIncidentsStatus = TypeIncidentsStatus.none,
      this.incidentsTypes = const [],
      this.message = '',
      this.currentType});

  TypeIncidentsState copyWith(
      {TypeIncidentsStatus? typeIncidentsStatus,
      List<TypeIncidentData>? incidentsTypes,
      String? message,
      TypeIncidentData? Function()? currentType}) {
    return TypeIncidentsState(
        typeIncidentsStatus: typeIncidentsStatus ?? this.typeIncidentsStatus,
        incidentsTypes: incidentsTypes ?? this.incidentsTypes,
        message: message ?? this.message,
        currentType: currentType != null ? currentType() : this.currentType);
  }

  @override
  List<Object?> get props =>
      [typeIncidentsStatus, message, currentType, incidentsTypes];
}
