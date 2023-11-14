import "package:crowdy/src/features/auth/data/models/crowdy_user_model.dart";
import "package:crowdy/src/features/auth/data/sources/supabase_services.dart";
import "package:crowdy/src/features/auth/domain/entities/crowdy_user_entity.dart";
import "package:supabase_flutter/supabase_flutter.dart";

import "../../domain/repos/auth_repo.dart";

class AuthRepoImpl implements AuthRepo {
  @override
  Future<AuthResponse> signInUser({
    required String email,
    required String password,
  }) async {
    return SupabaseServices.signIn(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signOutUser() async {
    await SupabaseServices.signOut();
  }

  @override
  Future<AuthResponse> signUpUser({required CrowdyUserEntity user}) async {
    final CrowdyUserModel userModel = CrowdyUserModel.fromEntity(
      entity: user,
    );
    return SupabaseServices.signUp(map: userModel.toMap());
  }
}
