part of 'entities_bloc.dart';

enum EntityStatus {
  none,
  waiting,
  sending,
  established,
}

class EntitiesState extends Equatable {
  final EntityStatus status;
  final String message;
  final EmployeeData? currentEmployee;
  final List<EmployeeData> employees;
  final List<EmployeeData>? assignedEmployees;
  const EntitiesState(
      {this.status = EntityStatus.none,
      this.message = '',
      this.employees = const [],
      this.assignedEmployees = const [],
      this.currentEmployee});

  EntitiesState copyWith(
      {EntityStatus? status,
      String? message,
      List<EmployeeData>? employees,
      EmployeeData? Function()? currentEmployee,
      List<EmployeeData>? Function()? assignedEmployees}) {
    return EntitiesState(
        status: status ?? this.status,
        message: message ?? this.message,
        employees: employees ?? this.employees,
        currentEmployee:
            currentEmployee != null ? currentEmployee() : this.currentEmployee,
        assignedEmployees: assignedEmployees != null
            ? assignedEmployees()
            : this.assignedEmployees);
  }

  @override
  List<Object?> get props =>
      [status, message, employees, currentEmployee, assignedEmployees];
}
