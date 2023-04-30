import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant_application/provider/category_provider.dart';
import 'package:resturant_application/screens/add_category.dart';
import 'package:resturant_application/screens/update_delete_category.dart';
import 'package:resturant_application/widgets/custom_widget.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool isLoading = false;

  fetchCategoryData() async {
    setState(() {
      isLoading = true;
    });
    await Provider.of<CategoryProvider>(context, listen: false)
        .getCategoryData();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchCategoryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var category = Provider.of<CategoryProvider>(context);
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffD0D4E3),
        appBar: AppBar(
          backgroundColor: const Color(0xffD0D4E3),
          centerTitle: true,
          title: Text(
            "Categories",
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
        floatingActionButton: FloatingActionButton(
          elevation: 10,
          backgroundColor: const Color(0xffD0D4E3),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AddCategory(),
            ));
          },
          child: const Icon(
            Icons.add_outlined,
            size: 30,
            color: Colors.blueGrey,
          ),
        ),
        body: category.categoryList.isNotEmpty
            ? SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(height: height * 0.01),
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 2,
                                childAspectRatio: 1.01,
                                mainAxisSpacing: 2),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),),
                                child: InkWell(
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                                        UpdateDelete(categoryModel: category.categoryList[index]),),).then((value) {
                                      Provider.of<CategoryProvider>(context, listen: false).getCategoryData();
                                    });
                                  },
                                  child: Container(
                                    height: 100,
                                    padding: const EdgeInsets.only(top: 10,right: 5),
                                    alignment: Alignment.topRight,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                "$imageUrl${category.categoryList[index].image}"),
                                            fit: BoxFit.cover)),
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundImage: NetworkImage(
                                          "$imageUrl${category.categoryList[index].icon}"),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 5,),
                                child: Text(
                                  "${category.categoryList[index].name}",
                                  style: myStyle(16, Colors.blueGrey[600],
                                      FontWeight.w800),
                                ),
                              )
                            ],
                          );
                        },
                        itemCount: category.categoryList.length,
                        shrinkWrap: true,
                      ),
              ],
            ),
          ),
        ) : spin
      ),
    );
  }
}
