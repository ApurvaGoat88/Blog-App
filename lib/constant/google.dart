import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';

class googleAuth {
  Future<UserCredential> signin() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    final _credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);

    return await FirebaseAuth.instance.signInWithCredential(_credential);
  }
}