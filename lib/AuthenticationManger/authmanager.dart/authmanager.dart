import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase/supabase.dart';

import '../../main.dart';

class AuthManger {
  final client = Get.find<SupabaseClient>();

  //create new user with email and password
  Future<GotrueSessionResponse> createUserWithEmailAndPassword(
      String name, String email, String password) async {
    final user = await client.auth.signUp(email, password);
    final insertUserInfo = await client.from('users').insert([
      {"Name": name, "Email": email, "UID": user.user?.id}
    ]).execute();

    return user;
  }

  //log in with existing passowrd

  Future<GotrueSessionResponse> logInWithExistingAccount(
      String email, String password) async {
    final response = await client.auth.signIn(email: email, password: password);
    box.write('loggedIN', true);

    return response;
  }

  Future<GotrueResponse> logOut() async {
    final resp = await client.auth.signOut();
    return resp;
  }
}
