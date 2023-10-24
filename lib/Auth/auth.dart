import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authState => _firebaseAuth.authStateChanges();

  Future<void> signIn({required String email, required String pass}) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: pass);
  }

  Future<void> signUp({required String email, required String pass}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: pass);
    } catch (e) {
      print('error');
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
