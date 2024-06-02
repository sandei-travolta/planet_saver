import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:planet_saver/Controllers/user_statemanager.dart';
import 'package:planet_saver/FireBase/user_storage.dart';
import 'package:planet_saver/Models/user_model.dart';

import '../FireBase/images_bucket.dart';

class PickImage{
  final ImagePicker _picker = ImagePicker();
  final ImagesBucket _bucket=ImagesBucket();
  final UserStorage _userStorage=UserStorage();
  final userController = Get.find<UserStateController>();
  Future<XFile?> selectImage(ImageSource source)async{
    XFile? _pickedImage=await _picker.pickImage(
        source: source);
    return _pickedImage;
  }
  void pickImage(ImageSource source,UserModel? user)async{
    XFile? pickedImage=(await selectImage(source));
    File? selectedImage=File(pickedImage!.path);
    String? url=await _bucket.uploadImage(selectedImage,user!.uid);
    if(url.isNull)
      print("error");
    _userStorage.updateProfileImage(url!, user.uid);
    print("succsess");
  }
  Future<List<String>?> pickMultipleImages(ImageSource Source,UserModel? user)async{
    final List<String> images=[];
    try{
      final List<XFile> pickedFileList= await _picker.pickMultiImage(
        limit: 3
      );
      print("preparing for upload");
      for(final image in pickedFileList){
        File? selectedImage=File(image.path);
        String? url=await _bucket.uploadImage(selectedImage,user!.uid);
        images.add(url!);
      }
      print("upload SuccessFull");
      ///if(images.isNotEmpty)
      if(images.isNotEmpty){
        print("images uploaded Succesfully");
        return images;
      }
      else
        return null;
    }catch(e){

    }
  }
  void updateUi(String uid)async{
    UserModel? userModel=await _userStorage.getUser(uid);
    userController.setCur(userModel!);
  }
}