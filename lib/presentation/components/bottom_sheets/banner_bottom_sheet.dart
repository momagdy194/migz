import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gshop/domain/model/response/banners_paginate_response.dart';
import 'package:gshop/domain/service/helper.dart';
import 'package:gshop/domain/service/tr_keys.dart';
import 'package:gshop/presentation/components/button/custom_button.dart';
import 'package:gshop/presentation/route/app_route.dart';
import 'package:gshop/presentation/style/style.dart';
import 'package:gshop/presentation/style/theme/theme.dart';

import '../blur_wrap.dart';
import '../custom_network_image.dart';

class BannerBottomSheet extends StatelessWidget {
  final BannerData banner;
  final CustomColorSet colors;

  const BannerBottomSheet(
      {Key? key, required this.banner, required this.colors})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlurWrap(
      radius: BorderRadius.only(
        topRight: Radius.circular(24.r),
        topLeft: Radius.circular(24.r),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: colors.newBoxColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(24.r),
            topLeft: Radius.circular(24.r),
          ),
        ),
        padding: EdgeInsets.all(16.r),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomNetworkImage(
                  // url: (banner.galleries?.first.path ?? ""),
                  url: (banner.img ?? ""),
                  preview:banner.galleries?.isEmpty??true?banner.img: banner.galleries?.first.preview,
                  height: 180,
                  width: double.infinity,
                  radius: 24),
              16.verticalSpace,
              Text(
                banner.translation?.title ?? "",
                style: CustomStyle.interNormal(
                  color: colors.textBlack,
                  size: 18,
                ),
              ),
              16.verticalSpace,
              Text(
                banner.translation?.description ?? "",
                style: CustomStyle.interRegular(
                  color: colors.textBlack,
                  size: 16,
                ),
              ),
              24.verticalSpace,
              CustomButton(
                  title: AppHelper.getTrn(TrKeys.viewProducts),
                  bgColor: CustomStyle.black,
                  titleColor: CustomStyle.white,
                  onTap: () {
                    AppRoute.goProductList(
                        context: context,
                        title: banner.translation?.description ?? "",
                        bannerId: banner.id);
                  }),
              16.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
