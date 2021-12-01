enum AppointmentStatus {
  Ongoing,
  Cancelled,
  Done,
  Pending,
  Error,
}

AppointmentStatus getAppointmentStatus(String appointmentStatus) {
  switch (appointmentStatus) {
    case 'DONE':
      return AppointmentStatus.Done;

    case 'CANCELLED':
      return AppointmentStatus.Cancelled;

    case 'ONGOING':
      return AppointmentStatus.Ongoing;

    case 'PENDING':
      return AppointmentStatus.Pending;

    default:
      return AppointmentStatus.Error;
  }
}

extension Ext on AppointmentStatus {
  String get name {
    switch (this) {
      case AppointmentStatus.Ongoing:
        return 'ONGOING';

      case AppointmentStatus.Cancelled:
        return 'CANCELLED';

      case AppointmentStatus.Done:
        return 'DONE';

      case AppointmentStatus.Pending:
        return 'PENDING';

      default:
        return 'ERROR';
    }
  }
}
