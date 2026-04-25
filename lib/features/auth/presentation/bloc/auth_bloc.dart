import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/storage/local_storage.dart';
import '../../data/models/user_model.dart';

/// EVENTS
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthLoginRequested extends AuthEvent {
  final String email; // using field name from UI
  final String password;

  const AuthLoginRequested({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}

class AuthCheckRequested extends AuthEvent {
  const AuthCheckRequested();
}
/// STATES
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final UserModel user;

  const AuthAuthenticated({required this.user});

  @override
  List<Object?> get props => [user];
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;

  const AuthError({required this.message});

  @override
  List<Object?> get props => [message];
}

/// BLOC
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Dio dio = Dio();

  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequested>(_onLogin);
    on<AuthLogoutRequested>(_onLogout);
    on<AuthCheckRequested>(_onCheck);
  }

  Future<void> _onLogin(
      AuthLoginRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());

    try {
      final response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.login}',
        data: {
          "username": event.email.trim(),
          "password": event.password.trim(),
        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        ),
      );

      final data = response.data;

      final access = data["access"];
      final refresh = data["refresh"];

      if (access == null) {
        emit(const AuthError(message: "Login failed"));
        return;
      }

      // Optional token save later
      final user = UserModel.demoSuperAdmin;

      emit(AuthAuthenticated(user: user));
    } catch (e) {
      emit(AuthError(message: "Login Error: $e"));
    }
  }

  Future<void> _onLogout(
      AuthLogoutRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthUnauthenticated());
  }

  Future<void> _onCheck(
      AuthCheckRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthUnauthenticated());
  }
}