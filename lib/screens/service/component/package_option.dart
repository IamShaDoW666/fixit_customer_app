import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/service_data_model.dart';
import 'package:booking_system_flutter/store/booking_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:booking_system_flutter/utils/constant.dart';

import '../../../utils/colors.dart';

class PackageOption extends StatefulWidget {
  final Option option;
  final BookingStore bookingStore;
  final ServiceData service;

  PackageOption(
    this.option,
    this.service,
    this.bookingStore, {
    super.key,
  });

  @override
  State<PackageOption> createState() => _SingleOptionState();
}

class _SingleOptionState extends State<PackageOption> {
  bool checkSelected(int id) {
    return widget.bookingStore
        .optionExists({'option': widget.option.id.validate(), 'variant': id});
  }

  void selectVariant(Variant variant) {
    setState(() {
      widget.bookingStore.addPackageOption({
        'option': widget.option.id.validate(),
        'variant': variant.id.validate(),
        'description': variant.description,
        'package': true,
        'packageArea': variant.packageArea,
        'price': (variant.price != null && variant.price! > 0)
            ? variant.price
            : variant.packageArea! * widget.service.pricePerSqft!
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) =>
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          widget.option.name.validate(),
          style: boldTextStyle(size: LABEL_TEXT_SIZE),
        ),
        8.height,
        Wrap(children: [
          if (!widget.bookingStore.customize)
            ...List.generate(
                widget.option.variants!.length,
                (idx) => ChoiceChip(
                      label: Text(widget.option.variants![idx].name.validate()),
                      labelStyle: boldTextStyle(
                          color: checkSelected(
                                  widget.option.variants![idx].id.validate())
                              ? Colors.white
                              : primaryColor),
                      showCheckmark: false,
                      selectedColor: primaryColor,
                      side: BorderSide(color: primaryColor),
                      selected: checkSelected(
                          widget.option.variants![idx].id.validate()),
                      onSelected: (newValue) {
                        selectVariant(widget.option.variants![idx]);
                      },
                    ).paddingAll(8)),
          if (widget.service.customizable != null &&
              widget.service.customizable == true)
            ChoiceChip(
              label: Text('Customize'),
              labelStyle: boldTextStyle(
                  color: widget.bookingStore.customize
                      ? Colors.white
                      : primaryColor),
              selectedColor: primaryColor,
              showCheckmark: false,
              side: BorderSide(color: primaryColor),
              onSelected: (newValue) {
                setState(() {
                  bookingStore.toggleCustomize();
                });
              },
              selected: widget.bookingStore.customize,
            ).paddingAll(8),
        ])
      ]),
    );
  }
}
