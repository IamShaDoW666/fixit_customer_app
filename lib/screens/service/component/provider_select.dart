import 'package:booking_system_flutter/component/disabled_rating_bar_widget.dart';
import 'package:booking_system_flutter/component/image_border_component.dart';
import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/service_data_model.dart';
import 'package:booking_system_flutter/model/service_detail_response.dart';
import 'package:booking_system_flutter/model/user_data_model.dart';
import 'package:booking_system_flutter/network/rest_apis.dart';
import 'package:booking_system_flutter/screens/service/service_detail_screen.dart';
import 'package:booking_system_flutter/utils/colors.dart';
import 'package:booking_system_flutter/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class ProviderSelect extends StatelessWidget {
  final ScrollController scrollController;
  final ServiceData? serviceData;
  final List<UserData>? providers;
  final ServiceDetailResponse? data;
  final Function? bookNow;
  ProviderSelect({
    super.key,
    required this.scrollController,
    this.serviceData,
    this.providers,
    this.bookNow,
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecorationWithRoundedCorners(
          borderRadius:
              radiusOnly(topLeft: defaultRadius, topRight: defaultRadius),
          backgroundColor: context.cardColor),
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            8.height,
            Container(width: 40, height: 2, color: gray.withOpacity(0.3))
                .center(),
            24.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(language.selectProvider,
                    style: boldTextStyle(size: LABEL_TEXT_SIZE)),
              ],
            ),
            16.height,
            Divider(color: context.dividerColor),
            16.height,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: List.generate(
                  serviceData!.providers!.length,
                  (index) => ProviderWidget(
                        data: providers![index],
                        serviceData: serviceData,
                        bookNow: bookNow,
                        serviceDetailResponse: data,
                      )),
            )
          ],
        ),
      ),
    );
  }
}

class ProviderWidget extends StatefulWidget {
  final UserData data;
  final ServiceData? serviceData;
  final ServiceDetailResponse? serviceDetailResponse;
  final Function? bookNow;
  const ProviderWidget({
    Key? key,
    required this.data,
    this.serviceData,
    this.bookNow,
    this.serviceDetailResponse,
  }) : super(key: key);

  @override
  _ProviderSelectState createState() => _ProviderSelectState();
}

class _ProviderSelectState extends State<ProviderWidget> {
  @override
  void initState() {
    super.initState();
    getTaxDetails(providerId: 4);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          bookingStore.providerId = widget.data.id.validate();
          bookingStore.providerName = widget.data.displayName.validate();
          bookingStore.getTaxes(widget.data.id.validate());
        });
        if (widget.serviceData!.isSlotAvailable) {
          widget.bookNow!(widget.serviceDetailResponse);
        } else {
          finish(context);
        }
      },
      child: Container(
        color: cardColor,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            ImageBorder(
              src: widget.data.profileImage.validate(),
              height: 70,
              allowView: false,
            ),
            16.width,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(widget.data.displayName.validate(),
                            style: boldTextStyle())
                        .flexible(),
                    16.width,
                  ],
                ),
                4.height,
                DisabledRatingBarWidget(
                    rating: widget.data.providersServiceRating.validate()),
              ],
            ).expand(),
          ],
        ).paddingAll(24),
      ),
    );
  }
}
