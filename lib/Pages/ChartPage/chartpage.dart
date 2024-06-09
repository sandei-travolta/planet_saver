import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planet_saver/Controllers/user_statemanager.dart';
import 'package:planet_saver/FireBase/ChatsFireBase.dart';
import 'package:planet_saver/Models/ChartModel.dart';

import '../../Models/user_model.dart';
import 'Widget/chartBubbleWidget.dart';
class MessagePage extends StatefulWidget {
  MessagePage({Key? key, required this.otherUser, required this.conversationId}) : super(key: key);

  final UserModel otherUser;
  final String conversationId;

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final currentUserModel =Get.find<UserStateController>();

  final MessagingService messageService=MessagingService();

  TextEditingController messageController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.otherUser.name),
      ),
      body: Column(
        children: [
          Expanded(child: StreamBuilder<List<ChartModel>>(
            stream: messageService.fetchChatMessages(widget.conversationId),
            builder: (context,snapshot){
              ;

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
              if(snapshot.connectionState==ConnectionState.done){
                print(snapshot.data);
              }
              for(var a in snapshot.data!){
                print(a.message);
              }
              if(snapshot.hasData){
                print(snapshot.data!.length);
                var messages=snapshot.data!;
                for(var a in messages){
                  print(a.message);
                }
                return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context,index){
                      bool isMe=messages[index].from==widget.otherUser.uid;
                      return MessageBubble(
                        message: messages[index].message,
                        isMe: !isMe,
                      );
                    }
                );
              }
                return Text("no data");
              }
          )
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(hintText: 'Enter your message...'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed:(){
                    messageService.sendMessage(
                        currentUserModel.currentser.value!.uid,
                        widget.otherUser.uid, messageController.text,false,widget.conversationId);
                    messageController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
