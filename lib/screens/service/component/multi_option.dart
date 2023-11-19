import 'package:booking_system_flutter/model/service_data_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:booking_system_flutter/utils/constant.dart';

import '../../../store/booking_store.dart';
import '../../../utils/colors.dart';

class MultiOption extends StatefulWidget {
  final Option option;
  final BookingStore bookingStore;
  MultiOption(
    this.option,
    this.bookingStore, {
    super.key,
  });

  @override
  State<MultiOption> createState() => _MultiOptionState();
}

class _MultiOptionState extends State<MultiOption> {
  bool selected = false;

  bool checkSelected(int id) => widget.bookingStore
      .optionExists({'option': widget.option.id.validate(), 'variant': id});

  void selectVariant(int optionId, int variantId) {
    setState(() {
      widget.bookingStore.addMultiOption({
        'option': optionId,
        'variant': variantId,
        'type': 'normal',
        'price': widget.option.variants!
            .firstWhere((element) => element.id == variantId)
            .price
      });
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
      Column(
          children: List.generate(
              widget.option.variants!.length,
              (idx) => !widget.option.variants![idx].showDescription!
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          width: context.width() * 0.6,
                          child: ChoiceChip(
                            label: Marquee(
                              animationDuration: Duration(seconds: 1),
                              pauseDuration: Duration(seconds: 2),
                              backDuration: Duration(seconds: 1),
                              child: Text(
                                widget.option.variants![idx].name.validate(),
                              ),
                            ),
                            labelStyle: boldTextStyle(
                                color: checkSelected(widget
                                        .option.variants![idx].id
                                        .validate())
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
                          ),
                        ).paddingSymmetric(vertical: 8),
                        Text(
                            widget.option.variants![idx].priceFormat.validate())
                      ],
                    )
                  : ChoiceChip(
                      label: Container(
                        width: context.width(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Marquee(
                                  animationDuration: Duration(seconds: 1),
                                  pauseDuration: Duration(seconds: 2),
                                  backDuration: Duration(seconds: 1),
                                  child: Text(
                                    widget.option.variants![idx].name
                                        .validate(),
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                16.height,
                                Container(
                                  width: context.width() * 0.6,
                                  child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                    widget.option.variants![idx].description
                                        .validate(),
                                  ),
                                )
                              ],
                            ),
                            Text(widget.option.variants![idx].priceFormat
                                .validate())
                          ],
                        ),
                      ),
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
                    ).paddingSymmetric(vertical: 8)))
    ]);
  }
}
