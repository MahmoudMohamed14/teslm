import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../common/colors/theme_model.dart';
import '../models/images_model.dart';
import '../widgets/rounded_image_widget.dart';

class HelperFunctions {
  static void showDialogHelper(BuildContext context,
      {required Widget contentWidget,
      Color? backgroundColor,
      bool isFullScreen = true}) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: ThemeModel.of(context).backgroundColor,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
              content: contentWidget,
            ));
  }

  static void imagePreviewDialog(
    BuildContext context, {
    String? imagePath,
    GenericFile? file,
  }) {
    showDialogHelper(
      context,
      contentWidget: RoundedImage(
        // height: 280,
        // width: 200,
        radiusValue: 8,
        imagePath: imagePath,
        memoryImage: file,
      ),
    );
  }
}
