import 'package:dentalapp/models/auth_response/auth_response_model.dart';
import 'package:dentalapp/models/user_model/user_model.dart';

abstract class FirebaseAuthService {
  Future<AuthResponse> loginWithEmail(
      {required String email, required String password});

  Future<AuthResponse> signUpWithEmail({
    required String email,
    required String password,
  });

  Future<AuthResponse> loginWithGoogle();

  Future<AuthResponse> loginWithFacebook();

  Future<void> logOut();

  Future<bool> sendEmailVerification();

  Future<void> createUserIfNotExist(UserModel user);

  Future<void> saveTokenToDatabase({required String token});
}
