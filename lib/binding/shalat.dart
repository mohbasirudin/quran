import 'package:get/get.dart';
import 'package:quran/controller/shalat.dart';

class BindingShalat extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(ControllerShalat());
  }
}
