import 'dart:developer';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/data/services/file_manager_service_impl.dart';
import '../../../../../core/data/services/key_value_storage_service.dart';
import '../../../../../core/data/services/location_service.dart';
import '../../../../../core/presentation/inputs/inputs.dart';
import '../../../../../core/utils/utils.dart';
import '../../../domain/entities/incident.dart';
import '../../../domain/repositories/local/incident_local_repository.dart';
import '../../inputs/inputs.dart';

part 'incident_form_event.dart';
part 'incident_form_state.dart';

class IncidentFormBloc extends Bloc<IncidentFormEvent, IncidentFormState> {
  IncidentFormBloc(
      {required IncidentLocalRepository incidentLocalRepository,
      required Incident? incident,
      required KeyValueStorageService keyValueStorageService})
      : _incidentLocalRepository = incidentLocalRepository,
        _keyValueStorageService = keyValueStorageService,
        super(const IncidentFormState()) {
    on<OnVehicleChange>(_onVehicleChange);
    on<OnCircuitChange>(_onCircuitChange);
    on<OnReportedByChange>(_onReportedByChange);
    on<OnTitleChange>(_onTitleChange);
    on<OnObservationChange>(_onObservationChange);
    on<OnStartDateChange>(_onStartDateChange);
    on<OnStartHourChange>(_onStartHourChange);
    on<OnFinishHourChange>(_onFinishHourChange);
    on<OnDirectionChange>(_onDirectionChange);
    on<OnSectorChange>(_onSectorChange);
    on<OnZoneChange>(_onZoneChange);
    on<OnAssignedToChange>(_onAssignedToChange);
    on<OnPriorityChange>(_onPriorityChange);
    on<OnTagsChange>(_onTagsChange);
    on<OnPhotosChange>(_onPhotosChange);
    on<OnDocumentsChange>(_onDocumentsChange);
    on<OnAudiosChange>(_onAudiosChange);
    on<OnDueDateChange>(_onDueDateChange);
    on<OnTypeIncidentChange>(_onTypeIncidentChange);
    on<OnGetIncidents>(_onGetIncidents);
    on<OnGetIncidentsByTitle>(_onGetIncidentsByTitle);
    on<OnGetIncidentByRecordId>(_onGetIncidentByRecordId);
    on<OnGetPhotosUrlsByRecordId>(_onGetPhotosUrlsByRecordId);
    on<OnGetDocumentsUrlsByRecordId>(_onGetDocumentsUrlsByRecordId);
    on<OnGetVoiceNotesUrlsByRecordId>(_onGetVoiceNotesUrlsByRecordId);
    on<OnSetCurrentIncident>(_onSetCurrentIncident);
    on<OnUpdatePhotos>(_onUpdatePhotos);
    on<OnUpdateAudios>(_onUpdateAudios);
    on<OnUpdateDocuments>(_onUpdateDocuments);
    on<OnDeletePhoto>(_onDeletePhoto);
    on<OnDeleteAudio>(_onDeleteAudio);
    on<OnDeleteDocument>(_onDeleteDocument);
    on<OnDeleteIncident>(_onDeleteIncident);
    on<OnSubmitted>(_onSubmitted);
    on<OnSave>(_onSave);
    on<OnUpdate>(_onUpdate);
    if (incident != null) {
      add(OnSetCurrentIncident(incident: incident));
    }
  }
  final IncidentLocalRepository _incidentLocalRepository;
  final KeyValueStorageService _keyValueStorageService;

  void _onSubmitted(OnSubmitted event, Emitter<IncidentFormState> emit) {
    final now = DateTime.now();
    emit(state.copyWith(
        circuit: Circuit.dirty(state.circuit.value),
        vehicle: Vehicle.dirty(state.vehicle.value),
        typeIncident: TypeIncident.dirty(state.typeIncident.value),
        reportedBy: ReportedBy.dirty(state.reportedBy.value),
        title: TitleInspec.dirty(state.title.value),
        direction: Direction.dirty(state.direction.value),
        assignedTo: AssignedTo.dirty(state.assignedTo.value),
        priority: Priority.dirty(state.priority.value),
        sector: Sector.dirty(state.sector.value),
        isFormPosted: true,
        startDate: Date.dirty(DateManager.formatDate(
            DateTime.parse(state.startDate.value ?? now.toString()))),
        startHour:
            Hour.dirty(state.startHour.value ?? DateFormat.jm().format(now)),
        dueDate: Date.dirty(DateManager.formatDate(
            DateTime.parse(state.dueDate.value ?? now.toString()))),
        finishHour:
            Hour.dirty(state.finishHour.value ?? DateFormat.jm().format(now))));
  }

