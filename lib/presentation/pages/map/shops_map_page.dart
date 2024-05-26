import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gshop/app_constants.dart';
import 'package:gshop/application/map/map_bloc.dart';
import 'package:gshop/application/shop/shop_bloc.dart';
import 'package:gshop/application/story/story_bloc.dart';
import 'package:gshop/domain/di/dependency_manager.dart';
import 'package:gshop/domain/model/model/location_model.dart';
import 'package:gshop/domain/model/model/shop_model.dart';
import 'package:gshop/domain/service/tr_keys.dart';
import 'package:gshop/presentation/components/button/custom_button.dart';
import 'package:gshop/presentation/pages/category/widgets/shop_item.dart';
import 'package:gshop/presentation/pages/map/widgets/shops_page_view.dart';
import 'package:gshop/presentation/style/style.dart';
import 'package:lottie/lottie.dart' as lottie;
import 'package:gshop/domain/service/helper.dart';
import 'package:gshop/presentation/components/custom_scaffold.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'widgets/main_list_shimmer.dart';
import 'widgets/my_location_button.dart';
import 'widgets/searched_location_item.dart';

class ShopsMapPage extends StatefulWidget {
  // final List<ShopData>? shops;

  // const ShopsMapPage({super.key, this.shops});

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
    // print('Length shops=${widget.shops!.length}');
    checkPermission();
    super.initState();
  }

  GoogleMapController? _mapController;

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
          // context.read<MapBloc>().add(MapEvent.goToTappedLocation(latLng));
        }
      }
    } else {
      if (check != LocationPermission.deniedForever) {
        var loc = await Geolocator.getCurrentPosition();
        final latLng = LatLng(loc.latitude, loc.longitude);
        if (context.mounted) {
          // context.read<MapBloc>().add(MapEvent.goToTappedLocation(latLng));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: (colors) => BlocBuilder<ShopBloc, ShopState>(
              builder: (context, state) {
                return state.isLoadingShops
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          GoogleMap(
                            markers: state.shops.map<Marker>(
                              (shop) {
                                return Marker(
                                    markerId: MarkerId(
                                      shop.latLng?.address ?? '',
                                    ),
                                    position: LatLng(
                                        double.parse(
                                            shop.latLng?.latitude ?? '0.0'),
                                        double.parse(
                                            shop.latLng?.longitude ?? '0.0')));
                              },
                            ).toSet(),
                            tiltGesturesEnabled: false,
                            myLocationButtonEnabled: false,
                            onTap: (location) {
                              // context
                              //     .read<MapBloc>()
                              //     .add(MapEvent.goToMyLocation(location: location));
                            },
                            zoomControlsEnabled: false,
                            initialCameraPosition: CameraPosition(
                              bearing: 0,
                              target: state.shops.isEmpty
                                  ?
                                  // widget.shops?.first.location == null
                                  //     ?
                                  const LatLng(30.033333, 31.233334)
                                  : LatLng(
                                      double.tryParse(state.shops.first.latLng
                                                  ?.latitude ??
                                              "0") ??
                                          AppHelper.getInitialLatitude(),
                                      double.tryParse(state.shops.first.latLng
                                                  ?.longitude ??
                                              "0") ??
                                          AppHelper.getInitialLongitude(),
                                    ),
                              tilt: 0,
                              zoom: 17,
                            ),
                            gestureRecognizers:
                                <Factory<OneSequenceGestureRecognizer>>[
                              new Factory<OneSequenceGestureRecognizer>(
                                () => new EagerGestureRecognizer(),
                              ),
                            ].toSet(),
                            onMapCreated: (controller) {
                              _mapController = controller; // context
                              //     .read<MapBloc>()
                              //     .add(MapEvent.setMapController(controller));
                            },
                            onCameraMoveStarted: () {
                              _animationController.repeat(
                                min: AppConstants.pinLoadingMin,
                                max: AppConstants.pinLoadingMax,
                                period: _animationController.duration! *
                                    (AppConstants.pinLoadingMax -
                                        AppConstants.pinLoadingMin),
                              );
                              // context
                              //     .read<MapBloc>()
                              //     .add(const MapEvent.setChoosing(true));
                            },
                            onCameraIdle: () {
                              // context.read<MapBloc>().add(MapEvent.fetchLocationName(
                              //   _cameraPosition?.target ??
                              //       (widget.shops?.first.location == null
                              //           ? LatLng(
                              //         AppHelper.getInitialLatitude(),
                              //         AppHelper.getInitialLongitude(),
                              //       )
                              //           : LatLng(
                              //         double.tryParse(widget.shops?.first
                              //             .location?.latitude ??
                              //             "0") ??
                              //             AppHelper.getInitialLatitude(),
                              //         double.tryParse(widget.shops?.first
                              //             .location?.longitude ??
                              //             "0") ??
                              //             AppHelper.getInitialLongitude(),
                              //       )),
                              // ));

                              // _animationController.forward(
                              //   from: AppConstants.pinLoadingMax,
                              // );

                              // context
                              //     .read<MapBloc>()
                              //     .add(const MapEvent.setChoosing(false));
                            },
                            onCameraMove: (cameraPosition) {
                              _cameraPosition = cameraPosition;
                            },
                          ),
                          SizedBox(
                            height: 250,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: PageView.builder(
                                  // shrinkWrap: true,
                                  onPageChanged: (index) {
                                    _mapController?.animateCamera(
                                      CameraUpdate.newCameraPosition(
                                        CameraPosition(
                                          target: LatLng(
                                            double.parse(state.shops[index]
                                                    .latLng?.latitude ??
                                                "0"),
                                            double.parse(state.shops[index]
                                                    .latLng?.longitude ??
                                                "0"),
                                          ),
                                          // LatLng(latitude, longitude),
                                          zoom: 17,
                                        ),
                                      ),
                                    );

                                    //
                                    // _mapController.animateCamera(C)
                                    // _cameraPosition = CameraPosition(
                                    //   target:
                                    //   LatLng(double.parse(state.shops[index].latLng?.latitude ?? "0"),
                                    //   double.parse(state.shops[index].latLng?.longitude ??"0"),)
                                    // ,
                                    //
                                    setState(() {});
                                  },
                                  scrollDirection: Axis.horizontal,
                                  // physics:
                                  // const NeverScrollableScrollPhysics(),
                                  // padding: EdgeInsets.only(
                                  //     right: 16.r, left: 16.r, bottom: 90.r),
                                  // shrinkWrap: true,
                                  controller: PageController(
                                    viewportFraction: 0.9,
                                    initialPage: 0,
                                  ),
                                  clipBehavior: Clip.none,
                                  // Here is the changed made

                                  itemCount: state.shops.length,
                                  itemBuilder: (context, index) {
                                    return
                                        // Text("aaaaa");

                                        ShopItemPage2(
                                      colors: colors,
                                      shop: state.shops[index],
                                    );
                                  }),
                            ),
                          ),
                        ],
                      );
              },
            ));
  }
}
