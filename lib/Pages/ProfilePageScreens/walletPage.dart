import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planet_saver/Controllers/user_statemanager.dart';
import 'package:planet_saver/FireBase/TransactionsHistory.dart';
import 'package:planet_saver/FireBase/balanceController.dart';
import 'package:planet_saver/Models/BalanceModel.dart';
import 'package:planet_saver/Models/TransactionModel.dart';

import '../Widgets/colors.dart';
class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  BalanceController balanceController=BalanceController();
  TransactionHistory transactionHistory=TransactionHistory();
  final user=Get.find<UserStateController>().currentser.value;
  List<TransactionModel> transactions=[];
  int? balance=0;
  @override
  void initState() {
    super.initState();
    getBalance();
    getTransactions();
  }
  void getBalance()async{
    BalanceModel? balanceModel=await balanceController.fetchBalance(user!.uid);
    balance=balanceModel!.amount;
  }
  void getTransactions()async{
    transactions=await transactionHistory.getTransactions(user!.uid);
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  color: primaryColorV2.withOpacity(0.8),
                  width: double.maxFinite,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("My Wallet",style: TextStyle(fontSize: 30,fontFamily: "PoppinsBold"),),
                    ],
                  ),
                )
            ),
            Expanded(
                flex: 3,
                child: Container(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: primaryColorV2
                  ),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(balance.toString(),
                              style: TextStyle
                                (
                              fontSize: 30,
                              fontWeight: FontWeight.w800
                            ),
                            ),
                            const SizedBox(width: 5,),
                            Text("Ksh",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600
                            ),)
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: primaryColorV1
                            ),
                            child: Center(
                              child:Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
                                child: Text("Withdraw",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white
                                  ),
                                ),
                              )
                            ),
                          ),
                        ),
                        const SizedBox(height: 10,),
                      ],
                    ),
                  ),
                ),
              ),
            )),
            Expanded(
                flex: 1,
                child: Container(
                  child: Center(
                    child: Text("Transaction History",style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),),
                  ),
                )),
            Expanded(
                flex: 9,
                child: Container(
                  child: ListView.builder(
                      itemCount: transactions.length,
                      itemBuilder: (context,index){
                        TransactionModel transaction=transactions[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.blueAccent
                        ),
                        child: ListTile(
                          leading: Text("Date: ${transaction.date}"),
                          title:Text("${transaction.amount} Ksh"),
                          subtitle: Text(transaction.senderID==user!.uid?"Sent":"Received"),
                        ),
                      )
                    );
                  }),
                ))
          ],
        ),
      ),
    );
  }
}
