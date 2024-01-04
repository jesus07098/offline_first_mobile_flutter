import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../data/inputs/inputs.dart';
import '../../../domain/entities/task.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskFormBloc extends Bloc<TaskFormEvent, TaskFormState> {
  TaskFormBloc() : super(const TaskFormState()) {
    on<OnTitleChanged>(_onTitleChanged);
    on<OnDescriptionChanged>(_onDescriptionChanged);
    on<OnInitDateChanged>(_onInitDateChanged);
    on<OnDueDateChanged>(_onDueDateChanged);
    on<OnCreatedByChanged>(_onCreatedByChanged);
  }

  void onSubmit() {
    log('Bloc submit $state');
  }

  void _onTitleChanged(
    OnTitleChanged event,
    Emitter<TaskFormState> emit,
  ) {
    final title = Title.dirty(event.title);
    emit(state.copyWith(
        title: title,
        isValid: Formz.validate([
          title,
          state.initDate,
          state.createdBy,
          state.description,
          state.dueDate,
        ])));
  }

  void _onDescriptionChanged(
    OnDescriptionChanged event,
    Emitter<TaskFormState> emit,
  ) {
    final description = Description.dirty(event.description);
    emit(state.copyWith(
        description: description,
        isValid: Formz.validate([
          description,
          state.initDate,
          state.createdBy,
          state.title,
          state.dueDate,
        ])));
  }

  void _onInitDateChanged(
    OnInitDateChanged event,
    Emitter<TaskFormState> emit,
  ) {
    final initDate = InitDate.dirty(event.initDate);

    emit(state.copyWith(
        initDate: initDate,
        isValid: Formz.validate([
          initDate,
          state.createdBy,
          state.title,
          state.dueDate,
        ])));
  }

  void _onDueDateChanged(
    OnDueDateChanged event,
    Emitter<TaskFormState> emit,
  ) {
    final dueDate = DueDate.dirty(event.dueDate);

    emit(state.copyWith(
        dueDate: dueDate,
        isValid: Formz.validate([
          dueDate,
          state.createdBy,
          state.title,
          state.dueDate,
          state.initDate
        ])));
  }

  void _onCreatedByChanged(
    OnCreatedByChanged event,
    Emitter<TaskFormState> emit,
  ) {
    final createdBy = CreatedBy.dirty(event.createdBy);

    emit(state.copyWith(
        createdBy: createdBy,
        isValid: Formz.validate(
            [createdBy, state.title, state.dueDate, state.initDate])));
  }
}
