import 'package:dentalapp/app/app.locator.dart';
import 'package:dentalapp/core/service/firebase_auth/firebase_auth_service.dart';
import 'package:dentalapp/core/service/session_service/session_service.dart';
import 'package:dentalapp/models/response_model/auth_response_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthServiceImpl extends FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final sessionService = locator<SessionService>();
  String errorMessage = '';

  // final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  // GoogleSignInAccount? googleSignInAccount;
  // GoogleSignInAuthentication? googleSignInAuthentication;

  @override
  Future<AuthResponse> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return AuthResponse.success(authResult.user!);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          errorMessage = "Not A Valid Email Acct.";
          break;
        case "weak-password":
          errorMessage = "Password should be minimum of 8 characters.";
          break;
        case "email-already-in-use":
          errorMessage = "Email is already in use. Try logging in.";
          break;
        default:
          errorMessage = "There's an error encountered on our end. "
              "Please try again later.";
          break;
      }
      return AuthResponse.error(errorMessage);
    }
  }

  @override
  Future<AuthResponse> loginWithEmail(
      {required String email, required String password}) async {
    try {
      UserCredential? authResult = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      if (authResult.user != null) {
        return AuthResponse.success(authResult.user!);
      } else {
        return AuthResponse.error('Unknown error');
      }
    } on FirebaseException catch (e) {
      switch (e.code) {
        case "unknown":
          errorMessage = e.message!;
          break;
        case "invalid-email":
          errorMessage = "Invalid Email Account. Please try again.";
          break;
        case "user-not-found":
          errorMessage =
              "No account associated with this email. Please try again.";
          break;
        case "wrong-password":
          errorMessage = "Incorrect password. Please try again.";
          break;
        default:
          errorMessage = 'Network Error';
          break;
      }
      return AuthResponse.error(errorMessage);
    }
  }

  @override
  Future<bool> sendEmailVerification() async {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser != null && !currentUser.emailVerified) {
      await currentUser.sendEmailVerification();
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<AuthResponse> loginWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();
    final googleAuth = await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    UserCredential authResult =
        await _firebaseAuth.signInWithCredential(credential);

    if (authResult.credential != null) {
      return AuthResponse.success(authResult.user!);
    } else {
      return AuthResponse.error('Error Signing In');
    }
  }

  @override
  Future<AuthResponse> loginWithFacebook() async {
    throw Exception();
  }

  @override
  Future<void> logOut() async {
    if (_firebaseAuth.currentUser != null) {
      _firebaseAuth.signOut();
      sessionService.clearSession();
    }
  }
}
