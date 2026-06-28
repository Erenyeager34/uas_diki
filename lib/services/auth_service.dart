import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> register({
    required String nama,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;

      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'nama': nama,
          'email': email,
          'role': 'kasir',
          'createdAt': Timestamp.now(),
        });
      }

      return null;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          return 'Email sudah terdaftar';

        case 'invalid-email':
          return 'Format email tidak valid';

        case 'weak-password':
          return 'Password terlalu lemah';

        default:
          return e.message ?? 'Terjadi kesalahan';
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      return null;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          return 'Email tidak ditemukan';

        case 'wrong-password':
        case 'invalid-credential':
          return 'Email atau password salah';

        case 'invalid-email':
          return 'Format email tidak valid';

        default:
          return e.message ?? 'Terjadi kesalahan';
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> getUserRole() async {
    User? user = _auth.currentUser;

    if (user == null) return null;

    DocumentSnapshot doc = await _firestore
        .collection('users')
        .doc(user.uid)
        .get();

    if (!doc.exists) {
      return null;
    }

    final data = doc.data() as Map<String, dynamic>;
    return data['role'];
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
