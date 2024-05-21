import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gshop/application/product_detail/product_detail_bloc.dart';
import 'package:gshop/application/products/product_bloc.dart';
import 'package:gshop/domain/model/model/product_model.dart';
import 'package:gshop/domain/model/model/review_data.dart';
import 'package:gshop/infrastructure/local_storage/local_storage.dart';
import 'package:gshop/presentation/components/custom_network_image.dart';
import 'package:gshop/presentation/route/app_route.dart';
import 'package:gshop/presentation/style/style.dart';
import 'package:gshop/presentation/style/theme/theme.dart';

import 'images_list.dart';

class ImageScreen extends StatelessWidget {
  final CustomColorSet colors;
  final ProductData? product;
  final List<Galleries>? galleries;
  final Galleries? selectImage;
  final PageController controller;
  final ScrollController scrollController;

  const ImageScreen({
    Key? key,
    required this.colors,
    required this.galleries,
    required this.product,
    required this.selectImage,
    required this.controller,
    required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 460.r,
          child: PageView.builder(
              itemCount: galleries?.length ?? 1,
              controller: controller,
              onPageChanged: (index) {
                context.read<ProductDetailBloc>().add(
                    ProductDetailEvent.selectImage(
                        image: galleries![index],
                        jumpTo: true,
                        nextImageTo: true));
              },
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    AppRoute.goOnlyImagePage(
                        context: context,
                        list: galleries ?? [],
                        selectIndex:
                            galleries?.indexOf(selectImage ?? Galleries()) ??
                                0);
                  },
                  child: CustomNetworkImage(
                      url: galleries?[index].path ?? "",
                      preview: galleries?[index].preview,
                      height: 428,
                      width: double.infinity,
                      fit: BoxFit.contain,
                      radius: 0),
                );
              }),
        ),
        SizedBox(
          height: 430.r,
          width: MediaQuery.sizeOf(context).width,
          child: Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.paddingOf(context).top, left: 4.r, right: 8.r),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.r),
                  child: Row(
                    children: [
                      const Spacer(),
                      IconButton(
                          splashColor: CustomStyle.transparent,
                          highlightColor: CustomStyle.transparent,
                          onPressed: () {
                            LocalStorage.setLikedProductsList(product?.id ?? 0);
                            context
                                .read<ProductBloc>()
                                .add(const ProductEvent.updateState());
                            context
                                .read<ProductDetailBloc>()
                                .add(const ProductDetailEvent.updateState());
                          },
                          icon: LocalStorage.getLikedProductsList()
                                  .contains(product?.id)
                              ? Icon(
                                  FlutterRemix.heart_3_fill,
                                  color: CustomStyle.red,
                                  size: 24.r,
                                )
                              : Icon(
                                  FlutterRemix.heart_3_line,
                                  size: 24.r,
                                )),
                      IconButton(
                          splashColor: CustomStyle.transparent,
                          highlightColor: CustomStyle.transparent,
                          onPressed: () {
                            LocalStorage.setCompareList(product?.id ?? 0);
                            context
                                .read<ProductDetailBloc>()
                                .add(const ProductDetailEvent.updateState());
                          },
                          icon: LocalStorage.getCompareList()
                                  .contains(product?.id)
                              ? Icon(
                                  FlutterRemix.stack_fill,
                                  color: CustomStyle.primary,
                                  size: 24.r,
                                )
                              : Icon(
                                  FlutterRemix.stack_line,
                                  size: 24.r,
                                )),
                    ],
                  ),
                ),
                const Spacer(),
                if (galleries?.isNotEmpty ?? false)
                  ImagesList(
                    list: galleries ?? [],
                    selectImageId: selectImage?.id ?? 0,
                    controller: scrollController,
                  )
              ],
            ),
          ),
        )
      ],
    );
  }
}
