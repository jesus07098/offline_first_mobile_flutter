part of 'incident_form_bloc.dart';

class IncidentFormState extends Equatable {
  final Vehicle vehicle;
  final TypeIncident typeIncident;
  final Circuit circuit;
  final ReportedBy reportedBy;
  final TitleInspec title;
  final String observation;
  final Date startDate;
  final Hour startHour;
  final Hour finishHour;
  final Direction direction;
  final Sector sector;
  final String zone;
  final AssignedTo assignedTo;
  final Priority priority;
  final List<String>? tags;
  final List<String>? photos;
  final List<String>? documents;
  final List<String>? audios;
  final Date dueDate;
  final bool isValid;
  final bool isFormPosted;
  final bool isSearching;
  final String message;
  final FormzSubmissionStatus formStatus;
  final List<Incident> incidents;
  final Incident? incidentByRecordId;

  const IncidentFormState(
      {this.isSearching = false,
      this.vehicle = const Vehicle.pure(),
      this.typeIncident = const TypeIncident.pure(),
      this.circuit = const Circuit.pure(),
      this.reportedBy = const ReportedBy.pure(),
      this.title = const TitleInspec.pure(),
      this.observation = '',
      this.startDate = const Date.pure(),
      this.startHour = const Hour.pure(),
      this.finishHour = const Hour.pure(),
      this.direction = const Direction.pure(),
      this.sector = const Sector.pure(),
      this.zone = '',
      this.assignedTo = const AssignedTo.pure(),
      this.priority = const Priority.pure(),
      this.tags = const [],
      this.photos = const [],
      this.audios = const [],
      this.documents = const [],
      this.dueDate = const Date.pure(),
      this.isValid = false,
      this.isFormPosted = false,
      this.message = '',
      this.formStatus = FormzSubmissionStatus.initial,
      this.incidents = const [],
      this.incidentByRecordId});

  IncidentFormState copyWith(
      {final Vehicle? vehicle,
      final TypeIncident? typeIncident,
      final Circuit? circuit,
      final ReportedBy? reportedBy,
      final TitleInspec? title,
      final String? observation,
      final Date? startDate,
      final Hour? startHour,
      final Hour? finishHour,
      final Direction? direction,
      final Sector? sector,
      final String? zone,
      final AssignedTo? assignedTo,
      final Priority? priority,
      final List<String>? tags,
      final List<String>? Function()? photos,
      final List<String>? documents,
      final List<String>? Function()? audios,
      final Date? dueDate,
      final bool? isValid,
      final bool? isFormPosted,
      final bool? isSearching,
      final bool? isIntentSave,
      final String? message,
      final FormzSubmissionStatus? formStatus,
      final List<Incident>? incidents,
      final Incident? incidentByRecordId}) {
    return IncidentFormState(
        typeIncident: typeIncident ?? this.typeIncident,
        vehicle: vehicle ?? this.vehicle,
        circuit: circuit ?? this.circuit,
        reportedBy: reportedBy ?? this.reportedBy,
        title: title ?? this.title,
        observation: observation ?? this.observation,
        startDate: startDate ?? this.startDate,
        startHour: startHour ?? this.startHour,
        finishHour: finishHour ?? this.finishHour,
        direction: direction ?? this.direction,
        sector: sector ?? this.sector,
        zone: zone ?? this.zone,
        assignedTo: assignedTo ?? this.assignedTo,
        priority: priority ?? this.priority,
        tags: tags ?? this.tags,
        photos: photos != null ? photos() : this.photos,
        documents: documents ?? this.documents,
        audios: audios != null ? audios() : this.audios,
        dueDate: dueDate ?? this.dueDate,
        isValid: isValid ?? this.isValid,
        isSearching: isSearching ?? this.isSearching,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        message: message ?? this.message,
        formStatus: formStatus ?? this.formStatus,
        incidents: incidents ?? this.incidents,
        incidentByRecordId: incidentByRecordId ?? this.incidentByRecordId);
  }

  bool get allFieldValid =>
      typeIncident.isValid &&
      vehicle.isValid &&
      circuit.isValid &&
      reportedBy.isValid &&
      title.isValid &&
      startDate.isValid &&
      startHour.isValid &&
      finishHour.isValid &&
      direction.isValid &&
      sector.isValid &&
      assignedTo.isValid &&
      priority.isValid &&
      dueDate.isValid &&
      finishHour.isValid;

  @override
  List<Object?> get props => [
        typeIncident,
        vehicle,
        circuit,
        reportedBy,
        title,
        observation,
        startDate,
        startHour,
        finishHour,
        direction,
        sector,
        zone,
        assignedTo,
        priority,
        tags,
        photos,
        documents,
        audios,
        dueDate,
        isValid,
        isFormPosted,
        message,
        formStatus,
        incidents,
        isSearching,
        incidentByRecordId
      ];
}
