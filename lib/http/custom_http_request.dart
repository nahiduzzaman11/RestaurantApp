import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:resturant_application/model/category_model.dart';
import 'package:resturant_application/widgets/custom_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

TextEditingController emailController =TextEditingController();
TextEditingController passwordController =TextEditingController();
TextEditingController regNameController =TextEditingController();
TextEditingController regEmailController =TextEditingController();
TextEditingController regPasswordController =TextEditingController();
TextEditingController regConfirmController =TextEditingController();
TextEditingController addCategoryController =TextEditingController();
TextEditingController upCategoryController =TextEditingController();


class CustomHttpRequest{
  static Future<Map<String,String>> getHeaderWithToken()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    var header={
      "Accept" : "application/json",
      "Authorization":"Bearer ${sharedPreferences.getString("token")}"
    };
    return header;
  }


  static Future<dynamic> getCategories()async{
    CategoryModel ?categoryModel;
    List<CategoryModel> categoryList=[];
    try{
      var url="${baseUrl}category";
      var response =await http.get(Uri.parse(url),headers: await CustomHttpRequest.getHeaderWithToken());
      print("HTTP RESPONSE : ${response.body}");
      if(response.statusCode==200){
        var data=jsonDecode(response.body);
        for(var i in data){
          categoryModel=CategoryModel.fromJson(i);
          categoryList.add(categoryModel);
        }
        print("ALL DATA : $data");
      }
    }catch(e){
      print("Something is wrong in category $e");
    }
    return categoryList;
  }

  static Future<bool> deleteCategory({int ? id}) async{
    var uri = "${baseUrl}category/${id}/delete";
    var response = await http.delete(Uri.parse(uri),headers: await getHeaderWithToken());
    final data = jsonDecode(response.body);
    print("Response is $data");
    if(response.statusCode == 200){
      return true;
    }
    else{
      return false;
    }
  }


}