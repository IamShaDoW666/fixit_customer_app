import 'package:booking_system_flutter/model/service_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:booking_system_flutter/utils/constant.dart';

import '../../../store/booking_store.dart';
import '../../../utils/colors.dart';

class MultiOption extends StatefulWidget {
  final Option option;

  MultiOption(
    this.option, {
    super.key,
  });

  @override
  State<MultiOption> createState() => _MultiOptionState();
}

class _MultiOptionState extends State<MultiOption> {
  bool selected = false;
  final bookingStore = BookingStore();

  bool checkSelected(int id) => bookingStore
      .optionExists({'option': widget.option.id.validate(), 'variant': id});

  void selectVariant(int optionId, int variantId) {
    setState(() {
      bookingStore.addMultiOption({'option': optionId, 'variant': variantId});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        widget.option.name.validate(),
        style: boldTextStyle(size: LABEL_TEXT_SIZE),
      ),
      8.height,
      Wrap(
          children: List.generate(
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
                      selectVariant(widget.option.id.validate(),
                          widget.option.variants![idx].id.validate());
                    },
                  ).paddingAll(8)))
    ]);
  }
}