  _onSave(OnSave event, Emitter<IncidentFormState> emit) async {
    final dateNow = DateTime.now().toString();
    final String uuid = const Uuid().v4();
    final userId = await _keyValueStorageService.getValue<String>('userId');
    try {
      if (state.allFieldValid) {
        Position position = await getLocation();

        //almaceno los archivos en directorios de la app y obtengo su ruta en la app
        await _storeFiles(emit);

        // Creo la incidencia
        _incidentLocalRepository.createIncident(Incident(
            creation: dateNow,
            vehicleId: state.vehicle.value,
            recordId: uuid,
            circuitNumber: state.circuit.value,
            reportedById: state.reportedBy.value,
            issueTypeId: state.typeIncident.value,
            title: state.title.value,
            body: state.observation,
            startDate: DateTime.parse(state.startDate.value!).toString(),
            startTime: state.startHour.value!,
            endDate: DateTime.parse(state.dueDate.value!).toString(),
            endTime: state.finishHour.value!,
            address: state.direction.value,
            sector: state.sector.value,
            longitude: position.longitude.toString(),
            latitude: position.latitude.toString(),
            labels: state.tags,
            assignedContactsId: state.assignedTo.value,
            priorityId: state.priority.value,
            expirationDate:
                DateTime.parse(state.dueDate.value ?? dateNow).toString(),
            isSynchronized: false,
            isVoid: false,
            photos: convertUrlsToDocuments(
                latitude: position.latitude.toString(),
                longitude: position.longitude.toString(),
                userId: userId ?? 'unknow',
                urlList: state.photos,
                creationDate: dateNow,
                documentType: 'photo',
                recordId: uuid),
            documents: convertUrlsToDocuments(
                latitude: position.latitude.toString(),
                longitude: position.longitude.toString(),
                userId: userId ?? 'unknow',
                urlList: state.documents,
                creationDate: dateNow,
                documentType: 'document',
                recordId: uuid),
            voiceNotes: convertUrlsToDocuments(
                latitude: position.latitude.toString(),
                longitude: position.longitude.toString(),
                userId: userId ?? 'unknow',
                urlList: state.audios,
                creationDate: dateNow,
                recordId: uuid,
                documentType: 'voice_note')));
        emit(state.copyWith(
            message: 'Incidencia guardada correctamente',
            formStatus: FormzSubmissionStatus.success,
            isIntentSave: false));

        _cleanFormFields(emit);
        return;
      }
      //No llenó los campos del formulario de forma correcta
      emit(state.copyWith(
          message: 'No se pudo guardar la incidencia, verifique los datos',
          formStatus: FormzSubmissionStatus.canceled,
          isIntentSave: false));
    } catch (e) {
      emit(state.copyWith(
        message:
            'Ocurrió un error al guardar en la Base de Datos local, intente más tarde $e',
        formStatus: FormzSubmissionStatus.failure,
      ));
    }
  }

  _onUpdate(OnUpdate event, Emitter<IncidentFormState> emit) async {
    final dateNow = DateTime.now().toString();

    try {
      if (state.allFieldValid) {
        Position position = await getLocation();

        //almaceno los archivos en directorios de la app y obtengo su ruta en la app
        await _storeFiles(emit);

        // Creo la incidencia
        _incidentLocalRepository.updateIncident(Incident(
          creation: dateNow,
          vehicleId: state.vehicle.value,
          recordId: state.incidentByRecordId!.recordId,
          circuitNumber: state.circuit.value,
          reportedById: state.reportedBy.value,
          issueTypeId: state.typeIncident.value,
          title: state.title.value,
          body: state.observation,
          startDate: DateTime.parse(state.startDate.value!).toString(),
          startTime: state.startHour.value!,
          endDate: DateTime.parse(state.dueDate.value!).toString(),
          endTime: state.finishHour.value!,
          address: state.direction.value,
          sector: state.sector.value,
          longitude: position.longitude.toString(),
          latitude: position.latitude.toString(),
          labels: state.tags,
          assignedContactsId: state.assignedTo.value,
          priorityId: state.priority.value,
          expirationDate:
              DateTime.parse(state.dueDate.value ?? dateNow).toString(),
          isSynchronized: false,
          isVoid: false,
        ));
        emit(state.copyWith(
            message: 'Incidencia actualizada correctamente',
            formStatus: FormzSubmissionStatus.success,
            isIntentSave: false));

        _cleanFormFields(emit);
        return;
      }
      //No llenó los campos del formulario de forma correcta
      emit(state.copyWith(
          message: 'No se pudo actualizar la incidencia, verifique los datos',
          formStatus: FormzSubmissionStatus.canceled,
          isIntentSave: false));
    } catch (e) {
      emit(state.copyWith(
        message:
            'Ocurrió un error al actualizar en la Base de Datos local, intente más tarde $e',
        formStatus: FormzSubmissionStatus.failure,
      ));
    }
  }

