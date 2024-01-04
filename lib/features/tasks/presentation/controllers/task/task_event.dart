part of 'task_bloc.dart';

abstract class TaskFormEvent  {
  const TaskFormEvent();
}

class OnTitleChanged extends TaskFormEvent{
final String title;
  OnTitleChanged(this.title);
}

class OnDescriptionChanged extends TaskFormEvent{
  final String description;
  OnDescriptionChanged(this.description);
}

class OnCreatedByChanged extends TaskFormEvent{

  final String createdBy;
  OnCreatedByChanged(this.createdBy);
}

class OnInitDateChanged extends TaskFormEvent{
  final DateTime initDate;
  OnInitDateChanged(this.initDate);
}
class OnDueDateChanged extends TaskFormEvent{
  final DateTime dueDate;
  OnDueDateChanged(this.dueDate);
}
