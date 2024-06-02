import 'package:flutter/material.dart';
class UserInfoTabs extends StatelessWidget {
  const UserInfoTabs({
    super.key, required this.tittle, required this.subtitle, required this.icon,
  });
  final String tittle;
  final String subtitle;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
      child: Container(
          width: double.infinity,
          height: 80,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.black12
          ),
          child: Center(
            child: ListTile(
              leading: icon,
              title: Text(tittle,style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w600
              ),),
              subtitle: Text(subtitle,
                style: TextStyle(
                    fontSize: 18
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios_outlined,size: 45,),
            ),
          )
      ),
    );
  }
}
