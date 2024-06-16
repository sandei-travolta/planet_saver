import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class ImagesBucket{
Future<String?> uploadImage(File image,String id)async{
  try{
    Reference reference=FirebaseStorage.instance.ref().child("ProfileImages").child(image.path);
    UploadTask uploadTask=reference.putFile(image);
    TaskSnapshot snapshot=await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }catch(e){
    print(e.toString());
    return null;
  }
}
}