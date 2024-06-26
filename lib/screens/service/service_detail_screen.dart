import 'package:booking_system_flutter/component/loader_widget.dart';
import 'package:booking_system_flutter/component/view_all_label_component.dart';
import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/package_data_model.dart';
import 'package:booking_system_flutter/model/service_data_model.dart';
import 'package:booking_system_flutter/model/service_detail_response.dart';
import 'package:booking_system_flutter/model/slot_data.dart';
import 'package:booking_system_flutter/model/user_data_model.dart';
import 'package:booking_system_flutter/network/rest_apis.dart';
import 'package:booking_system_flutter/screens/booking/book_service_screen.dart';
import 'package:booking_system_flutter/screens/booking/component/booking_detail_provider_widget.dart';
import 'package:booking_system_flutter/screens/booking/provider_info_screen.dart';
import 'package:booking_system_flutter/screens/review/components/review_widget.dart';
import 'package:booking_system_flutter/screens/review/rating_view_all_screen.dart';
import 'package:booking_system_flutter/screens/service/component/multiply_option.dart';
import 'package:booking_system_flutter/screens/service/component/package_option.dart';
import 'package:booking_system_flutter/screens/service/component/provider_select.dart';
import 'package:booking_system_flutter/screens/service/component/service_component.dart';
import 'package:booking_system_flutter/screens/service/component/service_detail_header_component.dart';
import 'package:booking_system_flutter/screens/service/component/service_faq_widget.dart';
import 'package:booking_system_flutter/screens/service/package/package_component.dart';
import 'package:booking_system_flutter/screens/service/shimmer/service_detail_shimmer.dart';
import 'package:booking_system_flutter/utils/colors.dart';
import 'package:booking_system_flutter/utils/common.dart';
import 'package:booking_system_flutter/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../store/booking_store.dart';
import 'component/multi_option.dart';
import 'component/quantity_option.dart';
import 'component/single_option.dart';

//Booking Store
BookingStore bookingStore = BookingStore();

class ServiceDetailScreen extends StatefulWidget {
  final int serviceId;
  final ServiceData? service;

  ServiceDetailScreen({required this.serviceId, this.service});

