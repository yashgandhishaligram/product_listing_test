import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:product_listing_test/app/app/data/models/product_category.dart';
import 'package:product_listing_test/app/app/services/api/app_service.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  var isScrollingDown = true.obs;
  ScrollController topScrollController = ScrollController();
  ScrollController bottomScrollController = ScrollController();
  var productCategoryList = <ProductCategory>[].obs;
  var productsList = [];
  final appService = Get.find<AppService>();
  var isLoading = false.obs;
  var isCategorySelected = false.obs;
  var selectedMap = <MapEntry<String, bool>>{}.obs;
  var globalKeysList = <GlobalKey>[].obs;
  // ItemScrollController itemScrollController1 = ItemScrollController();
  // ItemScrollController itemScrollController2 = ItemScrollController();
  // ItemPositionsListener itemPositionsListener2 = ItemPositionsListener.create();
  var scrollIndex = 0.obs;
  final bottomContainerHeight = 350.0;
  final topContainerWidth = 110.0;
  var isCategoryTap = false.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 20, vsync: this);
    topScrollController = ScrollController();
    topScrollController.addListener((){
      //_scrollListener();
      topScrollListener();});
    bottomScrollController = ScrollController();
    bottomScrollController.addListener(() {
      _scrollListener();
      bottomScrollListener();
    });
    // itemPositionsListener2.itemPositions.addListener(scrollItemListener);
    getCategoriesList();
  }

  void _scrollListener() {
    /// Get the current position of the visible portion of the list
    print('position.pixels ${bottomScrollController.position.pixels}');
    final position = bottomScrollController.position;
    final extent = position.extentInside;
    final minVisibleOffset = position.pixels;
    final maxVisibleOffset = minVisibleOffset + extent;
    scrollIndex.value = 0;

    /// Calculate the index of the first and last visible item
    final firstVisibleIndex = (minVisibleOffset / 350).floor();
    final lastVisibleIndex = (maxVisibleOffset / 350).floor();
    if (lastVisibleIndex == productCategoryList.length) {
      scrollIndex.value = productCategoryList.length - 1;
    } else {
      scrollIndex.value = firstVisibleIndex != -1 ? firstVisibleIndex : 0;
    }
    print('scrollIndex.value: ${scrollIndex.value}}');
    // print('First visible index: $firstVisibleIndex');
    // print('Last visible index: $lastVisibleIndex');
  }

  Future getCategoriesList() async {
    isLoading.value = true;
    var productData = await appService.getProducts();
    productsList = productData["products"];
    if (productsList.isNotEmpty) {
      isLoading.value = false;
      for (var element in productsList) {
        String category = element["category"];
        productCategoryList.add(ProductCategory(title: category));
        var unique = <String>{};
        productCategoryList.value = productCategoryList.where((element) => unique.add(element.title)).toList();
        if(productCategoryList.isNotEmpty){
          onCategorySelection(productCategoryList[scrollIndex.value].title);
        }
      }
    }
  }

  Future<List<dynamic>> getProductListByCategory(String category) async {
    if (productsList.isNotEmpty) {
      var list = productsList
          .where((element) => element["category"] == category)
          .toList();
      return list;
    }
    return [];
  }

  int getPercentage(percentage) {
    if (percentage.runtimeType == int) {
      return percentage.toInt();
    } else {
      return percentage.toInt();
    }
  }

  void onCategoryTap(int index, String title) {
    onCategorySelection(title);
    bottomScrollController.animateTo(bottomContainerHeight * index,
        duration: const Duration(milliseconds: 400), curve: Curves.ease);
  }

  void onCategorySelection(String title) {
    var obj = selectedMap.where((element) => element.key == title);
    if (obj.isEmpty) {
      selectedMap.clear();
      selectedMap.add(MapEntry(title, true));
    }
  }

  bool checkIsCategory(int index, String title) {
    var obj = selectedMap.where((value) => value.key == title);
    if (obj.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void scrollItemListener() {
    // scrollIndex.value = itemPositionsListener2.itemPositions.value.first.index;
    // onCategorySelection(productCategoryList[scrollIndex.value].title);
    // itemScrollController1.scrollTo(
    //     index: scrollIndex.value,
    //     duration: const Duration(milliseconds: 10),
    //     curve: Curves.ease);
  }

  void topScrollListener() {
   // print("itemextend : ${topScrollController.position.maxScrollExtent}");
  }

  void bottomScrollListener() {
    //print('bottomScrollController.position.userScrollDirection ${bottomScrollController.position.userScrollDirection}');
 if(bottomScrollController.hasClients && topScrollController.hasClients){
   if (bottomScrollController.position.userScrollDirection == ScrollDirection.reverse) {
     onCategorySelection(productCategoryList[scrollIndex.value].title);
     double sectionPosition = 0.0;
     sectionPosition = topContainerWidth * scrollIndex.value;
     topScrollController.animateTo(sectionPosition, duration: const Duration(milliseconds: 100), curve: Curves.ease);
   } else if (bottomScrollController.position.userScrollDirection == ScrollDirection.forward) {
     onCategorySelection(productCategoryList[scrollIndex.value].title);
     // print('topScrollController.position.pixels ${topScrollController.position.pixels}');
     // print('topScrollController.topContainerWidth $topContainerWidth');
     // print('topScrollController.topContainerWidth $topContainerWidth');
     // print('scrollIndex.value ${scrollIndex.value}');
     double sectionPosition = 0.0;
     sectionPosition = topContainerWidth  * scrollIndex.value;
    // final sectionPosition = topScrollController.position.pixels - topContainerWidth * scrollIndex.value;
     print('sectionPosition $sectionPosition');
    /* topScrollController.animateTo(sectionPosition != double.infinity ? sectionPosition :0.0,
         duration: const Duration(milliseconds: 100), curve: Curves.ease);*/
     topScrollController.animateTo(sectionPosition,
         duration: const Duration(milliseconds: 100), curve: Curves.ease);
   }
 }

    // if(scrollController2.hasClients){
    //   print("has client");
    //   scrollController1.animateTo(scrollIndex.value * topContainerWidth,
    //       duration: const Duration(milliseconds: 800),
    //       curve: Curves.ease);
    // }
    // itemScrollController1.scrollTo(
    //     index: scrollIndex.value,
    //     duration: const Duration(milliseconds: 10),
    //     curve: Curves.ease);
    // scrollIndex.value = itemPositionsListener2.itemPositions.value.first.index;
    // onCategorySelection(productCategoryList[scrollIndex.value].title);
    // itemScrollController1.scrollTo(
    //     index: scrollIndex.value,
    //     duration: const Duration(milliseconds: 10),
    //     curve: Curves.ease);
  }

  @override
  void dispose() {
    super.dispose();
    topScrollController.removeListener(topScrollListener);
    bottomScrollController.removeListener(bottomScrollListener);
    // itemPositionsListener2.itemPositions.removeListener(scrollItemListener);
  }
}
