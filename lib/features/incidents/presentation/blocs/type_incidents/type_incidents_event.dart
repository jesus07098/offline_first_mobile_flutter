part of 'type_incidents_bloc.dart';

abstract class TypesIncidentsEvent {
  const TypesIncidentsEvent();
}

class OnSaveTypesIncidents extends TypesIncidentsEvent {}

class OnClearTypeIncident extends TypesIncidentsEvent {}

class OnGetTypesIncidents extends TypesIncidentsEvent {}

class OnSetTypeIncident extends TypesIncidentsEvent {
  final int index;

  const OnSetTypeIncident({required this.index});
}

class OnSetTypeIncidentUpdating extends TypesIncidentsEvent {
  final TypeIncidentData type;
  const OnSetTypeIncidentUpdating({required this.type});
}
