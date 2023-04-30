import 'package:flutter/material.dart';
import 'package:resturant_application/screens/pages/category_page.dart';
import 'package:resturant_application/screens/pages/home_page.dart';
import 'package:resturant_application/screens/pages/order_page.dart';
import 'package:resturant_application/screens/pages/product_page.dart';
import 'package:resturant_application/screens/pages/profile_page.dart';

class DashBoard extends StatefulWidget {
   const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
   List<Widget> pages=[
     const HomePage(),
     const CategoryPage(),
     const ProductPage(),
     const OrderPage(),
     const ProfilePage(),
   ];

   int currentIndex=0;

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       body: Container(
         child: pages[currentIndex],
       ),
       bottomNavigationBar: BottomNavigationBar(
         currentIndex: currentIndex,
         selectedItemColor: Colors.blueAccent,
         unselectedItemColor: Colors.grey[700],
         onTap: (index){
           setState(() {
             currentIndex=index;
           });
         },
         items: const [
           BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
           BottomNavigationBarItem(icon: Icon(Icons.category),label: "Category"),
           BottomNavigationBarItem(icon: Icon(Icons.radar),label: "Product"),
           BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: "Order"),
           BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile"),
         ],
       ),
     );
   }
}
