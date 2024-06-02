import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gshop/app_constants.dart';
import 'package:gshop/application/shop/shop_bloc.dart';
import 'package:gshop/presentation/components/custom_scaffold.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShopsMapPage extends StatefulWidget {
  @override
  State<ShopsMapPage> createState() => _ShopsMapPageState();
}

class _ShopsMapPageState extends State<ShopsMapPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  final GeolocatorPlatform _locator = GeolocatorPlatform.instance;
  CameraPosition? _cameraPosition;
  LocationPermission? check;
  GoogleMapController? _mapController;
  BitmapDescriptor? _myLocationIcon;
  BitmapDescriptor? _otherLocationIcon;
  LatLng? _myLocation;

  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
    _loadCustomMarkers();
    checkPermission().then((_) => getMyLocation());
  }

  Future<void> _loadCustomMarkers() async {
    _myLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(48, 48)),
        'assets/images/userlocation.png');

    _otherLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(48, 48)), 'assets/images/mylocation.png');

    setState(() {});
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> checkPermission() async {
    check = await _locator.checkPermission();
  }

  PageController _pageController = PageController(
    initialPage: 0,
    viewportFraction: 0.9,
  );

  Future<void> getMyLocation() async {
    if (check == LocationPermission.denied ||
        check == LocationPermission.deniedForever) {
      check = await Geolocator.requestPermission();
    }

    if (check != LocationPermission.denied &&
        check != LocationPermission.deniedForever) {
      var loc = await Geolocator.getCurrentPosition();
      final latLng = LatLng(loc.latitude, loc.longitude);
      setState(() {
        _myLocation = latLng;
        // _markers.add(Marker(
        //   markerId: MarkerId('my_location'),
        //   position: latLng,
        //   icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        // ));
      });

      // Move the camera to the current location
      if (_mapController != null) {
        _mapController!.animateCamera(CameraUpdate.newLatLngZoom(latLng, 17));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: (colors) => BlocBuilder<ShopBloc, ShopState>(
        builder: (context, state) {
          return (state.isLoadingShops || _myLocation == null)
              ? const Center(child: CircularProgressIndicator())
              : Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    GoogleMap(
                      markers: state.shops
                          .map((e) => Marker(
                                markerId: MarkerId(e.uuid.toString() ?? ''),
                                position: LatLng(
                                  double.parse(e.latLng?.latitude ?? '0.0'),
                                  double.parse(e.latLng?.longitude ?? '0.0'),
                                ),
                                icon: _otherLocationIcon ??
                                    BitmapDescriptor.defaultMarkerWithHue(
                                        BitmapDescriptor.hueRed),
                                onTap: () {
                                  print('Marker tapped with index: ${e.uuid}');
                                  _pageController.jumpToPage(state.shops
                                      .indexWhere(
                                          (element) => element.uuid == e.uuid));

                                  // _navigateToShopPage(shop);
                                },
                              ))
                          .toSet()
                        ..add(Marker(
                          markerId: MarkerId('my_location'),
                          position: _myLocation!,
                          icon: _myLocationIcon ??
                              BitmapDescriptor.defaultMarkerWithHue(
                                  BitmapDescriptor.hueGreen),
                        )),
                      // _buildMarkers(state.shops),

                      tiltGesturesEnabled: false,
                      myLocationButtonEnabled: false,
                      onTap: (location) {
                        // Handle map tap
                      },
                      zoomControlsEnabled: false,
                      initialCameraPosition: _myLocation != null
                          ? CameraPosition(
                              target: _myLocation!,
                              zoom: 17,
                            )
                          : CameraPosition(
                              target: state.shops.isEmpty
                                  ? const LatLng(30.033333, 31.233334)
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
                              zoom: 17,
                            ),
                      // _initialCameraPosition(state),
                      gestureRecognizers:
                          <Factory<OneSequenceGestureRecognizer>>[
                        Factory<OneSequenceGestureRecognizer>(
                            () => EagerGestureRecognizer()),
                      ].toSet(),
                      onMapCreated: (controller) {
                        _mapController = controller;
                      },
                      onCameraMoveStarted: () {
                        // _animationController.repeat(
                        //   min: AppConstants.pinLoadingMin,
                        //   max: AppConstants.pinLoadingMax,
                        //   period: _animationController.duration! *
                        //       (AppConstants.pinLoadingMax -
                        //           AppConstants.pinLoadingMin),
                        // );
                      },
                      onCameraIdle: () {
                        // _animationController.forward(
                        // from: AppConstants.pinLoadingMax);
                      },
                      onCameraMove: (cameraPosition) {
                        _cameraPosition = cameraPosition;
                      },
                    ),
                    Positioned(
                      bottom: 80,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 170,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: PageView.builder(
                              onPageChanged: (index) {
                                _mapController?.animateCamera(
                                  CameraUpdate.newCameraPosition(
                                    CameraPosition(
                                      target: LatLng(
                                        double.parse(state.shops[index].latLng
                                                ?.latitude ??
                                            "0"),
                                        double.parse(state.shops[index].latLng
                                                ?.longitude ??
                                            "0"),
                                      ),
                                      zoom: 17,
                                    ),
                                  ),
                                );
                                setState(() {});
                              },
                              scrollDirection: Axis.horizontal,
                              controller: _pageController,
                              clipBehavior: Clip.none,
                              itemCount: state.shops.length,
                              itemBuilder: (context, index) {
                                return ShopItemPage2(
                                  colors: colors,
                                  shop: state.shops[index],
                                );
                              }),
                        ),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }

  late CameraPosition _position;

  CameraPosition _initialCameraPosition(ShopState state) {
    if (_myLocation != null) {
      return _position = CameraPosition(
        bearing: 0,
        target: _myLocation!,
        tilt: 0,
        zoom: 17,
      );
    } else if (state.shops.isNotEmpty) {
      // If my location is not available, show the first shop's location
      return _position = CameraPosition(
        bearing: 0,
        target: LatLng(
          double.tryParse(state.shops.first.latLng?.latitude ?? "0") ?? 0,
          double.tryParse(state.shops.first.latLng?.longitude ?? "0") ?? 0,
        ),
        tilt: 0,
        zoom: 17,
      );
    } else {
      // If my location and shop locations are not available, show a default location
      return CameraPosition(
        bearing: 0,
        target: const LatLng(30.033333, 31.233334),
        // Default location (Cairo coordinates)
        tilt: 0,
        zoom: 17,
      );
    }
  }

  Set<Marker> _buildMarkers(List<ShopData> shops) {
    final markers = <Marker>{};

    for (int i = 0; i < shops.length; i++) {
      final shop = shops[i];
      final markerId = MarkerId(shop.latLng?.address ?? '');
      final position = LatLng(
        double.parse(shop.latLng?.latitude ?? '0.0'),
        double.parse(shop.latLng?.longitude ?? '0.0'),
      );

      final marker = Marker(
        markerId: markerId,
        position: position,
        onTap: () {
          print('Marker tapped with index: $i');
          // _navigateToShopPage(shop);
        },
      );

      markers.add(marker);
    }

    if (_myLocation != null) {
      markers.add(
        Marker(
          markerId: MarkerId('my_location'),
          position: _myLocation!,
        ),
      );
    }

    return markers;
  }
}
