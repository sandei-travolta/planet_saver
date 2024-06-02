import 'package:flutter/material.dart';

import '../Widgets/colors.dart';
class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key}) : super(key: key);

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
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context,index){
                return Container(
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
                              messageHeading("Max Spayne"),
                              messageSubTxt("Buyer")
                            ],
                          ),
                          const SizedBox(width: 40,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              messageTxt("Hello World"),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Container(height: 0.6,color: Colors.black,)
                    ],
                  )
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
    ),);
  }
}
