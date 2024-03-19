import 'package:google_sign_in/google_sign_in.dart';
import 'package:pokinia_lending_manager/services/log_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final LogService _logger = LogService('AuthService');
  final supabase = Supabase.instance.client;

  Future<AuthResponse> signInWithGoogle() async {
    const webClientId =
        '678985858364-ebhohvh1e6cntrnl2og305109f6r0j8b.apps.googleusercontent.com';
    const iosClientId =
        '678985858364-uug7ndhbgq44blcbumj285hqu549385j.apps.googleusercontent.com';

    // Google sign in on Android will work without providing the Android
    // Client ID registered on Google Cloud.

    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    return supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  Future initializeDefaultValues(String userId) async {
    try {
      await supabase.rpc('on_user_signed_in', params: {'v_user_id': userId});
    } catch (e) {
      _logger.e(
          'initializeDefaultValues', 'Error initializing default values: $e');
    }
  }
}
