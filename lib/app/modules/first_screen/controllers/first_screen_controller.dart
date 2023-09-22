import 'package:get/get.dart';
import 'package:flutter/material.dart';

class FirstScreenController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final RxBool isNameFilled = false.obs;
  bool hasNavigatedToHome = false;
  bool userInputDetected = false;
  final RxBool isButtonHovered = false.obs;

  void updateNameFilled(bool value) {
    isNameFilled.value = value;
  }

  void clearTextField() {
    nameController.clear();
  }
}
