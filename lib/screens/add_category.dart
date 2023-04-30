import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:resturant_application/http/custom_http_request.dart';
import 'package:resturant_application/provider/category_provider.dart';
import 'package:resturant_application/widgets/custom_button.dart';
import 'package:resturant_application/widgets/custom_text_field.dart';
import 'package:resturant_application/widgets/custom_widget.dart';
import 'package:http/http.dart' as http;

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {

  File? icon, image;
  ImagePicker picker = ImagePicker();
  getIconFromGallery() async {
    final pickIcon = await picker.pickImage(source: ImageSource.gallery);
    if (pickIcon != null) {
      setState(() {
        icon = File(pickIcon.path);
      });
    }
  }
  getImageFromGallery() async {
    final pickIcon = await picker.pickImage(source: ImageSource.gallery);
    if (pickIcon != null) {
      setState(() {
        image = File(pickIcon.path);
      });
    }
  }
  bool isLoading = false;
  uploadCategory() async{
    try{
      setState(() {
        isLoading = true;
      });
      var url = "${baseUrl}category/store";
      var request = http.MultipartRequest("POST",Uri.parse(url),);
      request.headers.addAll(await CustomHttpRequest.getHeaderWithToken(),);
      request.fields["name"]=addCategoryController.text.toString();
      if(image!= null){
        var img = await http.MultipartFile.fromPath("image", image!.path);
        request.files.add(img);
      }if(icon!= null){
        var icn = await http.MultipartFile.fromPath("icon", icon!.path);
        request.files.add(icn);
      }
      var response = await request.send();
      setState(() {
        isLoading = false;
      });
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      var data = jsonDecode(responseString);
      print("Our Response Data is $data");
      if(response.statusCode==201){
        showInToast("Category Uploaded Successful");
        Provider.of<CategoryProvider>(context,listen: false).getCategoryData();
        Navigator.of(context).pop();
      }else{
        showInToast("Something is Wrong! Try Again!");
      }
    }catch(e){
      setState(() {
        isLoading = false;
      });
      print("Something is wrong $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return ModalProgressHUD(
      inAsyncCall: isLoading,
      progressIndicator: spinKit,
      opacity: 0.5,
      blur: 0.1,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xffD0D4E3),
          appBar: AppBar(
            backgroundColor: const Color(0xffD0D4E3),
            centerTitle: true,
            title: Text(
              "Add Categories",
              style: myStyle(20, Colors.blueGrey[700], FontWeight.bold),
            ),
            leading: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Icon(
                Icons.arrow_back_outlined,
                color: Colors.blueGrey[700],
              ),
            ),
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 15),
                child: Icon(
                  Icons.notifications_none_rounded,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Custom_Text_Field(
                    text: "Category Name",
                    controller: addCategoryController,
                    preicon: Icons.fastfood_outlined,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 10, left: 10),
                    child: Text(
                      "Add Category Icon",
                      style: myStyle(16, Colors.black, FontWeight.w600),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    height: height * 0.15,
                    width: width * 0.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: icon == null ? Colors.blueGrey[300] : null,),
                    child: icon == null
                        ? InkWell(
                            onTap: () {
                              getIconFromGallery();
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.add_photo_alternate_outlined,
                                  size: 25,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    "Upload Icon",
                                    style: myStyle(
                                        14, Colors.black, FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: FileImage(icon!), fit: BoxFit.cover),
                                ),
                              ),
                              Positioned(
                                right: -5,
                                top: -5,
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      icon = null;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.cancel_outlined,
                                    color: Colors.red,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 10, left: 10),
                    child: Text(
                      "Add Category Image",
                      style: myStyle(16, Colors.black, FontWeight.w600),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 20, bottom: 30),
                    height: height * 0.25,
                    width: width * 1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: image == null ? Colors.blueGrey[300] : null,
                    ),
                    child: image == null
                        ? InkWell(
                            onTap: () {
                              getImageFromGallery();
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.add_photo_alternate,
                                  size: 35,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    "Upload Image",
                                    style: myStyle(
                                        16, Colors.black, FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: FileImage(image!),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              Positioned(
                                right: -5,
                                top: -5,
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      image = null;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.cancel_outlined,
                                    color: Colors.red,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    child: Row(
                      children: [
                        Custom_Button(
                            text: "Upload",
                            backgroundColor: 0xffffffff,
                            foregroundColor: 0xff272727,
                            onTap: () {
                              uploadCategory();
                            }),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
