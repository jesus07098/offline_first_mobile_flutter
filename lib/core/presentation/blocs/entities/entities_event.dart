part of 'entities_bloc.dart';

class EntitiesEvent {
  const EntitiesEvent();
}

class OnSaveEmployees extends EntitiesEvent {}

class OnGetEmployees extends EntitiesEvent {}

class OnSetCurrentEmployee extends EntitiesEvent {
  final int index;
  const OnSetCurrentEmployee({required this.index});
}

class OnSetCurrentEmployeeUpdating extends EntitiesEvent {
  final EmployeeData employee;
  const OnSetCurrentEmployeeUpdating({required this.employee});
}
class OnClearCurrentEmployee extends EntitiesEvent {}

class OnSetAssignedEmployees extends EntitiesEvent {
  final List<int> indexes;
  const OnSetAssignedEmployees({required this.indexes});
}
class OnSetAssignedEmployeesUpdating extends EntitiesEvent {
  final List<EmployeeData> employees;
   const OnSetAssignedEmployeesUpdating({required this.employees});
}

class OnClearAssignedEmployees extends EntitiesEvent {}