  void _cleanFormFields(Emitter<IncidentFormState> emit) {
    //Limpiar valores del form
    emit(state.copyWith(
        photos: () => [],
        audios: () => [],
        documents: [],
        typeIncident: const TypeIncident.pure(),
        vehicle: const Vehicle.pure(),
        circuit: const Circuit.pure(),
        reportedBy: const ReportedBy.pure(),
        title: const TitleInspec.pure(),
        observation: '',
        direction: const Direction.pure(),
        sector: const Sector.pure(),
        zone: '',
        assignedTo: const AssignedTo.pure(),
        priority: const Priority.pure(),
        tags: [],
        formStatus: FormzSubmissionStatus.initial));
  }

  void _onVehicleChange(
    OnVehicleChange event,
    Emitter<IncidentFormState> emit,
  ) {
    final vehicle = Vehicle.dirty(event.assetId);
    emit(state.copyWith(
        vehicle: vehicle,
        isValid: Formz.validate([
          vehicle,
          state.reportedBy,
          state.typeIncident,
          state.title,
          state.startDate,
          state.startHour,
          state.direction,
          state.sector,
          state.priority,
          state.dueDate
        ])));
  }

  void _onTypeIncidentChange(
    OnTypeIncidentChange event,
    Emitter<IncidentFormState> emit,
  ) {
    final typeIncident = TypeIncident.dirty(event.typeIncident);
    emit(state.copyWith(
        typeIncident: typeIncident,
        isValid: Formz.validate([
          typeIncident,
          state.reportedBy,
          state.title,
          state.startDate,
          state.startHour,
          state.direction,
          state.sector,
          state.priority,
          state.dueDate
        ])));
  }

  void _onCircuitChange(
    OnCircuitChange event,
    Emitter<IncidentFormState> emit,
  ) {
    final circuit = Circuit.dirty(event.circuit);
    emit(state.copyWith(
        circuit: circuit,
        isValid: Formz.validate([
          state.typeIncident,
          circuit,
          state.reportedBy,
          state.title,
          state.startDate,
          state.startHour,
          state.direction,
          state.sector,
          state.priority,
          state.dueDate
        ])));
  }

  void _onReportedByChange(
    OnReportedByChange event,
    Emitter<IncidentFormState> emit,
  ) {
    final reportedBy = ReportedBy.dirty(event.reportedById);
    emit(state.copyWith(
        reportedBy: reportedBy,
        isValid: Formz.validate([
          state.typeIncident,
          state.circuit,
          reportedBy,
          state.title,
          state.startDate,
          state.startHour,
          state.direction,
          state.sector,
          state.priority,
          state.dueDate
        ])));
  }

  void _onTitleChange(
    OnTitleChange event,
    Emitter<IncidentFormState> emit,
  ) {
    final title = TitleInspec.dirty(event.title);
    emit(state.copyWith(
        title: title,
        isValid: Formz.validate([
          state.typeIncident,
          state.circuit,
          state.reportedBy,
          title,
          state.startDate,
          state.startHour,
          state.direction,
          state.sector,
          state.priority,
          state.dueDate
        ])));
  }

  void _onObservationChange(
    OnObservationChange event,
    Emitter<IncidentFormState> emit,
  ) {
    emit(state.copyWith(observation: event.observation));
  }

  void _onAssignedToChange(
    OnAssignedToChange event,
    Emitter<IncidentFormState> emit,
  ) {
    final assignedTo = AssignedTo.dirty(event.assignedTo);
    emit(state.copyWith(
        assignedTo: assignedTo,
        isValid: Formz.validate([
          state.typeIncident,
          state.circuit,
          state.reportedBy,
          assignedTo,
          state.startDate,
          state.startHour,
          state.direction,
          state.sector,
        ])));
  }

