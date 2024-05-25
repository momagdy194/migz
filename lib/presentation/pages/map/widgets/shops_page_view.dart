import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gshop/domain/model/model/shop_model.dart';

import 'shop_map_item.dart';

class ShopsPageView extends StatelessWidget {
  final List<ShopData> shops;
  const ShopsPageView({
    super.key,required this.shops,
  });

  @override
  Widget build(BuildContext context) {
    return ExpandablePageView(
        scrollDirection: Axis.horizontal,
        controller: PageController(),
        children: List.generate(shops.length, (index) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.sp),
          child: ShopMapItem(shop: shops[index]),
        )));
  }
}