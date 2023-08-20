

import 'package:get/get.dart';


class AddTimeController extends GetxController {

  RxInt timeOfDuty = 0.obs;

  addTime() {
    timeOfDuty += 30;
  }

}