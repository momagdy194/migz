import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gshop/app_constants.dart';
import 'package:gshop/application/map/map_bloc.dart';
import 'package:gshop/application/shop/shop_bloc.dart';
import 'package:gshop/domain/di/dependency_manager.dart';
import 'package:gshop/domain/model/model/location_model.dart';
import 'package:gshop/domain/model/model/shop_model.dart';
import 'package:gshop/domain/service/tr_keys.dart';
import 'package:gshop/presentation/components/button/custom_button.dart';
import 'package:gshop/presentation/pages/map/widgets/shops_page_view.dart';
import 'package:gshop/presentation/style/style.dart';
import 'package:lottie/lottie.dart' as lottie;
import 'package:gshop/domain/service/helper.dart';
import 'package:gshop/presentation/components/custom_scaffold.dart';

import 'widgets/main_list_shimmer.dart';
import 'widgets/my_location_button.dart';
import 'widgets/searched_location_item.dart';

class ShopsMapPage extends StatefulWidget {
  final List<ShopData>? shops;

  const ShopsMapPage({super.key, this.shops});

  @override
  State<ShopsMapPage> createState() => _ShopsMapPageState();
}

class _ShopsMapPageState extends State<ShopsMapPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  final GeolocatorPlatform _locator = GeolocatorPlatform.instance;
  CameraPosition? _cameraPosition;
  LocationPermission? check;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this);
    print('Length shops=${widget.shops!.length}');
    checkPermission();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  checkPermission() async {
    check = await _locator.checkPermission();
  }

  Future<void> getMyLocation() async {
    if (check == LocationPermission.denied ||
        check == LocationPermission.deniedForever) {
      check = await Geolocator.requestPermission();
      if (check != LocationPermission.denied &&
          check != LocationPermission.deniedForever) {
        var loc = await Geolocator.getCurrentPosition();
        final latLng = LatLng(loc.latitude, loc.longitude);
        if (context.mounted) {
          context.read<MapBloc>().add(MapEvent.goToTappedLocation(latLng));
        }
      }
    } else {
      if (check != LocationPermission.deniedForever) {
        var loc = await Geolocator.getCurrentPosition();
        final latLng = LatLng(loc.latitude, loc.longitude);
        if (context.mounted) {
          context.read<MapBloc>().add(MapEvent.goToTappedLocation(latLng));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
          body: (colors) => BlocBuilder<MapBloc, MapState>(
                builder: (context, state) {
                  return Stack(
                    children: [
                      GoogleMap(
                        markers: widget.shops!.map<Marker>(
                          (shop) {
                            return Marker(
                                markerId: MarkerId(
                                  shop.location?.address ?? '',
                                ),
                                position: LatLng(double.parse(shop.location?.latitude??'0.0'), double.parse(shop.location?.longitude??'0.0')));
                          },
                        ).toSet(),
                        tiltGesturesEnabled: false,
                        myLocationButtonEnabled: false,
                        onTap: (location) {
                          context
                              .read<MapBloc>()
                              .add(MapEvent.goToMyLocation(location: location));
                        },
                        zoomControlsEnabled: false,
                        initialCameraPosition: CameraPosition(
                          bearing: 0,
                          target: widget.shops?.first.location == null
                              ? LatLng(
                                  0.0,
                                  0.0,
                                )
                              : LatLng(
                                  double.tryParse(widget
                                              .shops?.first.location?.latitude ??
                                          "0") ??
                                      AppHelper.getInitialLatitude(),
                                  double.tryParse(widget
                                              .shops?.first.location?.longitude ??
                                          "0") ??
                                      AppHelper.getInitialLongitude(),
                                ),
                          tilt: 0,
                          zoom: 17,
                        ),
                        onMapCreated: (controller) {
                          context
                              .read<MapBloc>()
                              .add(MapEvent.setMapController(controller));
                        },
                        onCameraMoveStarted: () {
                          _animationController.repeat(
                            min: AppConstants.pinLoadingMin,
                            max: AppConstants.pinLoadingMax,
                            period: _animationController.duration! *
                                (AppConstants.pinLoadingMax -
                                    AppConstants.pinLoadingMin),
                          );
                          context
                              .read<MapBloc>()
                              .add(const MapEvent.setChoosing(true));
                        },
                        onCameraIdle: () {
                          context.read<MapBloc>().add(MapEvent.fetchLocationName(
                                _cameraPosition?.target ??
                                    (widget.shops?.first.location == null
                                        ? LatLng(
                                            AppHelper.getInitialLatitude(),
                                            AppHelper.getInitialLongitude(),
                                          )
                                        : LatLng(
                                            double.tryParse(widget.shops?.first
                                                        .location?.latitude ??
                                                    "0") ??
                                                AppHelper.getInitialLatitude(),
                                            double.tryParse(widget.shops?.first
                                                        .location?.longitude ??
                                                    "0") ??
                                                AppHelper.getInitialLongitude(),
                                          )),
                              ));

                          _animationController.forward(
                            from: AppConstants.pinLoadingMax,
                          );

                          context
                              .read<MapBloc>()
                              .add(const MapEvent.setChoosing(false));
                        },
                        onCameraMove: (cameraPosition) {
                          _cameraPosition = cameraPosition;
                        },
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          53.verticalSpace,
                          Row(
                            children: [
                              16.horizontalSpace,
                              MyLocationButton(
                                iconData: FlutterRemix.arrow_left_s_line,
                                width: 50,
                                onTap: () {
                                  if (_animationController.isCompleted) {
                                    Navigator.pop(context);
                                  }
                                },
                                colors: colors,
                              ),
                              6.horizontalSpace,
                              Expanded(
                                child: Container(
                                  height: 50.r,
                                  padding: REdgeInsets.symmetric(horizontal: 15),
                                  decoration: BoxDecoration(
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        color: colors.icon,
                                        offset: const Offset(0, 2),
                                        blurRadius: 2,
                                        spreadRadius: 0,
                                      ),
                                    ],
                                    color: colors.backgroundColor,
                                    borderRadius: BorderRadius.circular(25.r),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        FlutterRemix.search_line,
                                        size: 20.r,
                                        color: colors.textBlack,
                                      ),
                                      12.horizontalSpace,
                                      Expanded(
                                        child: TextFormField(
                                          controller: state.textController,
                                          style: CustomStyle.interNormal(
                                              color: colors.textBlack, size: 16),
                                          onChanged: (value) => context
                                              .read<MapBloc>()
                                              .add(MapEvent.setQuery(context)),
                                          cursorWidth: 1.r,
                                          cursorColor: colors.textBlack,
                                          decoration: InputDecoration.collapsed(
                                            hintText: AppHelper.getTrn(
                                                TrKeys.searchLocation),
                                            hintStyle: CustomStyle.interRegular(
                                                color: colors.textHint, size: 14),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () => context
                                            .read<MapBloc>()
                                            .add(const MapEvent
                                                .clearSearchField()),
                                        splashRadius: 20.r,
                                        padding: EdgeInsets.zero,
                                        icon: Icon(
                                          FlutterRemix.close_line,
                                          size: 20.r,
                                          color: colors.textBlack,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              16.horizontalSpace,
                            ],
                          ),
                          if (state.isSearching)
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.r),
                                color: colors.backgroundColor,
                              ),
                              margin: REdgeInsets.symmetric(
                                  horizontal: 16, vertical: 6),
                              padding: REdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: state.isSearchLoading
                                  ? const MainListShimmer()
                                  : ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: state.searchedPlaces.length,
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (context, index) {
                                        return SearchedLocationItem(
                                          place: state.searchedPlaces[index],
                                          isLast:
                                              state.searchedPlaces.length - 1 ==
                                                  index,
                                          onTap: () {
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                            context.read<MapBloc>().add(
                                                MapEvent.goToLocation(
                                                    place: state
                                                        .searchedPlaces[index]));
                                          },
                                          colors: colors,
                                        );
                                      },
                                    ),
                            ),
                        ],
                      ),
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 150),
                        bottom:  80.r,
                        left: 5.r,
                        right: 5.r,
                        child: ShopsPageView(
                          shops: widget.shops ?? [],
                        ),
                      ),
                    ],
                  );
                },
              ));
  }
}
