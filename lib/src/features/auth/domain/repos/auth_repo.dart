import "package:crowdy/src/features/auth/domain/entities/crowdy_user_entity.dart";
import "package:supabase_flutter/supabase_flutter.dart";

abstract class AuthRepo {
  Future<AuthResponse> signUpUser({required CrowdyUserEntity user});
  Future<AuthResponse> signInUser({
    required String email,
    required String password,
  });
  Future<void> signOutUser();
}
