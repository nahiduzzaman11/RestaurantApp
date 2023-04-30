import 'package:flutter/material.dart';
import 'package:resturant_application/http/custom_http_request.dart';
import 'package:resturant_application/model/category_model.dart';

class CategoryProvider with ChangeNotifier{

  String name="dfsd";
  List<CategoryModel> categoryList=[];

  getCategoryData( )async{
    categoryList=await CustomHttpRequest.getCategories( );
    notifyListeners();
  }


}