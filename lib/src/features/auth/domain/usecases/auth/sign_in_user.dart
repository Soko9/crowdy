import "package:crowdy/src/features/auth/domain/repos/auth_repo.dart";
import "package:supabase_flutter/supabase_flutter.dart";

class SignInUser {
  final AuthRepo _authRepo;

  const SignInUser({required AuthRepo repo}) : _authRepo = repo;

  Future<AuthResponse> call({
    required String email,
    required String password,
  }) async {
    return _authRepo.signInUser(
      email: email,
      password: password,
    );
  }
}
