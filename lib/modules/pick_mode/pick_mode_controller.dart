import 'package:get/get.dart';

import '../../data/models/mode_model.dart';
import '../../data/values/device_data.dart';

class PickModeController extends GetxController {
  var listMode = DeviceData.listModeLedStrip;

  bool isSingle = true;

  Rx<ModeModel> selectedSingleMode = Rx(
    DeviceData.listModeLedStrip[0],
  );
  RxList<ModeModel> selectedMultipleMode = RxList([]);

  @override
  void onInit() {
    super.onInit();

    var arguments = Get.arguments as Map<String, dynamic>;
    isSingle = arguments['isSingle'] ?? true;

    if (isSingle) {
      var selected = arguments['selected'] as Map<String, dynamic>;
      selectedSingleMode.value = ModeModel.fromJson(selected);
    } else {
      var selected = arguments['selected'] as List;
      selectedMultipleMode.value = listMode
          .where(
            (element) => selected.contains(element.id),
          )
          .toList();
    }
  }

  bool isSingleSelected(ModeModel model) => selectedSingleMode.value == model;

  void selectSingle(ModeModel model) {
    selectedSingleMode.value = model;
  }

  bool isMultipleSelected(ModeModel model) =>
      selectedMultipleMode.contains(model);

  void selectMultiple(ModeModel model) {
    if (selectedMultipleMode.contains(model)) {
      selectedMultipleMode.remove(model);
    } else {
      selectedMultipleMode.add(model);
    }
  }

  void done() {
    dynamic result;
    if (isSingle) {
      result = selectedSingleMode.toJson();
    } else {
      result = selectedMultipleMode.map((element) => element.id).toList();
      if ((result as List).isNotEmpty) {
        result.sort();
      }
    }

    Get.back(result: result);
  }
}
