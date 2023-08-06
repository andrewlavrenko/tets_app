import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:test_app/features/auth/domain/repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@Injectable()
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;
  AuthBloc(this.repository) : super(AuthInitial()) {
    on<AuthorizeEvent>(_onAuthorizeEvent);
  }

  void _onAuthorizeEvent(AuthorizeEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await repository.auth(email: event.email, password: event.password).then(
          (weather) => emit(AuthLoaded()),
          onError: (error) => emit(AuthError()),
        );
  }
}
