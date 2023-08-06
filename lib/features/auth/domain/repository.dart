abstract class AuthRepository {
  Future<void> auth({required String email, required String password});
  Future<bool> getAuthState();
}
