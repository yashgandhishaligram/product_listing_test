import 'package:flutter/cupertino.dart';

class AppConstants {
  static final categories = [
    {
      "categoryId": 2,
      "categoryName": "CLOTHES",
      "status": "1",
      "productCount": 1,
      "createdBy": null
    },
    {
      "categoryId": 8,
      "categoryName": "Dress",
      "status": "1",
      "productCount": 0,
      "createdBy": null
    },
    {
      "categoryId": 1,
      "categoryName": "ELECTRONICS",
      "status": "1",
      "productCount": 0,
      "createdBy": null
    },
    {
      "categoryId": 9,
      "categoryName": "Jackets",
      "status": "1",
      "productCount": 0,
      "createdBy": null
    },
    {
      "categoryId": 7,
      "categoryName": "Mobile Phones",
      "status": "1",
      "productCount": 0,
      "createdBy": null
    },
    {
      "categoryId": 6,
      "categoryName": "Mobiles",
      "status": "1",
      "productCount": 0,
      "createdBy": null
    },
    {
      "categoryId": 3,
      "categoryName": "SHOES",
      "status": "1",
      "productCount": 0,
      "createdBy": null
    },
    {
      "categoryId": 5,
      "categoryName": "Watches",
      "status": "1",
      "productCount": 0,
      "createdBy": null
    }
  ];
  static final bannerImageUrls = [
    "https://img.freepik.com/free-vector/mega-sale-banner-blue-yellow-colors_1017-32176.jpg?w=1380&t=st=1703332837~exp=1703333437~hmac=7d60e582895ff5720cc4074034745c95a85587d903affe25818d3bd252738a04",
    "https://img.freepik.com/free-psd/super-sale-banner_1393-365.jpg?1&w=1380&t=st=1703332904~exp=1703333504~hmac=5595c7b8fa2c95e4564d072225a42fa489295464540d88c7e6eb9e02974cc315",
    "https://img.freepik.com/free-vector/happy-diwali-sale-banner-with-discount-details-pink-background_1017-39845.jpg?w=1380&t=st=1703332938~exp=1703333538~hmac=68747efc14bc7e69f23932bb45570ea904929e016205ef7d03b47cc60d453c1a",
    "https://img.freepik.com/free-vector/modern-super-sale-promotion-bright-banner_1055-6985.jpg?w=1380&t=st=1703332979~exp=1703333579~hmac=8ec6060ece589701738b900b1df25561e9335c661b691bdbfe27ad3f9b36b797"
  ];

  static const description ="Minimal Stand is made of by natural wood. The design that is very simple and minimal. This is truly one of the best furnitures in any family for now. With 3 different colors, you can easily select the best match for your home. This is truly one of the best furnitures in any family for now. With 3 different colors, you can easily select the best match for your home. ";
}

extension EmptySpace on num {
  SizedBox get height => SizedBox(height: toDouble());

  SizedBox get width => SizedBox(width: toDouble());
}

extension ListExtension<E> on List<E> {
  void addAllUnique(Iterable<E> iterable) {
    for (var element in iterable) {
      if (!contains(element)) {
        add(element);
      }
    }
  }
}

extension UtilListExtension on List{
  groupBy(String key) {
    try {
      List<Map<String, dynamic>> result = [];
      List<String> keys = [];

      forEach((f) => keys.add(f[key]));

      [...keys.toSet()].forEach((k) {
        List data = [...where((e) => e[key] == k)];
        result.add({k: data});
      });
      return result;
    } catch (e) {
      print(e);
      return this;
    }
  }
}
