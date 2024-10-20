import 'package:delivery/common/extensions.dart';
import 'package:delivery/common/images/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/colors/theme_model.dart';
import '../../../common/text_style_helper.dart';
import '../../../widgets/app_text_widget.dart';

class ErrorDialogPayment extends StatelessWidget {
  const ErrorDialogPayment({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,

        children: [
          const Center(child: Image(image: AssetImage(ImagesApp.errorPayment),fit: BoxFit.cover,)),
          20.h.heightBox,
          AppTextWidget(
            message??'',
            style: TextStyleHelper.of(context)
                .medium18
                .copyWith(color: ThemeModel.of(context).font1,),
          ),
        ],
      ),
    );
  }
}
