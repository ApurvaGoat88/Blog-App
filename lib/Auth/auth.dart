import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? currentUser = FirebaseAuth.instance.currentUser;

  Stream<User?> get authState => _firebaseAuth.authStateChanges();

  Future<void> signIn({required String email, required String pass}) async {
    try {
      UserCredential _user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: pass);
      currentUser = _user.user;
    } on FirebaseAuthException catch (e) {
      print(e);
    }
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
