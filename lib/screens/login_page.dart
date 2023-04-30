import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:resturant_application/http/custom_http_request.dart';
import 'package:resturant_application/screens/dashboard.dart';
import 'package:resturant_application/screens/register_page.dart';
import 'package:resturant_application/widgets/custom_button.dart';
import 'package:resturant_application/widgets/custom_text_field.dart';
import 'package:resturant_application/widgets/custom_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {

  @override
  void initState() {
    // TODO: implement initState
    isLogin();
    super.initState();
  }
  bool isClick = true;
  bool isClicked = false;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return ModalProgressHUD(
      inAsyncCall: isClicked,
      opacity: 0.2,
      progressIndicator: spinKit,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xffD0D4E3),
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.1,
                  ),
                  Text(
                    "Hello Again!",
                    style: TextStyle(
                        color: Colors.blueGrey[700],
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 5),
                    child: Text(
                      "Welcome back you've",
                      style: TextStyle(
                          color: Colors.blueGrey[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  Text(
                    "been missed!",
                    style: TextStyle(
                        color: Colors.blueGrey[700],
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Custom_Text_Field(controller: emailController,preicon: Icons.person_outline,
                    text: "Enter email",
                  ),
                  Custom_Text_Field(
                    controller: passwordController,preicon: Icons.lock_outline_rounded,
                      text: "Password", icon: Icons.remove_red_eye_outlined),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          "Remember Me?",
                          style: TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                        Checkbox(
                          value: isClick,
                          onChanged: (value) {
                            //setState(() {isClicked = !isClicked;});
                          },
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Custom_Button(
                        text: "Sign In",
                        backgroundColor: 0xff272727,
                        foregroundColor: 0xffffffff,
                        onTap: () {
                          getLogin();
                        },
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      "Recovery Password",
                      style: TextStyle(fontSize: 14, color: Colors.blueGrey),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Text(
                    "Or continue with",
                    style: TextStyle(
                        color: Colors.blueGrey[700],
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1, color: Colors.white)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.phone_outlined,color: Colors.blue,),
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1, color: Colors.white)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CachedNetworkImage(imageUrl: "https://cdn.icon-icons.com/icons2/836/PNG/512/Google_icon-icons.com_66793.png",),
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1, color: Colors.white)),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset("assets/images/facebook.png"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Not a member?",
                        style: TextStyle(color: Colors.black87, fontSize: 14),
                      ),
                      InkWell(
                        autofocus: false,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const RegisterPage(),
                            ),
                          );
                        },
                        child: const Text(
                          "Register Now",
                          style: TextStyle(color: Colors.blue, fontSize: 14),
                        ),
                      ),
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
  isLogin()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    if(token!=null){
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const DashBoard()));
    }
  }

  getLogin()async{
    try{
      setState(() {
        isClicked=true;
      });
      String url="${baseUrl}sign-in";
      var map=Map<String ,dynamic>();
      map["email"]=emailController.text.toString();
      map["password"]=passwordController.text.toString();
      var responce= await http.post(Uri.parse(url),body: map);
      var data=jsonDecode(responce.body);
      setState(() {
        isClicked=false;
      });
      print(" responce is ${data}");
      print(" status code ${responce.statusCode}");
      if(responce.statusCode==200){
        showInToast("Login Successful");
        SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
        sharedPreferences.setString("token",data["access_token"]);
        print(" saved token is ${sharedPreferences.getString("token")}");
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DashBoard()));
      }else{
        showInToast("Email or Password doesn't match");
      }
    }catch(e){
      showInToast("Something is wrong $e");
    }
  }
}
