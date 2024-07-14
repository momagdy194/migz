import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gshop/application/banner/banner_bloc.dart';
import 'package:gshop/domain/service/helper.dart';
import 'package:gshop/presentation/components/button/animation_button_effect.dart';
import 'package:gshop/presentation/components/custom_network_image.dart';
import 'package:gshop/presentation/route/app_route.dart';
import 'package:gshop/presentation/style/theme/theme.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../components/shimmer/banner_shimmer.dart';

class BannerList2 extends StatelessWidget {
  final PageController pageController;
  final CustomColorSet colors;
  final RefreshController controller;
  final VoidCallback onLoading;

  const BannerList2(
      {Key? key,
      required this.pageController,
      required this.colors,
      required this.controller,
      required this.onLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannerBloc, BannerState>(
      builder: (context, state) {
        return Container(
          color: AppHelper.getType() == 2 || AppHelper.getType() == 3
              ? colors.newBoxColor
              : colors.transparent,
          padding: EdgeInsets.symmetric(vertical: 8.r),
          child: Column(
            children: [
              state.banners2.isNotEmpty || state.isLoadingBanner
                  ? SizedBox(
                      height: AppHelper.getType() == 0
                          ? 180.r
                          : AppHelper.getType() == 1
                              ? 220.r
                              : AppHelper.getType() == 2
                                  ? 360.r
                                  : 230.r,
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              if (state.banners2.isNotEmpty)
                                Expanded(
                                  child: SmartRefresher(
                                    enablePullDown: false,
                                    enablePullUp: true,
                                    controller: controller,
                                    scrollDirection: Axis.horizontal,
                                    onLoading: onLoading,
                                    child: PageView.builder(
                                        controller: pageController,
                                        itemCount: state.banners2.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return _bannerItem(
                                              context, state, index);
                                        }),
                                  ),
                                ),
                              if (state.isLoadingBanner) const BannerShimmer(),
                            ],
                          ),
                          if (state.banners2.length > 2 &&
                              AppHelper.getType() == 2)
                            Positioned(
                              bottom: 32.r,
                              left: 32.r,
                              child: SizedBox(
                                  height: 20,
                                  child: SmoothPageIndicator(
                                      controller: pageController,
                                      count: state.banners2.length,
                                      effect: ScrollingDotsEffect(
                                          dotWidth: 32.r,
                                          strokeWidth: 32.r,
                                          activeDotScale: 1,
                                          dotHeight: 6.r,
                                          activeDotColor: colors.textBlack,
                                          paintStyle: PaintingStyle.fill),
                                      onDotClicked: (index) {})),
                            )
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
              6.verticalSpace,
              if (state.banners2.length > 2 && AppHelper.getType() == 0)
                SizedBox(
                    height: 20,
                    child: SmoothPageIndicator(
                        controller: pageController,
                        count: state.banners2.length,
                        effect: ScrollingDotsEffect(
                            dotWidth: 6.r,
                            strokeWidth: 10.r,
                            activeDotScale: 1.7,
                            dotHeight: 6.r,
                            activeDotColor: colors.textBlack,
                            paintStyle: PaintingStyle.fill),
                        onDotClicked: (index) {}))
            ],
          ),
        );
      },
    );
  }

  Padding _bannerItem(BuildContext context, BannerState state, int index) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: AppHelper.getType() == 3 ? 0 : 16.r),
      child: ButtonEffectAnimation(
        onTap: () {
          // Navigator.push(context, MaterialPageRoute(builder: MaterialPageRoute(builder: (context) => ,)))
          // AppRoute.goBannerBottomSheet(context, state.banners[index], colors);
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: colors.icon),
              borderRadius:
                  BorderRadius.circular(AppHelper.getType() == 3 ? 0 : 24.r)),
          child: CustomNetworkImage(
              url: state.banners2[index].img.toString()
              //
              // state.banners[index].galleries?.isNotEmpty ?? false
              //     ? (state.banners[index].galleries?.first.path ?? "")
              //     : "",
              // preview: state.banners[index].galleries?.isNotEmpty ?? false
              //     ? state.banners[index].galleries?.first.preview
              //     : ""

              ,
              height: double.infinity,
              width: double.infinity,
              radius: AppHelper.getType() == 3 ? 0 : 24),
        ),
      ),
    );
  }
}
