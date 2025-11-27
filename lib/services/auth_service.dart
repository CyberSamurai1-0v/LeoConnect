import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Sign in with Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the Google Sign In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credentials
      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      if (userCredential.user?.email == null) {
        throw Exception('No email found in user credentials');
      }

      try {
        // Try to get the user document
        final userDoc = await _firestore
            .collection('users')
            .doc(userCredential.user!.email)
            .get();

        if (!userDoc.exists) {
          // If user doesn't exist, sign them out and return null
          await _auth.signOut();
          await _googleSignIn.signOut();
          return null;
        }

        return userCredential;
      } catch (e) {
        // If there's a permissions error, it might be because the document doesn't exist
        // or the user doesn't have read access
        print('Error checking user in Firestore: $e');
        await _auth.signOut();
        await _googleSignIn.signOut();
        return null;
      }
    } catch (e) {
      print('Error signing in with Google: $e');
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}
