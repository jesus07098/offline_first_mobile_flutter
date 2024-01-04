part of 'task_bloc.dart';

enum FormStatus { invalid, valid, validating, posting }

class TaskFormState extends Equatable {
  const TaskFormState(
      {this.formStatus = FormStatus.invalid,
      this.title = const Title.pure(),
      this.description = const Description.pure(),
      this.createdBy = const CreatedBy.pure(),
      this.assignedTo = const [],
      this.dueDate = const DueDate.pure(),
      this.files = const [],
      this.initDate = const InitDate.pure(),
      this.priority = '',
      this.vehicleId = '',
      this.isValid = false});

  final FormStatus formStatus;
  final bool isValid;
  final Title title;
  final Description description;
  final CreatedBy createdBy;
  final InitDate initDate;
  final DueDate dueDate;
  final List<String> assignedTo;
  final String priority;
  final String vehicleId;
  final List<FileElement> files;

  TaskFormState copyWith(
          {FormStatus? formStatus,
          bool? isValid,
          Title? title,
          Description? description,
          CreatedBy? createdBy,
          InitDate? initDate,
          DueDate? dueDate,
          List<String>? assignedTo,
          String? priority,
          String? vehicleId,
          List<FileElement>? files}) =>
      TaskFormState(
          formStatus: formStatus ?? this.formStatus,
          isValid: isValid ?? this.isValid,
          title: title ?? this.title,
          description: description ?? this.description,
          createdBy: createdBy ?? this.createdBy,
          initDate: initDate ?? this.initDate,
          dueDate: dueDate ?? this.dueDate,
          assignedTo: assignedTo ?? this.assignedTo,
          priority: priority ?? this.priority,
          vehicleId: vehicleId ?? this.vehicleId);

  @override
  List<Object> get props => [
        title,
        description,
        createdBy,
        initDate,
        dueDate,
        assignedTo,
        priority,
        vehicleId,
        files,
        isValid
      ];
}

