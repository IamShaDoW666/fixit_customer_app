import 'package:booking_system_flutter/app_theme.dart';
import 'package:booking_system_flutter/component/custom_stepper.dart';
import 'package:booking_system_flutter/component/loader_widget.dart';
import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/service_detail_response.dart';
import 'package:booking_system_flutter/screens/booking/component/booking_service_image.dart';
import 'package:booking_system_flutter/screens/map/map_screen.dart';
import 'package:booking_system_flutter/screens/service/component/address_select.dart';
import 'package:booking_system_flutter/screens/service/component/provider_select.dart';
import 'package:booking_system_flutter/screens/service/service_detail_screen.dart';
import 'package:booking_system_flutter/services/location_service.dart';
import 'package:booking_system_flutter/utils/colors.dart';
import 'package:booking_system_flutter/utils/common.dart';
import 'package:booking_system_flutter/utils/constant.dart';
import 'package:booking_system_flutter/utils/images.dart';
import 'package:booking_system_flutter/utils/permissions.dart';
import 'package:booking_system_flutter/utils/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

class BookingServiceStep2 extends StatefulWidget {
  final ServiceDetailResponse data;
  final bool? isSlotAvailable;

  BookingServiceStep2({required this.data, this.isSlotAvailable});

  @override
  _BookingServiceStep2State createState() => _BookingServiceStep2State();
}

