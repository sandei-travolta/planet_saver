import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planet_saver/Models/Product.dart';
import 'package:planet_saver/Models/user_model.dart';
import 'package:planet_saver/Pages/LoginPage.dart';

class UserStateController extends GetxController{
  final Rx<UserModel?> currentser=Rx<UserModel?>(null);
  final RxList<File> pickedImages = <File>[].obs;
  final RxList<Product> productsList=<Product>[].obs;
  final RxList<Product> disposalList=<Product>[].obs;
  final RxList<Product> filteredproductsList=<Product>[].obs;
  final RxList<Product> filtereddisposalList=<Product>[].obs;
  final Rx<int> currentSelection=0.obs;
  setCur(UserModel userModel){
    this.currentser.value=userModel;
  }
  setImages(List<File> list){
    this.pickedImages.value=list;
  }
  clearImages(){
    pickedImages.value=[];
  }
  setProducts(List<Product> products){
    this.productsList.value=products;
  }
  setDisposals(List<Product> disposals){
    this.disposalList.value=disposals;
  }
  filterProducts(List<Product> products){
    this.filteredproductsList.value=products;
  }
  filterDisposals(List<Product> disposals){
    this.filtereddisposalList.value=disposals;
  }
  void clearUser(){
    currentser.value=null;
    Get.to(LoginPage());
  }
  setPage(int page){
    this.currentSelection.value=page;
  }
}