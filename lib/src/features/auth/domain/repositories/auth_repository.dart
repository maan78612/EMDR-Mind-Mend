import 'package:emdr_mindmend/src/features/auth/domain/models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

abstract class AuthRepository {
  Future<UserModel> login({required Map<String, dynamic> body});

  Future<void> register({required Map<String, dynamic> body});

  Future<void> forgetPassword({required Map<String, dynamic> body});

  Future<GoogleSignInAccount?> googleLogin();


  Future<AuthorizationCredentialAppleID> appleLogin();

  Future<UserModel> appleSocialLogin({required Map<String, dynamic> body});
  Future<UserModel> googleSocialLogin({required Map<String, dynamic> body});
}
