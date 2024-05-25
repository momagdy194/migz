import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gshop/domain/model/model/shop_model.dart';

class ShopMapItem extends StatelessWidget {
  const ShopMapItem({
    super.key,
    required this.shop,
  });

  final ShopData shop;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Card(
        clipBehavior: Clip.hardEdge,
        elevation: 20,
        shadowColor: Colors.grey.withOpacity(0.5),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                  flex: 1,
                  child: CachedNetworkImage(imageUrl: shop.backgroundImg!,height:10,width:10,fit: BoxFit.cover,placeholder: (context, url) => Container(
                    color: Colors.redAccent,
                    alignment: Alignment.center,
                    child: AutoSizeText('No Image'),
                  ),)),
              SizedBox(width: 10.w,),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(shop?.seller?.firstname??'Title'),
                    SizedBox(height: 20.h,),
                    Text(shop?.location?.address??'Address'),
                    SizedBox(height: 10.h,),
                    Text(shop?.phone??'Description'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}