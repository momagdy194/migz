// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gshop/domain/model/model/order_model.dart';
import 'package:gshop/domain/service/helper.dart';
import 'package:gshop/domain/service/tr_keys.dart';
import 'package:gshop/infrastructure/local_storage/local_storage.dart';
import 'package:gshop/infrastructure/repository/auth_repository.dart';
import 'package:gshop/presentation/components/join_dialog.dart';
import 'package:gshop/presentation/route/app_route.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

abstract class FirebaseService {
  FirebaseService._();

  static final FirebaseFirestore store = FirebaseFirestore.instance;

  static Future<String> addDataToCollection(
      {required String collection,
      Map<String, dynamic>? data,
      String? docId}) async {
    final colRef = store.collection(collection);
    if (docId != null) {
      await colRef.doc(docId).set(data ?? {});
      return docId;
    } else {
      final docRef = await colRef.add(data ?? {});
      return docRef.id;
    }
  }

  static Future<void> updateData(
      {required String collection,
      required String docId,
      Map<String, dynamic>? data}) async {
    await store.collection(collection).doc(docId).set(data ?? {});
  }

  static Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      fetchAllDocsData({
    required String collection,
  }) async {
    final querySnapshot = await store.collection(collection).get();
    return querySnapshot.docs;
  }

  static Future<void> deleteAllCollectionDocs({
    required String collection,
  }) async {
    await store.collection(collection).get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
  }

  static Future<void> deleteSingleCollectionDoc(
      {required String collection, required String docId}) async {
    await store.collection(collection).doc(docId).delete();
  }

  static Future<String> getFcmToken() async {
    final firebaseM = FirebaseMessaging.instance;
    firebaseM.requestPermission(
      sound: true,
      alert: true,
      badge: false,
    );
    return await firebaseM.getToken() ?? "";
  }

  static Future<Either<UserCredential, dynamic>> socialGoogle() async {
    print('socialGoogle');
    try {
      print('socialGoogle0000');

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      print('socialGoogle111');

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      print('socialGoogle222');

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      print('socialGoogle333');

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      print('socialGoogle444');

      return Left(userCredential);

    } on Exception catch (e) {
      print('MyException=${e.toString()}');
      return Right(e.toString());
    }
  }

  static Future<Either<UserCredential, dynamic>> socialFacebook() async {
    final fb = FacebookLogin();
    try {
      print("asaasasasas");
      final user = await fb.logIn(permissions: [FacebookPermission.email]);

      print('Facebook login status=${user.status.toString()}');
      final OAuthCredential credential =
          FacebookAuthProvider.credential(user.accessToken?.token ?? "");

      final userObj =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return left(userObj);
    } catch (e) {
      print('MyCatch=${e.toString()}');
      return right(e.toString());
    }
  }

  static Future<Either<UserCredential, dynamic>> socialApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      OAuthProvider oAuthProvider = OAuthProvider("apple.com");
      final AuthCredential credentialApple = oAuthProvider.credential(
        idToken: credential.identityToken,
        accessToken: credential.authorizationCode,
      );

      final userObj =
          await FirebaseAuth.instance.signInWithCredential(credentialApple);
      return left(userObj);
    } catch (e) {
      return right(e.toString());
    }
  }

  static sendCode(
      {required String phone,
      required ValueChanged<String> onSuccess,
      required ValueChanged<String> onError}) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber:formatPhoneNumber(phone) ,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        onError(e.message ?? '');
      },
      codeSent: (String verificationId, int? resendToken) {
        onSuccess(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  static Future<Either<UserCredential, dynamic>> checkCode(
      {required String verificationId, required String code}) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: code,
      );

      final user = await FirebaseAuth.instance.signInWithCredential(credential);
      return left(user);
    } catch (e) {
      return right(e.toString());
    }
  }

  static Future<void> initDynamicLinks(BuildContext context) async {
    final FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

    dynamicLinks.onLink.listen((dynamicLinkData) {
      String link = dynamicLinkData.link.toString();
      if (link.contains("group")) {
        showJoin(context, link.toString());
        return;
      }
      if (link.contains("orders")) {
        if (LocalStorage.getToken().isNotEmpty) {
          int id = int.tryParse(link.substring(link.lastIndexOf("/") + 1)) ?? 0;
          AppRoute.goOrderPage(context, OrderShops(id: id));
          return;
        }
        AppHelper.openDialog(
            context: context, title: AppHelper.getTrn(TrKeys.pleaseTryAgain));
      }
    }).onError((error) {
      debugPrint(error.message);
    });

    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;
    if (deepLink.toString().contains("group")) {
      showJoin(context, deepLink.toString());
      return;
    }
    if (deepLink.toString().contains("orders")) {
      if (LocalStorage.getToken().isNotEmpty) {
        int id = int.tryParse(deepLink
                .toString()
                .substring(deepLink.toString().lastIndexOf("/") + 1)) ??
            0;
        AppRoute.goOrderPage(context, OrderShops(id: id));
        return;
      }
      AppHelper.openDialog(
          context: context, title: AppHelper.getTrn(TrKeys.pleaseTryAgain));
    }
  }

  static showJoin(BuildContext context, String link) {
    AppHelper.showCustomDialog(
        context: context,
        content: JoinDialog(
          link: link,
        ));
  }
}
