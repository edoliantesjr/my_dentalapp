import 'package:dentalapp/models/session/session_model.dart';

abstract class SessionService {
  Future<void> saveSession(
      {bool? isRunFirstTime, bool? isLoggedIn, bool? isAccountSetupDone});

  Future<SessionModel> getSession();
}
