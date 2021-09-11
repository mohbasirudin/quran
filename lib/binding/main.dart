import 'package:get/get.dart';
import 'package:quran/controller/main.dart';

class BindingMain extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(ControllerMain());
  }
}
