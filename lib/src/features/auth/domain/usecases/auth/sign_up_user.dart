import "package:crowdy/src/features/auth/domain/entities/crowdy_user_entity.dart";
import "package:crowdy/src/features/auth/domain/repos/auth_repo.dart";
import "package:supabase_flutter/supabase_flutter.dart";

class SignUpUser {
  final AuthRepo _authRepo;

  const SignUpUser({required AuthRepo repo}) : _authRepo = repo;

  Future<AuthResponse> call({required CrowdyUserEntity user}) async {
    return _authRepo.signUpUser(user: user);
  }
}
