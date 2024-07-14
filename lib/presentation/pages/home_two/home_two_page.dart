import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gshop/application/banner/banner_bloc.dart';
import 'package:gshop/application/blog/blog_bloc.dart';
import 'package:gshop/application/brand/brand_bloc.dart';
import 'package:gshop/application/category/category_bloc.dart';
import 'package:gshop/application/filter/filter_bloc.dart';
import 'package:gshop/application/main/main_bloc.dart';
import 'package:gshop/application/notification/notification_bloc.dart';
import 'package:gshop/application/products/product_bloc.dart';
import 'package:gshop/domain/di/dependency_manager.dart';
import 'package:gshop/domain/service/helper.dart';
import 'package:gshop/domain/service/tr_keys.dart';
import 'package:gshop/infrastructure/local_storage/local_storage.dart';
import 'package:gshop/presentation/components/button/filter_button.dart';
import 'package:gshop/presentation/components/custom_scaffold.dart';
import 'package:gshop/presentation/components/custom_textformfield.dart';
import 'package:gshop/presentation/pages/home/widgets/all_product_list.dart';
import 'package:gshop/presentation/pages/home/widgets/banner_list.dart';
import 'package:gshop/presentation/pages/home_two/widgets/brands_two_list.dart';
import 'package:gshop/presentation/pages/home_two/widgets/most_product_two.dart';
import 'package:gshop/presentation/pages/home_two/widgets/new_product_two.dart';
import 'package:gshop/presentation/route/app_route.dart';
import 'package:gshop/presentation/style/style.dart';
import 'package:gshop/presentation/style/theme/theme.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'widgets/ads_two_list.dart';
import 'widgets/category_two_list.dart';
import 'widgets/looks_list_two.dart';

class HomeTwoPage extends StatefulWidget {
  const HomeTwoPage({super.key});

  @override
  State<HomeTwoPage> createState() => _HomeTwoPageState();
}

class _HomeTwoPageState extends State<HomeTwoPage> {
  late RefreshController categoryRefresh;
  late RefreshController brandRefresh;
  late RefreshController productRefresh;
  late RefreshController looksRefresh;
  late RefreshController adsRefresh;
  late RefreshController bannerRefresh;
  late ScrollController scrollController;
  late PageController pageController;

  void listen() {
    final direction = scrollController.position.userScrollDirection;
    if (direction == ScrollDirection.reverse) {
      context.read<MainBloc>().add(const MainEvent.showSearch(value: false));
    } else if (direction == ScrollDirection.forward) {
      context.read<MainBloc>().add(const MainEvent.showSearch(value: true));
    }
  }

  Future<void> getMyLocation() async {
    print("getMyLocationgetMyLocation");
    LocationPermission check = await Geolocator.requestPermission();

    if (check == LocationPermission.denied ||
        check == LocationPermission.deniedForever) {
      check = await Geolocator.requestPermission();
    }

    if (check != LocationPermission.denied &&
        check != LocationPermission.deniedForever) {
      try {
        var loc = await Geolocator.getCurrentPosition();
        final latLng = LatLng(loc.latitude, loc.longitude);
        setState(() {
          // _myLocation = latLng;
          // _markers.add(Marker(
          //   markerId: MarkerId('my_location'),
          //   position: latLng,
          //   icon: BitmapDescriptor.defaultMarkerWithHue(
          //       BitmapDescriptor.hueGreen),
          // ));
        });
        // print("_markers_markers ${_markers}");
        // // Move the camera to the current location
        // if (_mapController != null) {
        //   _mapController!.animateCamera(CameraUpdate.newLatLngZoom(latLng, 17));
      } catch (e) {
        print("objectobjectobject ${e}");
      }
    }
  }

  @override
  void initState() {
    categoryRefresh = RefreshController();
    productRefresh = RefreshController();
    looksRefresh = RefreshController();
    adsRefresh = RefreshController();
    bannerRefresh = RefreshController();
    brandRefresh = RefreshController();
    pageController = PageController();
    scrollController = ScrollController();
    scrollController.addListener(listen);
    getMyLocation();
    super.initState();
  }