  @override
  _ServiceDetailScreenState createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen>
    with TickerProviderStateMixin {
  PageController pageController = PageController();

  Future<ServiceDetailResponse>? future;

  int selectedAddressId = 0;
  int selectedBookingAddressId = -1;
  BookingPackage? selectedPackage;
  @override
  void initState() {
    super.initState();
    setStatusBarColor(transparentColor);
    init();
  }

  void init() async {
    print('____________________');
    future = getServiceDetails(
        serviceId: widget.serviceId.validate(), customerId: appStore.userId);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    setStatusBarColor(transparentColor);
    super.dispose();
  }

  //region Widgets
  Widget availableWidget({required ServiceData data}) {
    if (data.serviceAddressMapping != null) return Offstage();

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(language.lblAvailableAt,
              style: boldTextStyle(size: LABEL_TEXT_SIZE)),
          16.height,
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: List.generate(
              data.serviceAddressMapping!.length,
              (index) {
                ServiceAddressMapping value =
                    data.serviceAddressMapping![index];
                if (value.providerAddressMapping == null) return Offstage();

                bool isSelected = selectedAddressId == index;
                if (selectedBookingAddressId == -1) {
                  selectedBookingAddressId = data
                      .serviceAddressMapping!.first.providerAddressId
                      .validate();
                }
                return GestureDetector(
                  onTap: () {
                    selectedAddressId = index;
                    selectedBookingAddressId =
                        value.providerAddressId.validate();
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: boxDecorationDefault(
                        color: isSelected ? primaryColor : context.cardColor),
                    child: Text(
                      '${value.providerAddressMapping!.address.validate()}',
                      style: boldTextStyle(
                          color: isSelected
                              ? Colors.white
                              : textPrimaryColorGlobal),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget providerWidget({required UserData data}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 16.height,
        BookingDetailProviderWidget(providerData: data).onTap(() async {
          await ProviderInfoScreen(providerId: data.id).launch(context);
          setStatusBarColor(Colors.transparent);
        }),
      ],
    ).paddingAll(16);
  }

  Widget serviceFaqWidget({required List<ServiceFaq> data}) {
    if (data.isEmpty) return Offstage();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ViewAllLabel(label: language.lblFaq, list: data),
          8.height,
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: data.length,
            padding: EdgeInsets.all(0),
            itemBuilder: (_, index) =>
                ServiceFaqWidget(serviceFaq: data[index]),
          ),
          8.height,
        ],
      ),
    );
  }

  Widget slotsAvailable(
      {required List<SlotData> data, required bool isSlotAvailable}) {
    if (!isSlotAvailable ||
        data.where((element) => element.slot.validate().isNotEmpty).isEmpty)
      return Offstage();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ViewAllLabel(label: language.lblAvailableOnTheseDays, list: []),
        6.height,
        Wrap(
          spacing: 16,
          runSpacing: 8,
          children: List.generate(
              data
                  .where((element) => element.slot.validate().isNotEmpty)
                  .length, (index) {
            SlotData value = data
                .where((element) => element.slot.validate().isNotEmpty)
                .toList()[index];
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: boxDecorationDefault(color: context.cardColor),
              child: Text('${value.day.capitalizeFirstLetter()}',
                  style: secondaryTextStyle(
                      size: LABEL_TEXT_SIZE, color: primaryColor)),
            );
          }),
        ),
      ],
    ).paddingAll(16);
  }

  Widget reviewWidget(
      {required List<RatingData> data,
      required ServiceDetailResponse serviceDetailResponse}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ViewAllLabel(
          //label: language.review,
          label:
              '${language.review} (${serviceDetailResponse.serviceDetail!.totalReview})',
          list: data,
          onTap: () {
            RatingViewAllScreen(serviceId: widget.serviceId).launch(context);
          },
        ),
        data.isNotEmpty
            ? Wrap(
                children: List.generate(
                  data.length,
                  (index) => ReviewWidget(data: data[index]),
                ),
              ).paddingTop(8)
            : Text(language.lblNoReviews, style: secondaryTextStyle()),
      ],
    ).paddingSymmetric(horizontal: 16);
  }

  Widget relatedServiceWidget(
      {required List<ServiceData> serviceList, required int serviceId}) {
    if (serviceList.isEmpty) return Offstage();

    serviceList.removeWhere((element) => element.id == serviceId);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        8.height,
        if (serviceList.isNotEmpty)
          Text(language.lblRelatedServices,
                  style: boldTextStyle(size: LABEL_TEXT_SIZE))
              .paddingSymmetric(horizontal: 16),
        if (serviceList.isNotEmpty)
          HorizontalList(
            itemCount: serviceList.length,
            padding: EdgeInsets.all(16),
            spacing: 8,
            runSpacing: 16,
            itemBuilder: (_, index) => ServiceComponent(
                    serviceData: serviceList[index],
                    width: context.width() / 2 - 26)
                .paddingOnly(right: 8),
          ),
        16.height,
      ],
    );
  }

  //endregion

  void bookNow(ServiceDetailResponse serviceDetailResponse) {
    doIfLoggedIn(context, () {
      serviceDetailResponse.serviceDetail!.bookingAddressId =
          selectedBookingAddressId;
      BookServiceScreen(
              data: serviceDetailResponse, selectedPackage: selectedPackage)
          .launch(context)
          .then((value) {
        setStatusBarColor(transparentColor);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget buildBodyWidget(AsyncSnapshot<ServiceDetailResponse> snap) {
      if (snap.hasError) {
        return Text(snap.error.toString()).center();
      } else if (snap.hasData) {
        return Stack(
          children: [
            AnimatedScrollView(
              padding: EdgeInsets.only(bottom: 120),
              listAnimationType: ListAnimationType.FadeIn,
              fadeInConfiguration: FadeInConfiguration(duration: 2.seconds),
              onSwipeRefresh: () async {
                appStore.setLoading(true);
                init();
                setState(() {});

                return await 2.seconds.delay;
              },
              children: [
                ServiceDetailHeaderComponent(
                    serviceDetail: snap.data!.serviceDetail!),
                if (snap.data!.serviceDetail!.description.validate().isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      8.height,
                      Text(language.hintDescription,
                          style: boldTextStyle(size: LABEL_TEXT_SIZE)),
                      8.height,
                      snap.data!.serviceDetail!.description
                              .validate()
                              .isNotEmpty
                          ? Html(
                              data: snap.data!.serviceDetail!.description
                                  .validate(),
                              // style: secondaryTextStyle(),
                              // colorClickableText: context.primaryColor,
                              // textAlign: TextAlign.justify,
                            )
                          : Text(language.lblNotDescription,
                              style: secondaryTextStyle()),
                    ],
                  ).paddingAll(16),
                if (snap.data!.serviceDetail!.options != null &&
                    snap.data!.serviceDetail!.options!
                        .any((element) => element.area! > 0))
                  Observer(builder: (_) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (bookingStore.selectedOptions
                            .any((element) => element['area'] != null))
                          Text("Approx. sqft: " +
                                  bookingStore.getApproximateArea.toString())
                              .paddingSymmetric(horizontal: 18),
                      ],
                    );
                  }),
                OptionsWidget(snap.data!.serviceDetail!.options.validate(),
                        snap.data!.serviceDetail)
                    .paddingAll(16),

                // slotsAvailable(
                //     data: snap.data!.serviceDetail!.bookingSlots.validate(),
                //     isSlotAvailable: snap.data!.serviceDetail!.isSlotAvailable),
                // availableWidget(data: snap.data!.serviceDetail!),
                // providerWidget(data: snap.data!.provider!),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    8.height,
                    Text(language.inclusions,
                        style: boldTextStyle(size: LABEL_TEXT_SIZE)),
                    8.height,
                    snap.data!.serviceDetail!.inclusions.validate().isNotEmpty
                        ? Html(
                            data:
                                snap.data!.serviceDetail!.inclusions.validate(),
                          )
                        : Text(language.lblNotDescription,
                            style: secondaryTextStyle()),
                  ],
                ).paddingAll(16),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    8.height,
                    Text(language.exclusions,
                        style: boldTextStyle(size: LABEL_TEXT_SIZE)),
                    8.height,
                    snap.data!.serviceDetail!.exclusions.validate().isNotEmpty
                        ? Html(
                            data:
                                snap.data!.serviceDetail!.exclusions.validate(),
                            // style: secondaryTextStyle(),
                            // colorClickableText: context.primaryColor,
                            // textAlign: TextAlign.justify,
                          )
                        : Text(language.lblNotDescription,
                            style: secondaryTextStyle()),
                  ],
                ).paddingAll(16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    8.height,
                    Text(language.notes,
                        style: boldTextStyle(size: LABEL_TEXT_SIZE)),
                    8.height,
                    snap.data!.serviceDetail!.notes.validate().isNotEmpty
                        ? Html(
                            data: snap.data!.serviceDetail!.notes.validate(),
                            // style: secondaryTextStyle(),
                            // colorClickableText: context.primaryColor,
                            // textAlign: TextAlign.justify,
                          )
                        : Text(language.lblNotDescription,
                            style: secondaryTextStyle()),
                  ],
                ).paddingAll(16),

                Column(
                  children: [
                    Text("Providers",
                        style: boldTextStyle(size: LABEL_TEXT_SIZE)),
                    ...List.generate(
                        snap.data!.providers!.length,
                        (index) =>
                            providerWidget(data: snap.data!.providers![index]))
                  ],
                ),

                /// Only active status package display
                if (snap.data!.serviceDetail!.servicePackage
                    .validate()
                    .isNotEmpty)
                  PackageComponent(
                    servicePackage:
                        snap.data!.serviceDetail!.servicePackage.validate(),
                    callBack: (v) {
                      if (v != null) {
                        selectedPackage = v;
                      } else {
                        selectedPackage = null;
                      }
                      bookNow(snap.data!);
                    },
                  ),
                serviceFaqWidget(data: snap.data!.serviceFaq.validate()),
                reviewWidget(
                    data: snap.data!.ratingData!,
                    serviceDetailResponse: snap.data!),
                // 24.height,
                // if (snap.data!.relatedService.validate().isNotEmpty)
                //   relatedServiceWidget(
                //       serviceList: snap.data!.relatedService.validate(),
                //       serviceId: snap.data!.serviceDetail!.id.validate()),
              ],
            ),
            Positioned(
                bottom: 88,
                right: 16,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: primaryColor,
                      boxShadow: [BoxShadow()]),
                  child: Observer(
                    builder: (_) => Text(
                      "${isCurrencyPositionLeft ? appStore.currencySymbol : ''}${(bookingStore.subTotal.validate() + snap.data!.serviceDetail!.price.validate()).toStringAsFixed(DECIMAL_POINT).formatNumberWithComma()}${isCurrencyPositionRight ? appStore.currencySymbol : ''}",
                      style: boldTextStyle(color: white, size: 16),
                    ).paddingAll(16),
                  ),
                )),
            Positioned(
              bottom: isIOS ? 32 : 16,
              left: 16,
              right: 16,
              child: AppButton(
                onTap: () {
                  if (bookingStore.subTotal <= 0) {
                    toast("Please select an Item");
                    return;
                  }
                  if (snap.data!.serviceDetail!.isSlotAvailable.validate()) {
                    showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      isScrollControlled: true,
                      isDismissible: true,
                      shape: RoundedRectangleBorder(
                          borderRadius: radiusOnly(
                              topLeft: defaultRadius, topRight: defaultRadius)),
                      builder: (_) {
                        return DraggableScrollableSheet(
                            initialChildSize: 0.50,
                            minChildSize: 0.2,
                            maxChildSize: 1,
                            builder: (_, scrollController) => ProviderSelect(
                                  serviceData: snap.data!.serviceDetail,
                                  data: snap.data!,
                                  providers: snap.data!.providers,
                                  scrollController: scrollController,
                                  bookNow: bookNow,
                                ));
                      },
                    );
                  } else {
                    bookNow(snap.data!);
                  }
                },
                color: context.primaryColor,
                child: Text(language.lblBookNow,
                    style: boldTextStyle(color: white)),
                width: context.width(),
                textColor: Colors.white,
              ),
            ),
          ],
        );
      }
      return ServiceDetailShimmer();
    }

    return FutureBuilder<ServiceDetailResponse>(
      initialData: listOfCachedData
          .firstWhere((element) => element?.$1 == widget.serviceId.validate(),
              orElse: () => null)
          ?.$2,
      future: future,
      builder: (context, snap) {
        return Scaffold(
          body: Stack(
            children: [
              buildBodyWidget(snap),
              Observer(
                  builder: (context) =>
                      LoaderWidget().visible(appStore.isLoading)),
            ],
          ),
        );
      },
    );
  }
}

