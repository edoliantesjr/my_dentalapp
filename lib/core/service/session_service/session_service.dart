import 'package:dentalapp/models/session/session_model.dart';

abstract class SessionService {
  Future<void> saveSession(
      {required bool isRunFirstTime, required bool isLoggedIn});

  Future<SessionModel> getSession();
}