  @override
  void dispose() {
    categoryRefresh.dispose();
    productRefresh.dispose();
    pageController.dispose();
    looksRefresh.dispose();
    adsRefresh.dispose();
    brandRefresh.dispose();
    bannerRefresh.dispose();
    scrollController.removeListener(listen);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: (colors) => _buildAppBar(colors),
      body: (colors) {
        return Column(
          children: [
            8.verticalSpace,
            BlocBuilder<MainBloc, MainState>(
              buildWhen: (p, n) {
                return p.isShowSearch != n.isShowSearch;
              },
              builder: (context, state) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  height: state.isShowSearch ? 54.r : 0,
                  child: state.isShowSearch
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: CustomTextFormField(
                                  borderColor: Colors.grey,

                                  onTap: () {
                                    AppRoute.goSearchPage(context: context);
                                  },
                                  readOnly: true,
                                  // radius: 0,
                                  prefixIcon: const Icon(
                                    FlutterRemix.search_2_line,
                                    color: CustomStyle.textHint,
                                  ),
                                  hint: AppHelper.getTrn(TrKeys.search),
                                ),
                              ),
                              FilterButton(
                                  colors: colors,
                                  onTap: () async {
                                    await AppRoute.goProductList(
                                      context: context,
                                      // list: state.mostSaleProduct,
                                      showFilter: true,
                                      colors: colors,
                                      title: "",
                                      // total: state.mostSaleProductCount,
                                      isNewProduct: false,
                                      isMostSaleProduct: true,
                                    );
                                    if (context.mounted) {
                                      context.read<ProductBloc>().add(
                                          const ProductEvent.updateState());
                                    }
                                  })
                            ],
                          ),
                        )
                      : const SizedBox.shrink(),
                );
              },
            ),
            Expanded(
              child: SmartRefresher(
                scrollController: scrollController,
                controller: productRefresh,
                enablePullUp: true,
                onRefresh: () {
                  context.read<CategoryBloc>().add(CategoryEvent.fetchCategory(
                      context: context,
                      isRefresh: true,
                      controller: productRefresh));
                  context.read<ProductBloc>()
                    ..add(ProductEvent.fetchMostSaleProduct(
                        context: context,
                        isRefresh: true,
                        controller: productRefresh))
                    ..add(ProductEvent.fetchNewProduct(
                        context: context,
                        isRefresh: true,
                        controller: productRefresh))
                    ..add(ProductEvent.fetchAllProduct(
                        context: context,
                        isRefresh: true,
                        controller: productRefresh));
                  context.read<BlogBloc>().add(BlogEvent.fetchBlog(
                      context: context,
                      isRefresh: true,
                      controller: productRefresh));
                  context.read<BannerBloc>()
                    ..add(BannerEvent.fetchBanner(
                bannersType: "products",
                        context: context,
                        isRefresh: true,
                        controller: productRefresh))
                    ..add(BannerEvent.fetchBanner2(
                bannersType: "shops",
                        context: context,
                        isRefresh: true,
                        controller: productRefresh))
                    ..add(BannerEvent.fetchLooks(
                        context: context,
                        isRefresh: true,
                        controller: productRefresh))
                    ..add(BannerEvent.fetchAdsBanner(
                        context: context,
                        isRefresh: true,
                        controller: productRefresh))
                    ..add(BannerEvent.fetchAdsListProduct(
                        context: context, isRefresh: true));
                  context.read<BrandBloc>().add(BrandEvent.fetchBrands(
                      context: context,
                      isRefresh: true,
                      controller: productRefresh));
                  productRefresh.resetNoData();
                },
                onLoading: () {
                  context.read<ProductBloc>().add(ProductEvent.fetchAllProduct(
                      context: context, controller: productRefresh));
                  context.read<BannerBloc>().add(
                      BannerEvent.fetchAdsListProduct(
                          context: context, controller: productRefresh));
                },
                child: ListView(
                  shrinkWrap: true,
                  controller: scrollController,
                  children: [
                    BannerList(
                      pageController: pageController,
                      colors: colors,
                      controller: bannerRefresh,
                      onLoading: () {
                        context.read<BannerBloc>().add(BannerEvent.fetchBanner(
                          bannersType: 'products',
                            context: context, controller: bannerRefresh));
                      },
                    ),
                    BrandsTwoList(brandRefresh: brandRefresh, colors: colors),
                    CategoryTwoList(
                        categoryRefresh: categoryRefresh, colors: colors),
                    MostProductTwoList(colors: colors),
                    LooksListTwo(
                      colors: colors,
                      controller: looksRefresh,
                      onLoading: () {
                        context.read<BannerBloc>().add(BannerEvent.fetchLooks(
                            context: context, controller: looksRefresh));
                      },
                    ),
                    NewProductTwoList(colors: colors),
                    AdsTwoList(
                      colors: colors,
                      controller: adsRefresh,
                      onLoading: () {
                        context.read<BannerBloc>().add(
                            BannerEvent.fetchAdsBanner(
                                context: context, controller: adsRefresh));
                      },
                    ),
                    AllProductList(colors: colors),
                    80.verticalSpace,
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  AppBar _buildAppBar(CustomColorSet colors) {
    return AppBar(
      backgroundColor: colors.backgroundColor,
      elevation: 0.0,
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {
              if (LocalStorage.getToken().isEmpty) {
                AppRoute.goLogin(context);
                return;
              }
              AppRoute.goNotification(context: context);
            },
            icon: Badge(
              label: (LocalStorage.getToken().isEmpty)
                  ? const Text("0")
                  : BlocBuilder<NotificationBloc, NotificationState>(
                      builder: (context, state) {
                        return Text(state.countOfNotifications?.notification
                                .toString() ??
                            "0");
                      },
                    ),
              child: Icon(
                FlutterRemix.notification_line,
                color: colors.textBlack,
              ),
            ))
      ],
      leading: IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: Icon(
            FlutterRemix.menu_line,
            color: colors.textBlack,
          )),
      title: Text(
        AppHelper.getAppName(),
        style: CustomStyle.interSemi(
          color: colors.textBlack,
          size: 22,
        ),
      ),
    );
  }
}
