import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/pengunjung/riwayat/filter.dart';

class RiwayatController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadingCreatedata = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Future<QuerySnapshot<Object?>> getData() async {
  //   CollectionReference data = firestore.collection("data");
  //   return data.get();
  // }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUserData() async* {
    String uid = auth.currentUser!.uid;
    yield* firestore.collection("users").doc(uid).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> StreamData() {
    String uid = auth.currentUser!.uid;
    final user_query = firestore
        .collection("datauser")
        .where("user_id", isEqualTo: uid)
        .snapshots();
    return user_query;

    // if (user_query.data()?['role'] == "Pengunjung") {
    //    firestore
    //       .collection("datauser")
    //       .orderBy("date", descending: true)
    //       .limitToLast(5)
    //       .snapshots();
    // } else {
    //   Get.defaultDialog(
    //     title: "Terjadi kesalahan",
    //     middleText: "Tidak dapat merubah data",
    //     textConfirm: "Kembali",
    //     onConfirm: () {
    //       Get.back();
    //     },
    //   );
    // yield* firestore
    //     .collection("journals")
    //     .where('user_id', isEqualTo: uid)
    //     .orderBy("date", descending: true)
    //     .limitToLast(5)
    //     .snapshots();
  }

  void deleteData(String id) {
    DocumentReference docRef = firestore.collection("datauser").doc(id);
    Get.defaultDialog(
      backgroundColor: Colors.white,
      title: "Hapus Data",
      middleText: "Apakah anda yakin ?",
      onConfirm: () async {
        await docRef.delete();
        Get.back();
      },
      textConfirm: "Iya",
      textCancel: "Tidak",
    );
  }
}
