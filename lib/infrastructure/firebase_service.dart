import 'package:firebase_auth/firebase_auth.dart';
import 'package:tithe_box/domain/models/models.dart';
import 'package:tithe_box/domain/services/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServiceImpl implements FirebaseService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference collection = FirebaseFirestore.instance.collection('users');

  @override
  Future<void> saveUserCredentials(UserModel userModel) async {
    final uid = auth.currentUser!.uid;
    await collection.doc(uid).set(userModel.toJson().update("uid", (value) => uid));
  }

  @override
  Future<UserModel> getUserCredentials() async {
    final uid = auth.currentUser!.uid;
    final data = await collection.doc(uid).get().then((value) {
      return UserModel.fromJson(value as Map<String, dynamic>);
    });
    return data;
  }
}