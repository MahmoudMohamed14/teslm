import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../common/colors/theme_model.dart';
import '../common/images/images.dart';
import '../models/images_model.dart';

class RoundedImage extends StatelessWidget {
  final Color? backgroundColor, borderColor;
  final double? radius, padding, radiusValue;
  final String? imagePath;
  final BoxFit? fit;
  final GenericFile? memoryImage;
  const RoundedImage(
      {super.key,
      this.backgroundColor,
      this.borderColor,
      this.radius,
      this.imagePath,
      this.fit,
      this.padding,
      this.memoryImage,
      this.radiusValue});

  @override
  Widget build(BuildContext context) {
    return memoryImage != null
        ? SizedBox(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radiusValue ?? 200.h),
              child: Image.memory(
                memoryImage!.bytes,
                height: radius?.r,
                width: radius?.r,
                fit: BoxFit.cover,
              ),
            ),
          )
        : imagePath == null
            ? Container(
                padding: EdgeInsets.all(padding ?? 8.r),
                height: radius?.r,
                width: radius?.r,
                decoration: BoxDecoration(
                  shape: radiusValue == null
                      ? BoxShape.circle
                      : BoxShape.rectangle,
                  borderRadius: radiusValue == null
                      ? null
                      : BorderRadius.circular(radiusValue!),
                  color: backgroundColor,
                ),
              )
            : SizedBox(
                height: radius?.r,
                width: radius?.r,
                child: ClipRRect(
                    // padding: EdgeInsets.all(padding ?? 8.r),

                    // shape: radiusValue == null
                    //     ? BoxShape.circle
                    //     : BoxShape.rectangle,

                    borderRadius: BorderRadius.circular(radiusValue ?? 200),
                    // color: backgroundColor,
                    // border: borderColor == null
                    //     ? null
                    //     : Border.all(
                    //         color: borderColor!,
                    //       ),

                    child: imagePath?.contains("http") ?? false
                        ? Image.network(
                            imagePath!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, _, c) => Opacity(
                              opacity: 0.2,
                              child: CircleAvatar(
                                radius: ((radiusValue ?? 16) / 2).r,
                                backgroundColor: ThemeModel.of(context).primary,
                                child: Image.asset(
                                  ImagesApp.teslmPngLogo,
                                  width: 24,
                                ),
                              ),
                            ),
                          )
                        : Opacity(
                            opacity: 0.2,
                            child: Image.asset(
                              imagePath!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, _, c) => CircleAvatar(
                                radius: ((radiusValue ?? 16) / 2).r,
                                backgroundColor: ThemeModel.of(context).primary,
                                child: Image.asset(
                                  ImagesApp.teslmPngLogo,
                                  width: 24,
                                ),
                              ),
                            ),
                          )),
              );
  }
}
