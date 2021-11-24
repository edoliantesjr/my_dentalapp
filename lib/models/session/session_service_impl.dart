import 'package:dentalapp/core/service/session_service/session_service.dart';
import 'package:dentalapp/models/session/session_model.dart';
import 'package:get_storage/get_storage.dart';

class SessionServiceImpl extends SessionService {
  final _myStorage = GetStorage('MyLocalDB');

  @override
  Future<void> saveSession(
      {required bool isRunFirstTime, required bool isLoggedIn}) async {
    _myStorage.write('isRunFirstTime', isRunFirstTime);
    _myStorage.write('isLoggedIn', isLoggedIn);
  }

  @override
  Future<SessionModel> getSession() async {
    bool isRunFirstTime = _myStorage.read('isRunFirstTime') ?? true;
    bool isLoggedIn = _myStorage.read('isLoggedIn') ?? true;

    return SessionModel(isRunFirstTime: isRunFirstTime, isLoggedIn: isLoggedIn);
  }
}
