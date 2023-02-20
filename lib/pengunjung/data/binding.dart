import 'package:get/instance_manager.dart';
import '/admin/permintaan/admin_controller.dart';
import '/pengunjung/riwayat/riwayat_controller.dart';
import '../data/baru_controller.dart';

class Barubinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BaruController>(
      () => BaruController(),
    );
    Get.lazyPut<RiwayatController>(
      () => RiwayatController(),
    );
    Get.lazyPut<AdminPermintaanController>(() => AdminPermintaanController());
  }
}
