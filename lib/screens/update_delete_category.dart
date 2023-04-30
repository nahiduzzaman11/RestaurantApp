import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:resturant_application/http/custom_http_request.dart';
import 'package:resturant_application/model/category_model.dart';
import 'package:resturant_application/widgets/custom_button.dart';
import 'package:resturant_application/widgets/custom_text_field.dart';
import 'package:resturant_application/widgets/custom_widget.dart';

class UpdateDelete extends StatefulWidget {
  UpdateDelete( {Key? key,this.categoryModel}) : super(key: key);

  @override
  State<UpdateDelete> createState() => _UpdateDeleteState();

  CategoryModel? categoryModel;
}

class _UpdateDeleteState extends State<UpdateDelete> {
  File? icn, img;
  ImagePicker picker = ImagePicker();

  getIconFromGallery() async {
    final pickIcon = await picker.pickImage(source: ImageSource.gallery);
    if (pickIcon != null) {
      setState(() {
        icn = File(pickIcon.path);
      });
    }
  }

  getImageFromGallery() async {
    final pickIcon = await picker.pickImage(source: ImageSource.gallery);
    if (pickIcon != null) {
      setState(() {
        img = File(pickIcon.path);
      });
    }
  }

  bool isLoading = false;

  updateCategory() async {
    try {
      setState(() {
        isLoading = true;
      });
      var url = "${baseUrl}category/${widget.categoryModel!.id}/update";
      var request = http.MultipartRequest(
        "POST",
        Uri.parse(url),
      );
      request.headers.addAll(
        await CustomHttpRequest.getHeaderWithToken(),
      );
      request.fields["name"] = upCategoryController.text.toString();
      if (img != null) {
        var image = await http.MultipartFile.fromPath("image", img!.path);
        request.files.add(image);
      }
      if (icn != null) {
        var icon = await http.MultipartFile.fromPath("icon", icn!.path);
        request.files.add(icon);
      }
      var response = await request.send();
      setState(() {
        isLoading = false;
      });
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      var data = jsonDecode(responseString);
      print("Our Response Data is $data");
      if (response.statusCode == 200) {
        showInToast("Category Update Successful");
        Navigator.of(context).pop();
      } else {
        showInToast("Something is Wrong! Try Again!");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Something is wrong $e");
    }
  }

@override
  void initState() {
    // TODO: implement initState
  upCategoryController= TextEditingController(text: widget.categoryModel!.name);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return ModalProgressHUD(
      inAsyncCall: isLoading,
      progressIndicator: spin,
      opacity: 0.5,
      blur: 0.1,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xffD0D4E3),
          appBar: AppBar(
            backgroundColor: const Color(0xffD0D4E3),
            centerTitle: true,
            title: Text(
              "Update/Delete Categories",
              style: myStyle(18, Colors.blueGrey[700], FontWeight.bold),
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
                    text: "Category name",
                    controller: upCategoryController,
                    preicon: Icons.fastfood_outlined,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, bottom: 10, left: 10),
                    child: Text(
                      "Category Icon",
                      style: myStyle(16, Colors.black, FontWeight.w600),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    height: height * 0.15,
                    width: width * 0.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: icn == null ? Colors.blueGrey[300] : null,
                    ),
                    child: icn == null
                        ? InkWell(
                            onTap: () {
                              getIconFromGallery();
                            },
                            child: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(image: NetworkImage("$imageUrl${widget.categoryModel!.icon}"),fit: BoxFit.cover,),),
                            ),
                          )
                        : Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: FileImage(icn!),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              Positioned(
                                right: -5,
                                top: -5,
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      icn = null;
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
                    padding:
                        const EdgeInsets.only(top: 20, bottom: 10, left: 10),
                    child: Text(
                      "Category Image",
                      style: myStyle(16, Colors.black, FontWeight.w600),
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.only(left: 10, right: 20, bottom: 30),
                    height: height * 0.25,
                    width: width * 1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: img == null ? Colors.blueGrey[300] : null,
                    ),
                    child: img == null
                        ? InkWell(
                            onTap: () {
                              getImageFromGallery();
                            },
                            child: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(image: NetworkImage("$imageUrl${widget.categoryModel!.image}"),fit: BoxFit.cover,),),
                            ),
                          )
                        : Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: FileImage(img!),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              Positioned(
                                right: -5,
                                top: -5,
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      img = null;
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
                  Row(
                    children: [
                      Custom_Button(
                          text: "Update",
                          backgroundColor: 0xffffffff,
                          foregroundColor: 0xff272727,
                          onTap: () {
                            updateCategory();
                          }),
                      SizedBox(
                        width: width * 0.05,
                      ),
                      Custom_Button(
                          text: "Delete",
                          backgroundColor: 0xff272727,
                          foregroundColor: 0xffffffff,
                          onTap: () {
                            showDialog(context: context, builder: (context) {
                              return AlertDialog(
                                title: Text("Are you sure?",style: myStyle(16,Colors.black),),
                                content: Text("You Want to Delete This Category?",style: myStyle(14,Colors.black),),
                                actions: [
                                  TextButton(onPressed: (){
                                    Navigator.of(context).pop();
                                  }, child: const Text("NO",),),
                                  TextButton(onPressed: () async {
                                    bool isDelete= await CustomHttpRequest.deleteCategory(id: widget.categoryModel!.id);
                                    Navigator.of(context).pop();
                                    if(isDelete==true){
                                      showInToast("Category Delete Successful");
                                      Navigator.of(context).pop();
                                    }
                                    else{
                                      showInToast("Something is wrong!");
                                    }
                                  }, child: const Text("YES"),),
                                ],
                              );
                            },);
                          }),
                    ],
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
