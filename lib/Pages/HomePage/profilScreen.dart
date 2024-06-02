import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:planet_saver/Controllers/image_picker.dart';
import 'package:planet_saver/Controllers/user_statemanager.dart';

import '../Widgets/colors.dart';
import '../Widgets/profile_info_tabs_widget.dart';
import '../Widgets/profile_text_widgets.dart';
class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  PickImage _pickImage=PickImage();
  final userController = Get.find<UserStateController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            flex: 3,
            child: Container(
              color: primaryColorV2.withOpacity(0.8),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 20),
                child: Obx(
                    ()=> Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(width: 10,),
                        Stack(
                          children: [
                            ClipOval(
                              child: Container(
                                height: 110,
                                width: 110,
                                decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  shape: BoxShape.circle
                                ),
                                child: userController.currentser.value!.imgUrl!="url"?CachedNetworkImage(imageUrl: userController.currentser.value!.imgUrl,fit: BoxFit.fill,):Image.asset("images/profilePicture.jpg"),
                              ),
                            ),
                            Positioned(
                              bottom: -5,
                              right: -5,
                              child: IconButton(onPressed: (){
                                _pickImage.pickImage(ImageSource.gallery,userController.currentser.value);

                              },
                                icon: Icon(Icons.photo_camera),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(width: 15,),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 30,),
                              textWidgets(userController.currentser.value!.name),
                              textWidgets(userController.currentser.value!.email),
                              textWidgets(userController.currentser.value!.mobileNo.toString())
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ),
        Expanded(
            flex: 11,
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    UserInfoTabs(
                      icon: Icon(Icons.person),
                      tittle: "Profile",
                      subtitle: "Edit your Profile",
                    ),
                    UserInfoTabs(
                      icon: Icon(Icons.monetization_on_sharp),
                      tittle: "Wallet",
                      subtitle: "Make Transactions",
                    ),
                    UserInfoTabs(
                      icon: Icon(Icons.bookmark),
                      tittle: "Ads",
                      subtitle: "Your Posted Ads",
                    ),
                    UserInfoTabs(
                      icon: Icon(Icons.history),
                      tittle: "Orders",
                      subtitle: "Order Historiy",
                    ),
                    InkWell(
                      onTap: (){
                        userController.clearUser();
                      },
                      child: UserInfoTabs(
                        icon: Icon(Icons.login),
                        tittle: "Sign Out",
                        subtitle: "Exit App",
                      ),
                    )
                  ],
                ),
              ),
        ))
      ],
    );
  }

}
