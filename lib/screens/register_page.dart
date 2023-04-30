import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:resturant_application/http/custom_http_request.dart';
import 'package:resturant_application/screens/dashboard.dart';
import 'package:resturant_application/screens/login_page.dart';
import 'package:resturant_application/widgets/custom_button.dart';
import 'package:resturant_application/widgets/custom_text_field.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
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
                    "Create your account",
                    style: TextStyle(
                        color: Colors.blueGrey[700],
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
                Text(
                  "to continue!",
                  style: TextStyle(
                      color: Colors.blueGrey[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                SizedBox(height: height * 0.01,),
                Custom_Text_Field(text: "Full Name", controller: regNameController,preicon: Icons.person_outline,),
                Custom_Text_Field(text: "Your email", controller: regEmailController,preicon: Icons.email_outlined,),
                Custom_Text_Field(text: "Password", controller: regPasswordController,preicon: Icons.lock_outline_rounded,icon: Icons.remove_red_eye_outlined,),
                Custom_Text_Field(text: "Confirm password", controller: regConfirmController,preicon: Icons.lock_outline_rounded,icon: Icons.remove_red_eye_outlined,),
                SizedBox(height: height *0.04,),
                Row(
                  children: [
                    Custom_Button(text: "Sign Up", backgroundColor: 0xff272727, foregroundColor: 0xffffffff, onTap: () => const DashBoard(),),
                  ],
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Text(
                  "Or continue with",
                  style: TextStyle(
                      color: Colors.blueGrey[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                SizedBox(
                  height: height * 0.03,
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
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
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
                        child: Image.asset("assets/images/facebook.png")
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already a member?",
                      style: TextStyle(color: Colors.black87, fontSize: 14),
                    ),
                    InkWell(
                      autofocus: false,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const LogInPage(),
                          ),
                        );
                      },
                      child: const Text(
                        "SignIn Now",
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
    );
  }
}
