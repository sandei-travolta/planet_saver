import 'package:flutter/material.dart';

import '../Widgets/textWidgets.dart';
import 'Widgets/widgets.dart';
class RequestPickUp extends StatelessWidget {
  RequestPickUp({Key? key}) : super(key: key);

  TextEditingController titleController=TextEditingController();

  TextEditingController descriptionController=TextEditingController();

  TextEditingController priceController=TextEditingController();

  TextEditingController weightController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  loginTittleText(),
                ],
              ),
              InputFiedsAd(
                titleController: titleController,
                hintText: 'What are You Selling ?',
                labelText: 'Product Tittle',
              ),
              NumeralInputFiedsAd(
                titleController: priceController,
                hintText: 'Set The price',
                labelText: 'Product price',
              ),
              NumeralInputFiedsAd(
                titleController: weightController,
                hintText: 'Weight(kG)',
                labelText: 'Product Weight',
              ),
              InputFiedsAd(
                titleController: descriptionController,
                hintText: 'What are You Selling ?',
                labelText: 'Product Tittle',
              ),
              Text("Upload Images",style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600
              ),),
              UploadImagesWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