  void _onStartDateChange(
    OnStartDateChange event,
    Emitter<IncidentFormState> emit,
  ) {
    final startDate = Date.dirty(event.startDate);
    emit(state.copyWith(
        startDate: startDate,
        isValid: Formz.validate([
          state.typeIncident,
          state.circuit,
          state.reportedBy,
          state.title,
          startDate,
          state.startHour,
          state.direction,
          state.sector,
          state.priority,
          state.dueDate,
        ])));
  }

  void _onStartHourChange(
    OnStartHourChange event,
    Emitter<IncidentFormState> emit,
  ) {
    final startHour = Hour.dirty(event.startHour);
    emit(state.copyWith(
        startHour: startHour,
        isValid: Formz.validate([
          state.typeIncident,
          state.circuit,
          state.reportedBy,
          startHour,
          state.startDate,
          state.direction,
          state.sector,
          state.priority,
          state.dueDate
        ])));
  }

  void _onDirectionChange(
    OnDirectionChange event,
    Emitter<IncidentFormState> emit,
  ) {
    final direction = Direction.dirty(event.direction);
    emit(state.copyWith(
        direction: direction,
        isValid: Formz.validate([
          state.typeIncident,
          state.circuit,
          state.reportedBy,
          direction,
          state.startDate,
          state.startHour,
          state.sector,
          state.priority,
          state.dueDate
        ])));
  }

  void _onSectorChange(
    OnSectorChange event,
    Emitter<IncidentFormState> emit,
  ) {
    final sector = Sector.dirty(event.sector);
    emit(state.copyWith(
        sector: sector,
        isValid: Formz.validate([
          state.typeIncident,
          state.circuit,
          state.reportedBy,
          sector,
          state.startDate,
          state.startHour,
          state.direction,
          state.priority,
          state.dueDate
        ])));
  }

  void _onZoneChange(
    OnZoneChange event,
    Emitter<IncidentFormState> emit,
  ) {
    emit(state.copyWith(zone: event.zone));
  }

  void _onPriorityChange(
    OnPriorityChange event,
    Emitter<IncidentFormState> emit,
  ) {
    final priority = Priority.dirty(event.priority);
    emit(state.copyWith(
        priority: priority,
        isValid: Formz.validate([
          state.typeIncident,
          state.circuit,
          state.reportedBy,
          priority,
          state.startDate,
          state.startHour,
          state.direction,
          state.sector,
          state.dueDate
        ])));
  }

  void _onDueDateChange(
    OnDueDateChange event,
    Emitter<IncidentFormState> emit,
  ) {
    final dueDate = Date.dirty(event.dueDate);
    emit(state.copyWith(
        dueDate: dueDate,
        isValid: Formz.validate([
          state.typeIncident,
          state.circuit,
          state.reportedBy,
          dueDate,
          state.startDate,
          state.startHour,
          state.direction,
          state.sector,
        ])));
  }

  void _onFinishHourChange(
    OnFinishHourChange event,
    Emitter<IncidentFormState> emit,
  ) {
    final finishHour = Hour.dirty(event.finishHour);
    emit(state.copyWith(
        finishHour: finishHour,
        isValid: Formz.validate([
          state.typeIncident,
          state.circuit,
          state.reportedBy,
          finishHour,
          state.startDate,
          state.startHour,
          state.direction,
          state.sector,
        ])));
  }

  void _onTagsChange(
    OnTagsChange event,
    Emitter<IncidentFormState> emit,
  ) {
    emit(state.copyWith(tags: event.tags));
  }

  void _onPhotosChange(
    OnPhotosChange event,
    Emitter<IncidentFormState> emit,
  ) {
    emit(state.copyWith(photos: () => event.photos));
  }

  void _onDocumentsChange(
      OnDocumentsChange event, Emitter<IncidentFormState> emit) {
    emit(state.copyWith(documents: event.documents));
  }

  void _onAudiosChange(OnAudiosChange event, Emitter<IncidentFormState> emit) {
    emit(state.copyWith(audios: () => event.audios));
    log('Audios en el evento ${event.audios}');
  }

  Future<void> _onGetIncidents(
      OnGetIncidents event, Emitter<IncidentFormState> emit) async {
    try {
      final incidents = await _incidentLocalRepository.getIncidents();
      emit(state.copyWith(incidents: incidents));
    } catch (e) {
      Exception(
          'Ocurrió un error al obtener las incidencias de la BD local $e');
    }
  }

