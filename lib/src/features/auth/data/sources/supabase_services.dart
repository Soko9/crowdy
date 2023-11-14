import "dart:async";
import "package:flutter_config/flutter_config.dart";
import "package:supabase_flutter/supabase_flutter.dart";

class SupabaseServices {
  SupabaseServices._();

  static late final GoTrueClient _authClient;

  static Session? get session => _authClient.currentSession;
  static User? get user => _authClient.currentUser;
  static Map<String, dynamic> get data =>
      _authClient.currentUser!.userMetadata!;

  static initServices() async {
    await Supabase.initialize(
      url: FlutterConfig.get("URL"),
      anonKey: FlutterConfig.get("ANON_KEY"),
      authFlowType: AuthFlowType.pkce,
    );
    _authClient = Supabase.instance.client.auth;
  }

  static Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    return _authClient.signInWithPassword(
      email: email,
      password: password,
    );
  }

  static Future<AuthResponse> signUp({
    required Map<String, dynamic> map,
  }) async {
    return _authClient.signUp(
      email: map["email"],
      password: map["password"],
      data: map,
    );
  }

  static Future<void> signOut() async {
    await _authClient.signOut();
  }
}
