import 'package:flutter/material.dart';
import 'package:resturant_application/widgets/custom_widget.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.2,
                  width: double.infinity,
                ),
                Row(
                  children: [
                    Container(
                      width: width * 0.5,
                      color: Colors.blueGrey[300],
                      child: Column(),
                    ),
                    Container(
                      width: width * 0.5,
                      padding: const EdgeInsets.only(right: 10),
                      child: Column(
                        children: [
                          Card(
                            elevation: 5,
                            color: const Color(0xffD0D4E3),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(50),
                                bottomRight: Radius.circular(10),
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.only(
                                  top: 10, left: 20, right: 15, bottom: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Align(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 10, bottom: 15),
                                      child: Text(
                                        "Order Details",
                                        style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Total Order : 150",
                                          style: myStyle(12, Colors.black,
                                              FontWeight.bold),
                                        ),
                                        Icon(
                                          Icons.bookmark_outline,
                                          color: Colors.blue,
                                          size: 16,
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Completed : 50",
                                          style: myStyle(12, Colors.black,
                                              FontWeight.bold),
                                        ),
                                        Icon(
                                          Icons.verified_outlined,
                                          color: Colors.green[300],
                                          size: 16,
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "On the Way : 50",
                                          style: myStyle(12, Colors.black,
                                              FontWeight.bold),
                                        ),
                                        Icon(
                                          Icons.directions_bike_outlined,
                                          color: Colors.purple,
                                          size: 16,
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Pending : 45",
                                          style: myStyle(12, Colors.black,
                                              FontWeight.bold),
                                        ),
                                        Icon(
                                          Icons.access_alarms_outlined,
                                          color: Colors.deepPurpleAccent,
                                          size: 16,
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Cancelled : 5",
                                          style: myStyle(12, Colors.black,
                                              FontWeight.bold),
                                        ),
                                        Icon(
                                          Icons.cancel_outlined,
                                          color: Colors.pinkAccent,
                                          size: 16,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
