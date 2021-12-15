import 'package:dentalapp/core/service/session_service/session_service.dart';
import 'package:dentalapp/models/session/session_model.dart';
import 'package:get_storage/get_storage.dart';

class SessionServiceImpl extends SessionService {
  final _myStorage = GetStorage('MyLocalDB');

  @override
  Future<void> saveSession({
    bool? isRunFirstTime,
    bool? isLoggedIn,
    bool? isAccountSetupDone,
  }) async {
    _myStorage.write('isRunFirstTime', isRunFirstTime ?? true);
    _myStorage.write('isLoggedIn', isLoggedIn ?? false);
    _myStorage.write('isAccountSetupDone', isAccountSetupDone ?? false);
  }

  @override
  Future<SessionModel> getSession() async {
    bool isRunFirstTime = await _myStorage.read('isRunFirstTime') ?? true;
    bool isLoggedIn = await _myStorage.read('isLoggedIn') ?? true;
    bool isAccountSetupDone =
        await _myStorage.read('isAccountSetupDone') ?? false;

    return SessionModel(
      isRunFirstTime: isRunFirstTime,
      isLoggedIn: isLoggedIn,
      isAccountSetupDone: isAccountSetupDone,
    );
  }
}