  _onGetPhotosUrlsByRecordId(
      OnGetPhotosUrlsByRecordId event, Emitter<IncidentFormState> emit) async {
    try {
      final photosUrls =
          await _incidentLocalRepository.getPhotoUrlsByRecordId(event.recordId);
      emit(state.copyWith(photos: () => photosUrls));
    } catch (e) {
      Exception(
          'Ocurrió un error al obtener las url de las fotos de incidencia de la BD local $e');
    }
  }

  Future<void> _onGetDocumentsUrlsByRecordId(OnGetDocumentsUrlsByRecordId event,
      Emitter<IncidentFormState> emit) async {
    try {
      final documentsUrls = await _incidentLocalRepository
          .getDocumentUrlsByRecordId(event.recordId);
      emit(state.copyWith(documents: documentsUrls));
    } catch (e) {
      Exception(
          'Ocurrió un error al obtener las url de los documentos de incidencias de la BD local $e');
    }
  }

  Future<void> _onGetVoiceNotesUrlsByRecordId(
      OnGetVoiceNotesUrlsByRecordId event,
      Emitter<IncidentFormState> emit) async {
    try {
      final voiceNotesUrls = await _incidentLocalRepository
          .getVoiceNoteUrlsByRecordId(event.recordId);
      emit(state.copyWith(audios: () => voiceNotesUrls));
    } catch (e) {
      Exception(
          'Ocurrió un error al obtener las url de las notas de voz de incidencias de la BD local $e');
    }
  }

  Future<void> _onDeleteIncident(
      OnDeleteIncident event, Emitter<IncidentFormState> emit) async {
    try {
      await _incidentLocalRepository.deleteIncidentByRecordId(event.recordId);
      emit(state.copyWith(message: 'Incidencia eliminada correctamente'));
    } catch (e) {
      emit(state.copyWith(
          message:
              'La incidencia no pudo ser eliminada de forma correcta, favor intente de nuevo'));
    }
  }

  Future<void> _onGetIncidentsByTitle(
      OnGetIncidentsByTitle event, Emitter<IncidentFormState> emit) async {
    try {
      final incidents = await _incidentLocalRepository
          .getIncidentsByCircuitAndTitle(event.value);
      emit(state.copyWith(incidents: incidents, isSearching: true));
    } catch (e) {
      Exception(
          'Ocurrió un error al obtener las incidencias por titulo de la BD local $e');
    }
  }

  Future<void> _onGetIncidentByRecordId(
      OnGetIncidentByRecordId event, Emitter<IncidentFormState> emit) async {
    try {
      final incident =
          await _incidentLocalRepository.getIncidentByRecordId(event.recordId);

      emit(state.copyWith(incidentByRecordId: incident));
    } catch (e) {
      Exception(
          'Ocurrió un error al obtener las incidencias por titulo de la BD local $e');
    }
  }

  Future<void> _storeFiles(Emitter<IncidentFormState> emit) async {
    // guardando los archivos en directorios de la app
    final appDir = await getApplicationDocumentsDirectory();
    final updatedPhotos = await _copyMediaFiles(state.photos, appDir, 'photos');
    final updatedAudios = await _copyMediaFiles(state.audios, appDir, 'audios');
    final updatedDocuments =
        await _copyMediaFiles(state.documents, appDir, 'documents');

    // Actualiza el estado del BLoC con las nuevas rutas
    emit(state.copyWith(
      photos: () => updatedPhotos,
      audios: () => updatedAudios,
      documents: updatedDocuments,
    ));
  }

  List<Document> convertUrlsToDocuments(
      {required List<String>? urlList,
      required String creationDate,
      required String recordId,
      required String documentType,
      required String latitude,
      required String longitude,
      required String userId}) {
    if (urlList == null) {
      return [];
    }

    List<Document> documentList = [];

    for (String url in urlList) {
      Document document = Document(
          latitude: latitude,
          longitude: longitude,
          recordId: recordId,
          creation: creationDate,
          name: url.split('/').last,
          url: url,
          module: "issue",
          documentType: documentType,
          userId: userId);

      documentList.add(document);
    }

    return documentList;
  }

  Future<List<String>> _copyMediaFiles(
      List<String>? mediaPaths, Directory appDir, String mediaType) async {
    final updatedPaths = <String>[];
    String folderPath = '${appDir.path}/$mediaType';
    Directory(folderPath).createSync(recursive: true);

    if (mediaPaths != null) {
      for (final path in mediaPaths) {
        try {
          final fileName = File(path).uri.pathSegments.last;
          final newFilePath = '${appDir.path}/$mediaType/$fileName';

          // Verifica si el archivo ya existe en el directorio
          final fileExists = await File(newFilePath).exists();

          if (!fileExists) {
            // Solo copia la imagen si no existe en el directorio
            await File(path).copy(newFilePath);
          }

          updatedPaths.add(newFilePath);
        } catch (e) {
          Exception('Error al almacenar archivo $mediaType: $e');
        }
      }
    }

    return updatedPaths;
  }

