import 'package:get/get.dart';
import 'package:planet_saver/Controllers/user_statemanager.dart';

class AppBindings implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => UserStateController());
  }

}