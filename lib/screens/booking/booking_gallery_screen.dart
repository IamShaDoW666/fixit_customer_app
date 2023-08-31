import 'package:booking_system_flutter/component/back_widget.dart';
import 'package:booking_system_flutter/component/cached_image_widget.dart';
import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/screens/zoom_image_screen.dart';
import 'package:booking_system_flutter/utils/colors.dart';
import 'package:booking_system_flutter/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';

class BookingGalleryScreen extends StatefulWidget {
  final List<String>? imageList;

  BookingGalleryScreen({this.imageList});

  @override
  _BookingGalleryScreenState createState() => _BookingGalleryScreenState();
}

class _BookingGalleryScreenState extends State<BookingGalleryScreen> {
  Future<void> init() async {}

  @override
  Widget build(BuildContext context) {
    if (widget.imageList!.isEmpty) return Text("No image");
    return Scaffold(
      appBar: appBarWidget(
        "Gallery",
        textColor: Colors.white,
        textSize: APP_BAR_TEXT_SIZE,
        color: primaryColor,
        systemUiOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness:
                appStore.isDarkMode ? Brightness.light : Brightness.light,
            statusBarColor: context.primaryColor),
        showBack: Navigator.canPop(context),
        backWidget: BackWidget(),
      ),
      body: AnimatedScrollView(
        onSwipeRefresh: () async {
          await init();
          setState(() {});
          await 2.seconds.delay;
        },
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(16),
        listAnimationType: ListAnimationType.FadeIn,
        fadeInConfiguration: FadeInConfiguration(duration: 2.seconds),
        children: [
          AnimatedWrap(
            runSpacing: 16,
            spacing: 8,
            itemCount: widget.imageList!.length,
            listAnimationType: ListAnimationType.FadeIn,
            fadeInConfiguration: FadeInConfiguration(duration: 2.seconds),
            scaleConfiguration: ScaleConfiguration(
                duration: 300.milliseconds, delay: 50.milliseconds),
            itemBuilder: (_, i) {
              return GestureDetector(
                onTap: () {
                  if (widget.imageList![i].isNotEmpty)
                    ZoomImageScreen(
                            galleryImages: [widget.imageList![i]], index: 0)
                        .launch(context);
                },
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(blurRadius: 16, color: Colors.black12)
                  ]),
                  child: CachedImageWidget(
                    url: widget.imageList![i].validate(),
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                    placeHolderImage: '',
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
