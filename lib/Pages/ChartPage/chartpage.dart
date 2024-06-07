import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planet_saver/Controllers/user_statemanager.dart';
import 'package:planet_saver/FireBase/ChatsFireBase.dart';
import 'package:planet_saver/Models/ChartModel.dart';

import '../../Models/user_model.dart';
import 'Widget/chartBubbleWidget.dart';
class MessagePage extends StatelessWidget {
  MessagePage({Key? key, required this.otherUser, required this.conversationId}) : super(key: key);

  final UserModel otherUser;
  final String conversationId;
  final currentUserModel =Get.find<UserStateController>();
  final MessagingService messageService=MessagingService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(otherUser.name),
      ),
      body: Column(
        children: [
          Expanded(child: StreamBuilder<List<ChartModel>>(
            stream: messageService.fetchChatMessages(conversationId),
            builder: (context,snapshot){
              if(snapshot.hasError){
                return Text("Error retrieving messages");
              }
              if(snapshot.connectionState==ConnectionState.waiting){
                return Center(
                  child: Container(
                    height: 40,
                    width: 40,
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if(!snapshot.hasData){
                return Text("no data");
              }
                final messages=snapshot.data!;
                return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context,index){
                      bool isMe=messages[index].from==otherUser.uid;
                  return MessageBubble(
                    message: messages[index].message,
                    isMe: isMe,
                  );
                }
                );
              }
          )
          )
        ],
      ),
    );
  }
}
