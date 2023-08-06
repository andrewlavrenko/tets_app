import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable()
class AuthSource {

  static const authStateKey = 'auth_state_key';

  Future<void> auth({required String email, required String password}) async {
    try {
      final auth = FirebaseAuth.instance;
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _saveAuthState();
    } catch (_) {
      rethrow;
    }
  }

  Future<void> _saveAuthState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(authStateKey, true);
    } catch (_) {
      rethrow;
    }
  }

  Future<bool> getAuthState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userCredential = prefs.getBool(authStateKey);
      if (userCredential != null) {
        return userCredential;
      } else {
        return false;
      }
    } catch (_) {
      rethrow;
    }
  }

}
