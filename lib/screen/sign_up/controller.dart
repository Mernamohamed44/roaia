import 'package:flutter/material.dart';

class RegisterControllers {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final idController = TextEditingController();

  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    idController.dispose();
  }
}