class OptionsWidget extends StatefulWidget {
  final List<Option> options;
  final ServiceData? service;
  const OptionsWidget(
    this.options,
    this.service, {
    super.key,
  });

  @override
  State<OptionsWidget> createState() => _OptionsWidgetState();
}

class _OptionsWidgetState extends State<OptionsWidget> {
  @override
  void initState() {
    super.initState();
    bookingStore.options = ObservableList.of([]);
    bookingStore.approximateArea = 0;
    bookingStore.providerId = 0;
    bookingStore.providerName = '';
    bookingStore.pricePerSqft = widget.service!.pricePerSqft ?? 0;
    bookingStore.initQuantities(
        widget.options, widget.service!.pricePerSqft.validate());
  }

  @override
  void dispose() {
    super.dispose();
    bookingStore.options = ObservableList.of([]);
    bookingStore.providerId = 0;
    bookingStore.providerName = '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // Observer(builder: (_) => Text(bookingStore.selectedOptions.toString())),
      ...List.generate(
          widget.options.length.validate(),
          (index) => widget.options[index].typeInt == 0
              ? widget.options[index].multi == 0
                  ? SingleOption(widget.options[index], bookingStore)
                      .paddingAll(8)
                  : MultiOption(widget.options[index], bookingStore)
                      .paddingAll(8)
              : widget.options[index].typeInt == 2
                  ? PackageOption(
                      widget.options[index], widget.service!, bookingStore)
                  : widget.options[index].typeInt == 3
                      ? MultiplyOption(widget.options[index])
                      : QuantityOption(widget.options[index], bookingStore)),
    ]);
  }
}
