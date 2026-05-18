import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/users/models/user_model.dart';
import 'package:firebase_project/users/services/user_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserService _userService = UserService();
  User? get currentUser => _auth
      .currentUser; //if user is logged in, return the user, else return null

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<void> register({
    required String email,
    required String password,
    required String name,
    String? phoneNumber,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserModel newUser = UserModel(
        uid: _auth.currentUser!.uid,
        email: email,
        name: name,
        phoneNumber: phoneNumber,
        userRole: 'user',
      );
      await _userService.createUser(newUser);
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  Future<UserModel?> getCurrentUser() async {
    if (currentUser != null) {
      return await _userService.getUser(currentUser!.uid);
    }
    return null;
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }
}
