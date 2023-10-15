import 'package:booking_system_flutter/component/cached_image_widget.dart';
import 'package:booking_system_flutter/component/view_all_label_component.dart';
import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/category_model.dart';
import 'package:booking_system_flutter/screens/category/category_screen.dart';
import 'package:booking_system_flutter/screens/dashboard/component/category_widget.dart';
import 'package:booking_system_flutter/screens/service/view_all_service_screen.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

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
                widget.categoryList!.length >= 9
                    ? 9
                    : widget.categoryList!.length,
                (index) => GestureDetector(
                      onTap: () {
                        ViewAllServiceScreen(
                                categoryId:
                                    widget.categoryList![index].id.validate(),
                                categoryName: widget.categoryList![index].name,
                                isFromCategory: true)
                            .launch(context);
                      },
                      child: Container(
                        width: context.width() / 3 - 26,
                        decoration: boxDecorationWithRoundedCorners(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12, // Shadow color
                              offset:
                                  Offset(0, 2), // Offset (horizontal, vertical)
                              blurRadius: 4.0, // Blur radius
                              spreadRadius: 0.0, // Spread radius
                            ),
                          ],
                          borderRadius: radius(),
                          backgroundColor: context.cardColor,
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              child: CachedImageWidget(
                                url: widget.categoryList![index].categoryImage
                                    .validate(),
                                height: 100,
                                width: context.width(),
                                radius: 12,
                                circle: false,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Text(widget.categoryList![index].name.validate())
                                .paddingSymmetric(vertical: 8)
                          ],
                        ),
                      ),
                    ))).paddingSymmetric(horizontal: 16, vertical: 8),
      ],
    );
  }
}
