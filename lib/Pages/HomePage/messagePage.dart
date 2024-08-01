import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planet_saver/Controllers/user_controller.dart';
import 'package:planet_saver/FireBase/ChatsFireBase.dart';
import 'package:planet_saver/Models/MessageViewModel.dart';
import 'package:planet_saver/Models/user_model.dart';
import 'package:planet_saver/Pages/ChartPage/chartpage.dart';

import '../../Controllers/user_statemanager.dart';
import '../Widgets/colors.dart';
class MessageScreen extends StatefulWidget {
  MessageScreen({Key? key}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final user=Get.find<UserStateController>();

  MessagingService messagingService=MessagingService();
  UserController userController=UserController();
  Future<UserModel?> returnUser(String id) async {
    UserController userController = UserController();
    UserModel? userModel = await userController.getCurrentUser(id);
    return userModel;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            flex: 2,
            child: Container(
              color: primaryColorV2.withOpacity(0.8),
              child: Center(
                child:Text("Inbox",style: TextStyle(fontSize: 30,fontFamily: "PoppinsBold"),)
              ),
            )),
        Expanded(
            flex: 11,
            child: Container(
              child: StreamBuilder<List<MessageView>>(
                  stream:messagingService.fetchUserChats(user.currentser.value!.uid),
                  builder: (context,snapShot){
                    print(user.currentser.value!.uid);
                    if(snapShot.connectionState==ConnectionState.waiting){
                      print("waiting");
                      return Center(
                        child: Container(
                          height: 40,
                          width: 40,
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    if (!snapShot.hasData) {
                      print(snapShot.hasData);
                      return Center(child: Text('No chats available'));
                    }
                    if (snapShot.hasError) {
                      return Center(child: Text('Error: ${snapShot.error}'));
                    }
                    final chats = snapShot.data!;


                return ListView.builder(
                  itemCount: chats.length,
                  itemBuilder: (context,index){
                   /* UserModel? user=await userController.getCurrentUser(chats[index].to);*/
                    String id=user.currentser.value!.uid==chats[index].from?chats[index].to:chats[index].from;
                    return FutureBuilder<UserModel?>(
                      future: returnUser(id),
                      builder: (context,userSnapshot) {
                        if (userSnapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                              child: Center(
                                child: Container(
                                  height: 40,
                                    width: 40,
                                    child: CircularProgressIndicator()),
                              ));
                        }
                        if (!userSnapshot.hasData || userSnapshot.data == null) {
                          return Text('User data not available');
                        }

                        var otherUser = userSnapshot.data!;
                        return InkWell(
                          onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>MessagePage(otherUser: otherUser, conversationId: chats[index].conversationId))),
                          child: Container(
                            height: 80,
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          color: Colors.yellow,
                                          shape: BoxShape.circle
                                      ),
                                      child: Image.asset("images/profilePicture.jpg",fit: BoxFit.contain,),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        messageHeading(otherUser.name),
                                        messageSubTxt(chats[index].lastMessage)
                                      ],
                                    ),
                                    const SizedBox(width: 40,),
                                    /*Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        messageTxt("Hello World"),
                                      ],
                                    )*/
                                  ],
                                ),
                                const SizedBox(height: 10,),
                                Container(height: 0.6,color: Colors.black,)
                              ],
                            )
                          ),
                        );
                      }
                    );
                  }
                );
              }),
            ))
      ],
    );
  }

  Text messageTxt(String value) {
    return Text(value,style: TextStyle(
      fontSize: 20,
      color: Colors.black,
      fontFamily: "Poppins-Bold",
      fontWeight: FontWeight.normal
    ),);
  }

  Text messageHeading(String value) {
    return Text(value,style: TextStyle(
      fontSize: 20,
      color: Colors.black,
      fontFamily: "Poppins-Bold",
      fontWeight: FontWeight.bold
    ),);
  }

  Text messageSubTxt(String value) {
    return Text(value,style: TextStyle(
      fontSize: 15,
      color: Color(0xFF959FA8),
      fontFamily: "Poppins-semiBold",
      overflow:TextOverflow.ellipsis
    ),);
  }
}
