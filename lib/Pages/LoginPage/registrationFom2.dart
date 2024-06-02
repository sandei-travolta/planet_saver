import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import '../Widgets/colors.dart';
import '../Widgets/textWidgets.dart';
import '../Widgets/textinput_widgets.dart';
class MoreInfo extends StatelessWidget {
  MoreInfo({Key? key, required this.passwordController, required this.confirmPasswordController, required this.emailController}) : super(key: key);
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController emailController;
  @override
  Widget build(BuildContext context) {
    return Expanded(
            flex: 7,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Container(
                  padding: registerFormPad(),
                  decoration: BoxDecoration(
                    color: primaryColorV1.withOpacity(0.6),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(45),
                      topRight: Radius.circular(12),
                      bottomRight: Radius.circular(45),
                      bottomLeft: Radius.circular(12),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      registrationTextFields(emailController,
                          Icons.email,
                          "Enter Email",
                          "Email"
                      ),
                    const SizedBox(
                      height: 25,
                    ),
                    PasswordsWidget(
                      controller: passwordController,
                      icon: Icons.lock,
                      hint: "Enter PassWord",
                      label: "PassWord",
                    ),
                      const SizedBox(
                        height: 25,
                      ),
                      PasswordsWidget(
                        controller: confirmPasswordController,
                        icon: Icons.lock,
                        hint: "ConFirm PassWord",
                        label: "ConFirm PassWord",
                      )
                    ],
                  ),
                ),
              ),
            )
    );
  }

}

class PasswordsWidget extends StatelessWidget {
  const PasswordsWidget({
    super.key, required this.controller, required this.icon, required this.hint, required this.label,
  });
  final TextEditingController controller;
  final IconData icon;
  final String hint;
  final String label;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: true,
    controller: controller,
    decoration: InputDecoration(
      prefixIcon: Icon(icon,size: 25,),
      fillColor: Colors.white70,
      filled: true,
      hintText: hint,
      labelText: label,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12)
      ),
    ),
                      );
  }
}
EdgeInsets registerFormPad() => EdgeInsets.symmetric(vertical: 25,horizontal: 15);

