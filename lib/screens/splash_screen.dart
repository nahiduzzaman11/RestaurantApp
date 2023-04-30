import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:resturant_application/screens/dashboard.dart';
import 'package:resturant_application/screens/login_page.dart';
import 'package:resturant_application/screens/register_page.dart';
import 'package:resturant_application/widgets/custom_button.dart';
import 'package:resturant_application/widgets/custom_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  isLogin()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    if(token!=null){
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DashBoard()));
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    isLogin();
    super.initState();
  }

  bool isClicked = false;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ModalProgressHUD(
      inAsyncCall: isClicked,
      progressIndicator: spinKit,
      opacity: 0.2,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(height: height*0.05,),
                  Container(
                    height: height * 0.5,
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: const DecorationImage(
                          image: NetworkImage(
                              "https://images.pexels.com/photos/2641886/pexels-photo-2641886.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Text(
                          "     Discover Your\n Favorite Food Here",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          color: Colors.grey[700]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20,bottom: 40),
                        child: Text("Explore all the most exiting foods here\nbased on your interest And order now.",
                          style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.blueGrey[700]),),),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40,right: 40,bottom: 20),
                    child: Row(
                      children: [
                        Custom_Button(text: "Register", backgroundColor: 0xffffffff, foregroundColor: 0xff272727,onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RegisterPage(),),);
                        },),
                        SizedBox(width: width*0.03,),
                        Custom_Button(text: "Sign in", backgroundColor: 0xff272727, foregroundColor: 0xffffffff,onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LogInPage(),),);
                        },)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


