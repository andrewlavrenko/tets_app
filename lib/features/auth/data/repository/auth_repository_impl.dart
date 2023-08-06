import 'package:injectable/injectable.dart';
import 'package:test_app/features/auth/data/source/auth_source.dart';
import 'package:test_app/features/auth/domain/repository.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final AuthSource _source;
  AuthRepositoryImpl(this._source);

  @override
  Future<void> auth({required String email, required String password}) {
    return _source.auth(email: email, password: password);
  }

  @override
  Future<bool> getAuthState() {
    return _source.getAuthState();
  }
}