class _BookingServiceStep2State extends State<BookingServiceStep2> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController dateTimeCont = TextEditingController();
  TextEditingController addressCont = TextEditingController();
  TextEditingController descriptionCont = TextEditingController();

  DateTime currentDateTime = DateTime.now();
  DateTime? selectedDate;
  DateTime? finalDate;
  TimeOfDay? pickedTime;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    if (widget.data.serviceDetail!.dateTimeVal != null) {
      if (widget.isSlotAvailable.validate()) {
        dateTimeCont.text = formatDate(
            widget.data.serviceDetail!.dateTimeVal.validate(),
            format: DATE_FORMAT_1);
        selectedDate =
            DateTime.parse(widget.data.serviceDetail!.dateTimeVal.validate());
        pickedTime = TimeOfDay.fromDateTime(selectedDate!);
      }
      addressCont.text = widget.data.serviceDetail!.address.validate();
    }

    if (widget.data.providers!.isNotEmpty) {
      bookingStore.providerId = widget.data.providers![0].id.validate();
      bookingStore.providerName =
          widget.data.providers![0].displayName.validate();
      bookingStore.getTaxes(widget.data.providers![0].id.validate());
    }
  }

  void selectDateAndTime(BuildContext context) async {
    await showDatePicker(
      context: context,
      initialDate: selectedDate ?? currentDateTime,
      firstDate: currentDateTime,
      lastDate: currentDateTime.add(30.days),
      locale: Locale(appStore.selectedLanguageCode),
      cancelText: language.lblCancel,
      confirmText: language.lblOk,
      helpText: language.lblSelectDate,
      builder: (_, child) {
        return Theme(
          data: appStore.isDarkMode ? ThemeData.dark() : AppTheme.lightTheme(),
          child: child!,
        );
      },
    ).then((date) async {
      if (date != null) {
        await showTimePicker(
          context: context,
          initialTime: pickedTime ?? TimeOfDay.now(),
          cancelText: language.lblCancel,
          confirmText: language.lblOk,
          builder: (_, child) {
            return Theme(
              data: appStore.isDarkMode
                  ? ThemeData.dark()
                  : AppTheme.lightTheme(),
              child: child!,
            );
          },
        ).then((time) {
          if (time != null) {
            finalDate = DateTime(
                date.year, date.month, date.day, time.hour, time.minute);

            DateTime now = DateTime.now().subtract(1.minutes);
            DateTime after4Hours = DateTime.now().add(4.hours);
            if (date.isToday &&
                finalDate!.millisecondsSinceEpoch <
                    after4Hours.millisecondsSinceEpoch) {
              return toast("Please select Time after 4hours");
            }
            if (date.isToday &&
                finalDate!.millisecondsSinceEpoch <
                    now.millisecondsSinceEpoch) {
              return toast(language.selectedOtherBookingTime);
            }
            if (time.hour >= 21 || time.hour < 8) {
              return toast("Booking unavailable between 8 AM to 9 PM");
            }

            selectedDate = date;
            pickedTime = time;
            widget.data.serviceDetail!.dateTimeVal = finalDate.toString();
            dateTimeCont.text =
                "${formatDate(selectedDate.toString(), format: DATE_FORMAT_3)} ${pickedTime!.format(context).toString()}";
          }
        }).catchError((e) {
          toast(e.toString());
        });
      }
    });
  }

  void _handleSetLocationClick() {
    Permissions.cameraFilesAndLocationPermissionsGranted().then((value) async {
      await setValue(PERMISSION_STATUS, value);

      if (value) {
        String? res = await MapScreen(
                latitude: getDoubleAsync(LATITUDE),
                latLong: getDoubleAsync(LONGITUDE))
            .launch(context);

        if (res != null) {
          addressCont.text = res;
          setState(() {});
        }
      }
    });
  }

  void _handleCurrentLocationClick() {
    Permissions.cameraFilesAndLocationPermissionsGranted().then((value) async {
      await setValue(PERMISSION_STATUS, value);

      if (value) {
        appStore.setLoading(true);

        await getUserLocation().then((value) {
          addressCont.text = value;
          widget.data.serviceDetail!.address = value.toString();
          setState(() {});
        }).catchError((e) {
          log(e);
          toast(e.toString());
        });

        appStore.setLoading(false);
      }
    }).catchError((e) {
      //
    });
  }

  bool checkAddressFilled() {
    if (bookingStore.home.isNotEmpty &&
        bookingStore.apartment.isNotEmpty &&
        bookingStore.building.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 24, right: 16, left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                8.height,
                Text(language.lblStepper1Title,
                    style: boldTextStyle(size: LABEL_TEXT_SIZE)),
                20.height,
                Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Container(
                    decoration: boxDecorationDefault(color: context.cardColor),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 26),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.isSlotAvailable.validate(value: true))
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(language.lblDateAndTime,
                                  style: boldTextStyle(size: LABEL_TEXT_SIZE)),
                              8.height,
                              AppTextField(
                                textFieldType: TextFieldType.OTHER,
                                controller: dateTimeCont,
                                isValidationRequired: true,
                                validator: (value) {
                                  if (value!.isEmpty)
                                    return language.requiredText;
                                  return null;
                                },
                                readOnly: true,
                                onTap: () {
                                  selectDateAndTime(context);
                                },
                                decoration: inputDecoration(context,
                                        prefixIcon: ic_calendar
                                            .iconImage(size: 10)
                                            .paddingAll(14))
                                    .copyWith(
                                  fillColor: context.scaffoldBackgroundColor,
                                  filled: true,
                                  hintText: language.chooseDateAndTime,
                                  hintStyle: secondaryTextStyle(),
                                ),
                              ),
                              20.height,
                            ],
                          ),
                        Text(language.lblYourAddress,
                            style: boldTextStyle(size: LABEL_TEXT_SIZE)),
                        8.height,
                        AppTextField(
                          textFieldType: TextFieldType.MULTILINE,
                          controller: addressCont,
                          maxLines: 2,
                          onFieldSubmitted: (s) {
                            widget.data.serviceDetail!.address = s;
                          },
                          decoration: inputDecoration(
                            context,
                            prefixIcon: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ic_location
                                    .iconImage(size: 22)
                                    .paddingOnly(top: 8),
                              ],
                            ),
                          ).copyWith(
                            fillColor: context.scaffoldBackgroundColor,
                            filled: true,
                            hintText: language.lblEnterYourAddress,
                            hintStyle: secondaryTextStyle(),
                          ),
                        ),
                        8.height,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              child: Text(language.lblChooseFromMap,
                                  style: boldTextStyle(
                                      color: primaryColor, size: 13)),
                              onPressed: () {
                                _handleSetLocationClick();
                              },
                            ).flexible(),
                            TextButton(
                              onPressed: _handleCurrentLocationClick,
                              child: Text(language.lblUseCurrentLocation,
                                  style: boldTextStyle(
                                      color: primaryColor, size: 13),
                                  textAlign: TextAlign.right),
                            ).flexible(),
                            // TextButton(
                            //   onPressed: () {
                            //     showModalBottomSheet(
                            //       backgroundColor: Colors.transparent,
                            //       context: context,
                            //       isScrollControlled: true,
                            //       shape: RoundedRectangleBorder(
                            //           borderRadius: radiusOnly(
                            //               topLeft: defaultRadius,
                            //               topRight: defaultRadius)),
                            //       builder: (_) {
                            //         return DraggableScrollableSheet(
                            //             initialChildSize: 0.8,
                            //             minChildSize: 0.2,
                            //             maxChildSize: 0.8,
                            //             builder: (_, scrollController) =>
                            //                 AddressForm(
                            //                     scrollController:
                            //                         scrollController));
                            //       },
                            //     );
                            //   },
                            //   child: Text(
                            //     "Address Detail",
                            //     style: boldTextStyle(
                            //         color: primaryColor, size: 13),
                            //     textAlign: TextAlign.right,
                            //   ),
                            // ).flexible(),
                          ],
                        ),
                        Row(
                          children: [
                            AppButton(
                              width: (context.width() - 40) * 1,
                              shapeBorder: RoundedRectangleBorder(
                                  borderRadius: radius(),
                                  side:
                                      BorderSide(color: context.primaryColor)),
                              onTap: () {
                                showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  isScrollControlled: true,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: radiusOnly(
                                          topLeft: defaultRadius,
                                          topRight: defaultRadius)),
                                  builder: (_) {
                                    return DraggableScrollableSheet(
                                        initialChildSize: 0.8,
                                        minChildSize: 0.2,
                                        maxChildSize: 0.8,
                                        builder: (_, scrollController) =>
                                            AddressForm(
                                              scrollController:
                                                  scrollController,
                                            ));
                                  },
                                );
                              },
                              text: language.addressdetail,
                              textColor: textPrimaryColorGlobal,

                              // child: Text(
                              //   "Address Detail",
                              //   style: boldTextStyle(
                              //       color: primaryColor, size: 13),
                              //   textAlign: TextAlign.right,
                              // ),
                            ).flexible(),
                          ],
                        ),

                        16.height,
                        BookingServiceImage(data: widget.data),
                        Row(
                          children: [
                            Text(language.selectedProvider,
                                style: boldTextStyle(size: LABEL_TEXT_SIZE)),
                            SizedBox(width: 8.0),
                            Observer(
                                builder: (_) => Text(
                                      bookingStore.providerName.validate(),
                                      style: boldTextStyle(color: primaryColor),
                                    )).expand(),
                          ],
                        ),
                        // Text("${language.hintDescription}:",
                        //     style: boldTextStyle(size: LABEL_TEXT_SIZE)),
                        12.height,
                        AppTextField(
                          textFieldType: TextFieldType.MULTILINE,
                          controller: descriptionCont,
                          maxLines: 10,
                          minLines: 4,
                          isValidationRequired: false,
                          onFieldSubmitted: (s) {
                            widget.data.serviceDetail!.bookingDescription = s;
                          },
                          decoration: inputDecoration(context).copyWith(
                            fillColor: context.scaffoldBackgroundColor,
                            filled: true,
                            hintText: language.lblEnterDescription,
                            hintStyle: secondaryTextStyle(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                20.height,
              ],
            ),
          ),
          Positioned(
            bottom: isIOS ? 32 : 8,
            left: 16,
            right: 16,
            child: Column(
              children: [
                // Observer(
                //     builder: (_) => Text(bookingStore.providerName.validate())),
                Row(
                  children: [
                    if (widget.data.providers!.length > 0 &&
                        widget.isSlotAvailable.validate())
                      Observer(
                          builder: (_) => AppButton(
                                width: (context.width() - 40) * 0.5,
                                shapeBorder: RoundedRectangleBorder(
                                    borderRadius: radius(),
                                    side: BorderSide(
                                        color: context.primaryColor)),
                                onTap: () {
                                  showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    isScrollControlled: true,
                                    isDismissible: true,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: radiusOnly(
                                            topLeft: defaultRadius,
                                            topRight: defaultRadius)),
                                    builder: (_) {
                                      return DraggableScrollableSheet(
                                          initialChildSize: 0.50,
                                          minChildSize: 0.2,
                                          maxChildSize: 1,
                                          builder: (_, scrollController) =>
                                              ProviderSelect(
                                                serviceData:
                                                    widget.data.serviceDetail,
                                                providers:
                                                    widget.data.providers,
                                                scrollController:
                                                    scrollController,
                                              ));
                                    },
                                  );
                                },
                                text: language.changeProvider,
                                textColor: textPrimaryColorGlobal,
                              )),
                    if (!widget.isSlotAvailable.validate())
                      AppButton(
                        width: (context.width() - 40) * 0.5,
                        shapeBorder: RoundedRectangleBorder(
                            borderRadius: radius(),
                            side: BorderSide(color: context.primaryColor)),
                        onTap: () {
                          customStepperController.previousPage(
                              duration: 200.milliseconds,
                              curve: Curves.easeInOut);
                        },
                        text: language.lblPrevious,
                        textColor: textPrimaryColorGlobal,
                      ),
                    8.width,
                    16.height,
                    Row(
                      children: [
                        // if (!widget.isSlotAvailable.validate())
                        //   AppButton(
                        //     width: (context.width() - 40) * 0.5,
                        //     shapeBorder: RoundedRectangleBorder(
                        //         borderRadius: radius(),
                        //         side: BorderSide(color: context.primaryColor)),
                        //     onTap: () {
                        //       customStepperController.previousPage(
                        //           duration: 200.milliseconds,
                        //           curve: Curves.easeInOut);
                        //     },
                        //     text: language.lblPrevious,
                        //     textColor: textPrimaryColorGlobal,
                        //   ),
                        // if (!widget.isSlotAvailable.validate()) 16.width,
                        AppButton(
                          onTap: () {
                            if (bookingStore.providerId != 0) {
                              if (checkAddressFilled()) {
                                hideKeyboard(context);
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  widget.data.serviceDetail!
                                          .bookingDescription =
                                      descriptionCont.text;
                                  widget.data.serviceDetail!.address =
                                      addressCont.text;
                                  customStepperController.nextPage(
                                      duration: 200.milliseconds,
                                      curve: Curves.easeOut);
                                }
                              } else {
                                hideKeyboard(context);
                                snackBar(
                                  context,
                                  title: language.addressdetail,
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: radius(30)),
                                  duration: Duration(seconds: 3),
                                  margin: EdgeInsets.symmetric(
                                      vertical: 128, horizontal: 8),
                                );
                              }
                            } else {
                              if (widget.data.providers!.length == 1) {
                                bookingStore.providerId =
                                    widget.data.providers![0].id.validate();

                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  widget.data.serviceDetail!
                                          .bookingDescription =
                                      descriptionCont.text;
                                  widget.data.serviceDetail!.address =
                                      addressCont.text;
                                  customStepperController.nextPage(
                                      duration: 200.milliseconds,
                                      curve: Curves.easeOut);
                                }
                              } else {
                                hideKeyboard(context);
                                snackBar(
                                  context,
                                  title: language.selectProvider,
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: radius(30)),
                                  duration: Duration(seconds: 3),
                                  margin: EdgeInsets.symmetric(
                                      vertical: 128, horizontal: 8),
                                );
                              }
                            }
                          },
                          text: language.btnNext,
                          textColor: Colors.white,
                          width: (context.width() - 40) * 0.5,
                          color: context.primaryColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Observer(
              builder: (context) => LoaderWidget().visible(appStore.isLoading))
        ],
      ),
    );
  }
}
