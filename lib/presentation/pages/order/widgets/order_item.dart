import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:gshop/domain/model/model/order_model.dart';
import 'package:gshop/domain/model/response/refund_pagination_response.dart';
import 'package:gshop/domain/service/helper.dart';
import 'package:gshop/domain/service/tr_keys.dart';
import 'package:gshop/presentation/components/button/animation_button_effect.dart';
import 'package:gshop/presentation/route/app_route.dart';
import 'package:gshop/presentation/style/style.dart';
import 'package:gshop/presentation/style/theme/theme.dart';

class OrderItem extends StatelessWidget {
  final CustomColorSet colors;
  final OrderShops? order;

  final RefundModel? refundModel;
  final int index;
  final bool active;

  const OrderItem({
    super.key,
    required this.colors,
    this.order,
    required this.index,
    this.active = true,
    this.refundModel,
  });

  @override
  Widget build(BuildContext context) {
    print(
        'Calculate Current time=${DateTime.now().difference(order!.createdAt!).compareTo(Duration(hours: 2))}');
    print('Status=${order!.status!}');
    return ButtonEffectAnimation(
      onTap: () {
        if (refundModel != null) {
          AppRoute.goRefundOrderPage(context, colors, refundModel);
          return;
        }
        AppRoute.goOrderPage(context, order ?? OrderShops());
      },
      child: SizedBox(
        height: 82.r,
        child: Row(
          children: [
            if (active)
              Container(
                height: 60.r,
                width: 14.r,
                decoration: BoxDecoration(
                  color: colors.primary,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.r),
                      bottomLeft: Radius.circular(16.r)),
                ),
              ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  index == 0
                      ? Padding(
                          padding: EdgeInsets.only(right: 16.r),
                          child: const Divider(),
                        )
                      : SizedBox(
                          height: 2.r,
                        ),
                  const Spacer(),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 16.r),
                            child: Text(
                              refundModel == null
                                  ? "#${order?.idsByParent ?? "0"}"
                                  : "#${refundModel?.order?.id ?? 0}",
                              style: CustomStyle.interBold(
                                  color: colors.textBlack, size: 16),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 16.r, top: 8.r),
                            child: Row(
                              children: [
                                Text(
                                  AppHelper.numberFormat(
                                      number: refundModel == null
                                          ? order?.totalPriceByParent ??
                                              order?.totalPrice
                                          : refundModel?.order?.totalPrice),
                                  style: CustomStyle.interBold(
                                      color: colors.textBlack, size: 16),
                                ),
                                12.horizontalSpace,
                                Container(
                                  width: 4.r,
                                  height: 4.r,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: colors.textHint,
                                  ),
                                ),
                                12.horizontalSpace,
                                Text(
                                  AppHelper.dateFormatMDYHm(refundModel == null
                                      ? order?.deliveryDate
                                      : refundModel?.createdAt),
                                  style: CustomStyle.interNormal(
                                      color: colors.textBlack, size: 14),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      // Text("${order?.status=="canceled"}"),
                      (order?.status == "canceled")
                          ? Container(
                              alignment: Alignment.center,
                              width: 60,
                              height: 30,
                              decoration: BoxDecoration(
                                color: colors.primary,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                AppHelper.getTrn(TrKeys.canceled),
                                style: TextStyle(
                                    color: colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10),
                              ),
                            )
                          :
                          // if ()
                          order?.status == 'accepted'
                              ? Container(
                                  alignment: Alignment.center,
                                  width: 60,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    AppHelper.getTrn(TrKeys.accepted),
                                    style: TextStyle(
                                        color: colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10),
                                  ),
                                )
                              : DateTime.now()
                                          .difference(order!.createdAt!)
                                          .compareTo(Duration(hours: 2)) <
                                      0
                                  ? TimerCountdown(
                                      format: CountDownTimerFormat
                                          .hoursMinutesSeconds,
                                      spacerWidth: 5,
                                      hoursDescription:
                                          AppHelper.getTrn(TrKeys.hoursPrefix),
                                      minutesDescription: AppHelper.getTrn(
                                          TrKeys.minutesPrefix),
                                      secondsDescription: AppHelper.getTrn(
                                          TrKeys.secondsPrefix),
                                      timeTextStyle: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w900,
                                      ),
                                      descriptionTextStyle: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w900,
                                      ),
                                      colonsTextStyle: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w900,
                                      ),
                                      endTime: DateTime.now().add(
                                        DateTime.now()
                                            .difference(order!.createdAt!),
                                      ),
                                      onEnd: () {
                                        print("Timer finished");
                                      },
                                    )
                                  : Container(
                                      alignment: Alignment.center,
                                      width: 60,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: colors.primary,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        AppHelper.getTrn(TrKeys.canceled),
                                        style: TextStyle(
                                            color: colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10),
                                      ),
                                    ),

                      5.horizontalSpace,
                      Padding(
                        padding: EdgeInsets.only(right: 16.r),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: colors.textBlack,
                        ),
                      )
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
