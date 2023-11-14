import "package:crowdy/src/features/auth/domain/repos/auth_repo.dart";

class SignOutUser {
  final AuthRepo _authRepo;

  const SignOutUser({required AuthRepo repo}) : _authRepo = repo;

  Future<void> call() async {
    await _authRepo.signOutUser();
  }
}
