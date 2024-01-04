part of 'incident_form_bloc.dart';

abstract class IncidentFormEvent {
  const IncidentFormEvent();
}

//Form control events 

class OnVehicleChange extends IncidentFormEvent {
  final String assetId;

  const OnVehicleChange(this.assetId);
}

class OnTypeIncidentChange extends IncidentFormEvent {
  final String typeIncident;

  const OnTypeIncidentChange(this.typeIncident);
}

class OnCircuitChange extends IncidentFormEvent {
  final String circuit;

  const OnCircuitChange(this.circuit);
}

class OnReportedByChange extends IncidentFormEvent {
  final String reportedById;

  const OnReportedByChange(this.reportedById);
}

class OnTitleChange extends IncidentFormEvent {
  final String title;

  const OnTitleChange(this.title);
}

class OnObservationChange extends IncidentFormEvent {
  final String observation;

  const OnObservationChange(this.observation);
}

class OnStartDateChange extends IncidentFormEvent {
  final String startDate;

  const OnStartDateChange(this.startDate);
}

class OnStartHourChange extends IncidentFormEvent {
  final String startHour;

  const OnStartHourChange(this.startHour);
}

class OnFinishHourChange extends IncidentFormEvent {
  final String finishHour;

  const OnFinishHourChange(this.finishHour);
}

class OnDirectionChange extends IncidentFormEvent {
  final String direction;

  const OnDirectionChange(this.direction);
}

class OnSectorChange extends IncidentFormEvent {
  final String sector;

  const OnSectorChange(this.sector);
}

class OnZoneChange extends IncidentFormEvent {
  final String zone;

  const OnZoneChange(this.zone);
}

class OnAssignedToChange extends IncidentFormEvent {
  final List<String> assignedTo;

  const OnAssignedToChange(this.assignedTo);
}

class OnPriorityChange extends IncidentFormEvent {
  final String priority;

  const OnPriorityChange(this.priority);
}

class OnTagsChange extends IncidentFormEvent {
  final List<String>? tags;

  const OnTagsChange(this.tags);
}

class OnPhotosChange extends IncidentFormEvent {
  final List<String>? photos;

  const OnPhotosChange(this.photos);
}

class OnDocumentsChange extends IncidentFormEvent {
  final List<String>? documents;

  const OnDocumentsChange(this.documents);
}

class OnAudiosChange extends IncidentFormEvent {
  final List<String>? audios;

  const OnAudiosChange(this.audios);
}

class OnDueDateChange extends IncidentFormEvent {
  final String dueDate;

  const OnDueDateChange(this.dueDate);
}


class OnSubmitted extends IncidentFormEvent {}

class OnSave extends IncidentFormEvent {
  const OnSave();
}
class OnUpdate extends IncidentFormEvent {
  const OnUpdate();
}


// Crud incidents events

class OnGetIncidents extends IncidentFormEvent {}

class OnDeleteIncident extends IncidentFormEvent {
  final String recordId;
  OnDeleteIncident({required this.recordId});
}

class OnSetCurrentIncident extends IncidentFormEvent {
  final Incident incident;
  const OnSetCurrentIncident({required this.incident});
}


class OnGetIncidentsByTitle extends IncidentFormEvent {
  final String value;
  const OnGetIncidentsByTitle({required this.value});
}

class OnGetIncidentByRecordId extends IncidentFormEvent {
  final String recordId;
  OnGetIncidentByRecordId({required this.recordId});
}

class OnGetPhotosUrlsByRecordId extends IncidentFormEvent {
  final String recordId;
  OnGetPhotosUrlsByRecordId({required this.recordId});
}

class OnGetDocumentsUrlsByRecordId extends IncidentFormEvent {
  final String recordId;
  OnGetDocumentsUrlsByRecordId({required this.recordId});
}

class OnGetVoiceNotesUrlsByRecordId extends IncidentFormEvent {
  final String recordId;
  OnGetVoiceNotesUrlsByRecordId({required this.recordId});
}


// photos
class OnUpdatePhotos extends IncidentFormEvent {
  final String recordId;
  final List<String> photos;
  OnUpdatePhotos({required this.recordId, required this.photos});
}

class OnDeletePhoto extends IncidentFormEvent {
  final String recordId;
  final int index;
  OnDeletePhoto({required this.recordId, required this.index});
}

// audios

class OnUpdateAudios extends IncidentFormEvent {
  final String recordId;
  final List<String> audios;
  OnUpdateAudios({required this.recordId, required this.audios});
}

class OnDeleteAudio extends IncidentFormEvent {
  final String recordId;
  final int index;
  OnDeleteAudio({required this.recordId, required this.index});
}

//documents

class OnUpdateDocuments extends IncidentFormEvent {
  final String recordId;
  final List<String> documents;
  OnUpdateDocuments({required this.recordId, required this.documents});
}

class OnDeleteDocument extends IncidentFormEvent {
  final String recordId;
  final int index;
  OnDeleteDocument({required this.recordId, required this.index});
}





