import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:planet_saver/Controllers/image_picker.dart';
import 'package:planet_saver/Controllers/user_statemanager.dart';
class InputFiedsAd extends StatefulWidget {
  const InputFiedsAd({
    super.key,
    required this.titleController, required this.hintText, required this.labelText,
  });

  final TextEditingController titleController;
  final String hintText;
  final String labelText;

  @override
  State<InputFiedsAd> createState() => _InputFiedsAdState();
}

class _InputFiedsAdState extends State<InputFiedsAd> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
      child: TextFormField(
        controller: widget.titleController,
        decoration: InputDecoration(
            hintText: widget.hintText,
            labelText: widget.labelText
        ),
      ),
    );
  }
}
class NumeralInputFiedsAd extends StatelessWidget {
  const NumeralInputFiedsAd({
    super.key,
    required this.titleController, required this.hintText, required this.labelText,
  });

  final TextEditingController titleController;
  final String hintText;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 8),
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: titleController,
        decoration: InputDecoration(
            hintText: hintText,
            labelText: labelText
        ),
      ),
    );
  }
}
class UploadImagesWidget extends StatefulWidget {
   UploadImagesWidget({
    super.key,
  });

  @override
  State<UploadImagesWidget> createState() => _UploadImagesWidgetState();
}

class _UploadImagesWidgetState extends State<UploadImagesWidget> {
  PickImage pickImage=PickImage();

  final user=Get.find<UserStateController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20),
      child: Container(
          width: double.maxFinite,
          height:300,
          decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(12)
          ),
          child: user.pickedImages.value.isEmpty?Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: ()async{
                      List<File> pickedImages=await pickImage.pickMultipleImages(ImageSource.gallery,user.currentser.value)??[];
                      user.setImages(pickedImages);
                      setState(() {
                      });
                    },
                    icon: Icon(Icons.photo_camera,size: 45,
                    )
                ),
                Text("Upload Images",style: TextStyle(
                    fontSize: 18
                ),)
              ],
            ),
          ):Container(
            child: Obx(
                ()=>ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: user.pickedImages.value.length,
                  itemBuilder: (context,index){
                    return Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(user.pickedImages.value[index])),
                        ),
                        Positioned(
                            top: -10,
                            right: -5,
                            child: IconButton(
                            onPressed: (){
                            user.pickedImages.value.removeAt(index);
                            setState(() {

                            });
                          },
                          icon: Icon(Icons.delete),
                        )
                        )
                      ],
                    );
              }
              ),
            ),
          )
        ),
    );
  }
}

