// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gshop/application/product_detail/product_detail_bloc.dart';
import 'package:gshop/domain/model/model/product_model.dart';
import 'package:gshop/domain/service/helper.dart';
import 'package:gshop/domain/service/tr_keys.dart';
import 'package:gshop/presentation/components/custom_network_image.dart';
import 'package:gshop/presentation/route/app_route.dart';
import 'package:gshop/presentation/style/style.dart';
import 'package:gshop/presentation/style/theme/theme.dart';
import 'package:gshop/url_lunch_map.dart';

class ProductTitle extends StatelessWidget {
  final ProductData? product;
  final Stocks? selectStock;
  final CustomColorSet colors;

  const ProductTitle(
      {Key? key, required this.product, required this.colors, this.selectStock})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (selectStock?.discount != null)
            Padding(
              padding: EdgeInsets.only(bottom: 8.r),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: CustomStyle.red,
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                    padding: EdgeInsets.all(6.r),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/svg/discount.svg",
                          color: colors.white,
                        ),
                        4.horizontalSpace,
                        Text(
                          "-${((1 - (selectStock?.totalPrice ?? 1) / (selectStock?.price ?? 1)) * 100).toStringAsPrecision(2)} %",
                          style: CustomStyle.interNormal(
                              color: colors.white, size: 14),
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  Text(
                    AppHelper.numberFormat(number: selectStock?.price ?? 0),
                    style: CustomStyle.interNoSemi(
                        color: CustomStyle.red,
                        size: 14,
                        decoration: TextDecoration.lineThrough),
                  )
                ],
              ),
            ),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width / 2,
                child: Text(
                  product?.translation?.title ?? "",
                  style:
                      CustomStyle.interSemi(color: colors.textBlack, size: 22),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Spacer(),
              Text(
                AppHelper.numberFormat(number: selectStock?.totalPrice ?? 0),
                style: CustomStyle.interSemi(color: colors.textBlack, size: 22),
              )
            ],
          ),
          6.verticalSpace,
          Text(
            "${AppHelper.getTrn(TrKeys.sku)}: ${product?.id ?? ''}",
            style: CustomStyle.interNormal(color: colors.textBlack, size: 14),
          ),
          24.verticalSpace,
          UrlLauncherMap(
            latitude: product?.shop?.latLng?.latitude.toString() ?? '',
            longitude: product?.shop?.latLng?.longitude.toString() ?? '',
            address: product?.shop?.location?.address ?? '',
            child: Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.deepOrange,
                ),
                Text(
                  AppHelper.getTrn(TrKeys.arriveFaster),
                  style: CustomStyle.interNormal(
                      color: colors.textBlack, size: 16),
                ),
              ],
            ),
          ),
          24.verticalSpace,
          InkWell(
            onTap: () async {
              if (product?.brand != null) {
                await AppRoute.goProductList(
                    context: context,
                    brandId: product?.brandId,
                    title: product?.brand?.title);
                if (context.mounted) {
                  context
                      .read<ProductDetailBloc>()
                      .add(const ProductDetailEvent.updateState());
                }
              }
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: colors.icon),
              ),
              padding: EdgeInsets.all(16.r),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        CustomNetworkImage(
                            url: product?.brand?.img ?? "",
                            height: 24,
                            width: 24,
                            radius: 0),
                        5.horizontalSpace,
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width / 2 - 80.r,
                          child: Text(
                            "${AppHelper.getTrn(TrKeys.brand)} -${product?.brand?.title ?? AppHelper.getTrn(TrKeys.unKnow)}",
                            style: CustomStyle.interNormal(
                                textDecoration: TextDecoration.underline,
                                color: colors.textBlack,
                                size: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: () async {
                        if (product?.shop != null) {
                          await AppRoute.goShopPage(
                              context: context, shop: product?.shop);
                          if (context.mounted) {
                            context
                                .read<ProductDetailBloc>()
                                .add(const ProductDetailEvent.updateState());
                          }
                        }
                      },
                      child: Row(
                        children: [
                          Icon(
                            FlutterRemix.store_2_fill,
                            color: colors.textBlack,
                          ),
                          5.horizontalSpace,
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width / 2 - 80.r,
                            child: Text(
                              product?.shop?.translation?.title ??
                                  AppHelper.getTrn(TrKeys.unKnow),
                              style: CustomStyle.interNormal(
                                  textDecoration: TextDecoration.underline,
                                  color: colors.textBlack,
                                  size: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  UrlLauncherMap(
                    latitude: product?.shop?.latLng?.latitude.toString() ?? '',
                    longitude:
                        product?.shop?.latLng?.longitude.toString() ?? '',
                    address: product?.shop?.location?.address ?? '',
                    child: Icon(
                      Icons.location_on,
                      color: Colors.deepOrange,
                    ),
                  ),
                ],
              ),
            ),
          ),
          8.verticalSpace,
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: colors.icon),
            ),
            padding: EdgeInsets.all(16.r),
            child: Row(
              children: [
                ((selectStock?.quantity ?? 0) > 0)
                    ? SvgPicture.asset("assets/svg/inStock.svg")
                    : SvgPicture.asset(
                        "assets/svg/outOfStock.svg",
                        color: colors.textBlack,
                      ),
                10.horizontalSpace,
                Text(
                  "${AppHelper.getTrn(TrKeys.inStock)} - ${(selectStock?.quantity ?? 0) > 0 ? (selectStock?.quantity ?? 0) : 0} ${AppHelper.getTrn(TrKeys.product)}",
                  style: CustomStyle.interNormal(
                      color: colors.textBlack,
                      size:
                          "${AppHelper.getTrn(TrKeys.inStock)} - ${(selectStock?.quantity ?? 0) > 0 ? (selectStock?.quantity ?? 0) : 0} ${AppHelper.getTrn(TrKeys.product)}"
                                      .length >
                                  32
                              ? 14
                              : 12),
                ),
                const Spacer(),
                Container(
                  width: 6.r,
                  height: 6.r,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: colors.icon),
                ),
                const Spacer(),
                SvgPicture.asset(
                  "assets/svg/start.svg",
                  height: 16.r,
                ),
                6.horizontalSpace,
                Text(
                  "${product?.ratingAvg?.toStringAsPrecision(2) ?? "0.0"} ${AppHelper.getTrn(TrKeys.rating).toLowerCase()}",
                  style: CustomStyle.interNormal(
                      color: colors.textBlack, size: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
