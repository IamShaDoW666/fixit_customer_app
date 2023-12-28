import 'package:booking_system_flutter/component/cached_image_widget.dart';
import 'package:booking_system_flutter/component/view_all_label_component.dart';
import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/category_model.dart';
import 'package:booking_system_flutter/screens/category/category_screen.dart';
import 'package:booking_system_flutter/screens/service/view_all_service_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../utils/constant.dart';

class CategoryComponent extends StatefulWidget {
  final List<CategoryData>? categoryList;

  CategoryComponent({this.categoryList});

  @override
  CategoryComponentState createState() => CategoryComponentState();
}

class CategoryComponentState extends State<CategoryComponent> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.categoryList.validate().isEmpty) return Offstage();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ViewAllLabel(
          label: language.category,
          list: widget.categoryList!,
          onTap: () {
            CategoryScreen().launch(context).then((value) {
              setStatusBarColor(Colors.transparent);
            });
          },
        ).paddingSymmetric(horizontal: 16),
        Wrap(
            spacing: 16,
            runSpacing: 16,
            children: List.generate(
                widget.categoryList!.length >= 12
                    ? 12
                    : widget.categoryList!.length,
                (index) => Container(
                      width: context.width() / 4 - 20,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              ViewAllServiceScreen(
                                      categoryId: widget.categoryList![index].id
                                          .validate(),
                                      categoryName:
                                          widget.categoryList![index].name,
                                      isFromCategory: true)
                                  .launch(context);
                            },
                            child: Container(
                              // width: context.width() / 4 - 20,
                              decoration: boxDecorationWithRoundedCorners(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12, // Shadow color
                                    offset: Offset(
                                        0, 2), // Offset (horizontal, vertical)
                                    blurRadius: 4.0, // Blur radius
                                    spreadRadius: 0.0, // Spread radius
                                  ),
                                ],
                                borderRadius: radius(),
                                backgroundColor: context.cardColor,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  widget.categoryList![index].categoryImage
                                          .validate()
                                          .endsWith('.svg')
                                      ? Container(
                                          width: CATEGORY_ICON_SIZE,
                                          height: CATEGORY_ICON_SIZE,
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color: context.cardColor,
                                              shape: BoxShape.rectangle,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: SvgPicture.network(
                                            widget.categoryList![index]
                                                .categoryImage
                                                .validate(),
                                            height: CATEGORY_ICON_SIZE,
                                            width: CATEGORY_ICON_SIZE,
                                            color: appStore.isDarkMode
                                                ? Colors.white
                                                : widget
                                                    .categoryList![index].color
                                                    .validate(value: '000')
                                                    .toColor(),
                                            placeholderBuilder: (context) =>
                                                PlaceHolderWidget(
                                              height: CATEGORY_ICON_SIZE,
                                              width: CATEGORY_ICON_SIZE,
                                              color: transparentColor,
                                            ),
                                          ).paddingAll(10),
                                        )
                                      : Container(
                                          padding: EdgeInsets.all(14),
                                          decoration: BoxDecoration(
                                              color: appStore.isDarkMode
                                                  ? Colors.white24
                                                  : context.cardColor,
                                              shape: BoxShape.rectangle,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: CachedImageWidget(
                                            url: widget.categoryList![index]
                                                .categoryImage
                                                .validate(),
                                            fit: BoxFit.cover,
                                            width: 50,
                                            height: 50,
                                            circle: true,
                                            placeHolderImage: '',
                                          ),
                                        ),
                                  4.height,
                                ],
                              ),
                            ),
                          ),
                          4.height,
                          Text(
                            '${widget.categoryList![index].name.validate()}',
                            textAlign: TextAlign.center,
                            style: primaryTextStyle(
                                size: 12,
                                color: appStore.isDarkMode ? white : black),
                          ),
                        ],
                      ),
                    ))).paddingSymmetric(horizontal: 16, vertical: 8),
      ],
    );
  }
}
