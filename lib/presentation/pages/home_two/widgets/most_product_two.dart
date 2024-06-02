import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gshop/application/products/product_bloc.dart';
import 'package:gshop/domain/service/helper.dart';
import 'package:gshop/domain/service/tr_keys.dart';
import 'package:gshop/presentation/components/product_items/product_item.dart';
import 'package:gshop/presentation/components/title.dart';
import 'package:gshop/presentation/route/app_route.dart';
import 'package:gshop/presentation/style/theme/theme.dart';


class MostProductTwoList extends StatelessWidget {
  final CustomColorSet colors;

  const MostProductTwoList({Key? key, required this.colors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return state.mostSaleProduct.isNotEmpty || state.isLoadingMostSale
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TitleWidget(
                      isSale: true,
                      title: AppHelper.getTrn(TrKeys.mostSales),
                      titleColor: colors.textBlack,
                      subTitle: AppHelper.getTrn(TrKeys.seeAll),
                      onTap: () async {
                        await AppRoute.goProductList(
                          colors: colors,
                          context: context,
                          list: state.mostSaleProduct,
                          title: AppHelper.getTrn(TrKeys.mostSales),
                          total: state.mostSaleProductCount,
                          isNewProduct: false,
                          isMostSaleProduct: true,
                        );
                        if (context.mounted) {
                          context
                              .read<ProductBloc>()
                              .add(const ProductEvent.updateState());
                        }
                      },
                    ),
                  ),
                  16.verticalSpace,
                  GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding:
                          EdgeInsets.only(right: 16.r, left: 16.r, top: 16.r),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.8.r,
                          crossAxisCount: 2,
                          mainAxisExtent: 280.r),
                      itemCount: state.mostSaleProduct.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.r),
                          child: ProductItem(
                            product: state.mostSaleProduct[index],
                            height: 180,
                          ),
                        );
                      })
                ],
              )
            : const SizedBox.shrink();
      },
    );
  }
}
