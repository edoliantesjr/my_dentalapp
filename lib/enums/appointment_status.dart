enum AppointmentStatus {
  
  Declined,
  Approved,
  Cancelled,
  Request,
}

AppointmentStatus getAppointmentStatus(String appointmentStatus) {
  switch (appointmentStatus) {
    case 'APPROVED':
      return AppointmentStatus.Approved;

    case 'CANCELLED':
      return AppointmentStatus.Cancelled;


    case 'DECLINED':
      return AppointmentStatus.Declined;

    case 'REQUEST':
      return AppointmentStatus.Request;

    default:
      return AppointmentStatus.Request;
  }
}

extension Ext on AppointmentStatus {
  String get name {
    switch (this) {
      case AppointmentStatus.Approved:
        return 'APPROVED';

      case AppointmentStatus.Cancelled:
        return 'CANCELLED';

      case AppointmentStatus.Declined:
        return 'DECLINED';

      case AppointmentStatus.Request:
        return 'REQUEST';

      default:
        return 'ERROR';
    }
  }

   String get options {
    switch (this) {
      case AppointmentStatus.Approved:
        return 'APPROVE';

      case AppointmentStatus.Cancelled:
        return 'CANCEL';

      case AppointmentStatus.Declined:
        return 'DECLINE';

      case AppointmentStatus.Request:
        return 'REQUEST';

      default:
        return 'ERROR';
    }
  }
}
