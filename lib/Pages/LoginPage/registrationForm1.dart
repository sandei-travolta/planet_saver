import 'package:flutter/material.dart';
import 'package:planet_saver/Pages/LoginPage/registrationFom2.dart';

import '../Widgets/colors.dart';
import '../Widgets/textWidgets.dart';
import '../Widgets/textinput_widgets.dart';
class PersonalInfo extends StatelessWidget {
  PersonalInfo({Key? key, required this.nameController, required this.mobileNoController, required this.locationController}) : super(key: key);

  final TextEditingController nameController;
  final TextEditingController mobileNoController;
  final TextEditingController locationController;

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
                      registrationTextFields(nameController,Icons.person,"Full Name","Name"),
                      const SizedBox(height: 25,),
                      registrationTextFields(mobileNoController,Icons.phone,"Mobile No","Contact"),
                      const SizedBox(height: 25,),
                      registrationTextFields(locationController,Icons.location_on,"Your Region","Location"),
                    ],
                  ),
                ),
              ),
            )
    );
  }
}