  Future<void> _onUpdatePhotos(
      OnUpdatePhotos event, Emitter<IncidentFormState> emit) async {
    final userId = await _keyValueStorageService.getValue<String>('userId');
    final dateNow = DateTime.now().toString();
    Position position = await getLocation();
    final appDir = await getApplicationDocumentsDirectory();

    await _incidentLocalRepository.updatePhotosByRecorId(
        event.recordId,
        convertUrlsToDocuments(
            creationDate: dateNow,
            documentType: 'photo',
            latitude: position.latitude.toString(),
            longitude: position.longitude.toString(),
            recordId: event.recordId,
            urlList: await _copyMediaFiles(event.photos, appDir, 'photos'),
            userId: userId ?? 'unknow'));
  }

  Future<void> _onUpdateAudios(
      OnUpdateAudios event, Emitter<IncidentFormState> emit) async {
    final userId = await _keyValueStorageService.getValue<String>('userId');
    final dateNow = DateTime.now().toString();
    Position position = await getLocation();
    final appDir = await getApplicationDocumentsDirectory();
    log(event.audios.toString());
    await _incidentLocalRepository.updateAudiosByRecorId(
        event.recordId,
        convertUrlsToDocuments(
            creationDate: dateNow,
            documentType: 'audio',
            latitude: position.latitude.toString(),
            longitude: position.longitude.toString(),
            recordId: event.recordId,
            urlList: await _copyMediaFiles(event.audios, appDir, 'audios'),
            userId: userId ?? 'unknow'));
  }

  Future<void> _onUpdateDocuments(
      OnUpdateDocuments event, Emitter<IncidentFormState> emit) async {
    final userId = await _keyValueStorageService.getValue<String>('userId');
    final dateNow = DateTime.now().toString();
    Position position = await getLocation();
    final appDir = await getApplicationDocumentsDirectory();

    await _incidentLocalRepository.updateDocumentsByRecorId(
        event.recordId,
        convertUrlsToDocuments(
            creationDate: dateNow,
            documentType: 'document',
            latitude: position.latitude.toString(),
            longitude: position.longitude.toString(),
            recordId: event.recordId,
            urlList:
                await _copyMediaFiles(event.documents, appDir, 'documents'),
            userId: userId ?? 'unknow'));
  }

  Future<void> _onDeletePhoto(
      OnDeletePhoto event, Emitter<IncidentFormState> emit) async {
    FileManagerServiceImpl().deleteFile(state.photos![event.index]);
  }

  Future<void> _onDeleteAudio(
      OnDeleteAudio event, Emitter<IncidentFormState> emit) async {
    FileManagerServiceImpl().deleteFile(state.audios![event.index]);
  }

  Future<void> _onDeleteDocument(
      OnDeleteDocument event, Emitter<IncidentFormState> emit) async {
    FileManagerServiceImpl().deleteFile(state.documents![event.index]);
  }

  void _onSetCurrentIncident(
      OnSetCurrentIncident event, Emitter<IncidentFormState> emit) async {
    final incident = event.incident;

    emit(state.copyWith(
        incidentByRecordId: incident,
        circuit: Circuit.dirty(incident.circuitNumber),
        vehicle: Vehicle.dirty(incident.vehicleId),
        typeIncident: TypeIncident.dirty(incident.issueTypeId),
        reportedBy: ReportedBy.dirty(incident.reportedById),
        title: TitleInspec.dirty(incident.title),
        direction: Direction.dirty(incident.address),
        assignedTo: AssignedTo.dirty(incident.assignedContactsId),
        priority: Priority.dirty(incident.priorityId),
        sector: Sector.dirty(incident.sector),
        startDate: Date.dirty(
            DateManager.formatDate(DateTime.parse(incident.startDate))),
        startHour: Hour.dirty(incident.startTime),
        dueDate: Date.dirty(
            DateManager.formatDate(DateTime.parse(incident.endDate))),
        observation: incident.body,
        tags: incident.labels,
        finishHour: Hour.dirty(incident.endTime)));
  }
}
