import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
          backgroundColor: AppColors.appBGColor,
          body: Obx(
            () => NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                        title: const Text(
                          "Products",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.white,
                              fontSize: 20),
                        ),
                        centerTitle: true,
                        pinned: false,
                        floating: false,
                        backgroundColor: Colors.deepPurpleAccent,
                        bottom: AppBar(
                          toolbarHeight: 60,
                          leadingWidth: 0.0,
                          backgroundColor: Colors.deepPurpleAccent,
                          title: SizedBox(
                            height: 40,
                            child: Row(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                      controller: controller.topScrollController,
                                      itemCount: controller.productCategoryList.length,
                                      padding: EdgeInsets.zero,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        var title = controller
                                            .productCategoryList[index].title;
                                        return GestureDetector(
                                            onTap: () {
                                              controller.onCategoryTap(index, title);
                                            },
                                            child: tabWidget1(index, title));
                                      }),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ];
                },
                body: controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.deepPurpleAccent,
                        ),
                      )
                    : customCategoryView1(context, controller)),
          )),
    ); //MaterialApp
  }

  Widget tabWidget({String? text}) {
    return Tab(
      child: Text(
        text.toString().capitalize ?? "",
        style: const TextStyle(
            fontWeight: FontWeight.w500, color: AppColors.white, fontSize: 18),
      ),
    );
  }

  Widget tabWidget1(int index, String title) {
    return Obx(
      () => Container(
        height: 8,
        width: controller.topContainerWidth,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            color: controller.checkIsCategory(index, title)
                ? Colors.black
                : Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.grey, width: 0.4)),
        child: Center(
          child: Text(
            title.toString().capitalize ?? "",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: controller.checkIsCategory(index, title)
                    ? AppColors.white
                    : AppColors.black,
                fontSize: 15),
          ),
        ),
      ),
    );
  }

  // Widget customCategoryView(BuildContext context, HomeController controller){
  //   return ListView.builder(
  //       itemCount: controller.productCategoryList.length,
  //       physics: ClampingScrollPhysics(),
  //       padding: const EdgeInsets.only(top: 10),
  //       shrinkWrap: true,
  //       itemBuilder: (context,index){
  //         var category = controller.productCategoryList[index].title;
  //         return controller.productCategoryList.isEmpty?
  //             const Text("No Data Found"):
  //           Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           children: [
  //             headerTitleWidget(category),
  //             productView(category)
  //           ],
  //           );
  //       }
  //   );
  // }

  Widget customCategoryView1(BuildContext context, HomeController controller) {
    return ListView.builder(
        controller: controller.bottomScrollController,
        itemCount: controller.productCategoryList.length,
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          var category = controller.productCategoryList[index].title;
          return controller.productCategoryList.isEmpty
              ? const Text("No Data Found")
              : SizedBox(
                  height: controller.bottomContainerHeight,
                  // color: Colors.grey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      headerTitleWidget(category),
                      productView(category)
                    ],
                  ),
                );
        });

    // return ScrollablePositionedList.builder(
    //      initialScrollIndex: 0,
    //      shrinkWrap: true,
    //      itemScrollController: controller.itemScrollController2,
    //      itemPositionsListener: controller.itemPositionsListener2,
    //      itemCount:  controller.productCategoryList.length,
    //     itemBuilder: (context,index) {
    //       var category = controller.productCategoryList[index].title;
    //       return controller.productCategoryList.isEmpty ?
    //       const Text("No Data Found") :
    //       Container(
    //         height:controller.containerHeight,
    //         color: Colors.grey,
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           children: [
    //             headerTitleWidget(category),
    //             productView(category)
    //           ],
    //         ),
    //       );
    //     });
  }

  Widget headerTitleWidget(category) {
    return SizedBox(
      height: 50,
      width: double.maxFinite,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        color: AppColors.white,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 15.0, right: 15, top: 8, bottom: 8),
          child: Text(
            category
                    .toString()
                    .replaceAll('(', '')
                    .replaceAll(")", '')
                    .capitalize ??
                "No Category",
            style: const TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.black,
                fontSize: 18),
          ),
        ),
      ),
    );
  }

  Widget productView(String category) {
    return FutureBuilder(
      future: controller.getProductListByCategory(category),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data != null) {
          if (snapshot.data!.isNotEmpty) {
            return SizedBox(
              height: 300,
              child: GridView.builder(
                itemCount: snapshot.data.length,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 2.0,
                    mainAxisSpacing: 2.0),
                itemBuilder: (BuildContext context, int index) {
                  var data = snapshot.data[index];
                  return SizedBox(
                      height: 120,
                      width: 50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(data["thumbnail"]),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(
                                      color: Colors.grey, width: 0.4))),
                          const SizedBox(height: 1),
                          Text(
                            "₹${data["price"] ?? 0.0}",
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.blue,
                                fontSize: 12),
                          ),
                          // const SizedBox(height: 1),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                data["title"] ?? "No title",
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.black,
                                    fontSize: 12),
                              ),
                            ),
                          ),
                          Text(
                            "Flat ${controller.getPercentage(data["discountPercentage"])}% Off",
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.green,
                                fontSize: 13),
                          ),
                          const SizedBox(height: 5)
                        ],
                      ));
                },
              ),
            );
          } else {
            return const SizedBox(
                height: 50,
                child: Center(
                    child: Text("No Products Available",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ))));
          }
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
