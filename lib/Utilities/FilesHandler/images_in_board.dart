import 'package:delivery/common/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/colors/theme_model.dart';
import '../../widgets/rounded_image_widget.dart';
import '../helper_functions.dart';
import 'files_cubit.dart';
import 'files_states.dart';

class ImagesInBoardWidget extends StatelessWidget {
  const ImagesInBoardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DragFilesCubit, FilesStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        final filesCubit = BlocProvider.of<DragFilesCubit>(context);
        if (filesCubit.images.isNotEmpty) {
          return SizedBox(
            height: 96,
            child: filesCubit.startUploading
                ? Container(
                    alignment: Alignment.topCenter,
                    margin: const EdgeInsets.all(20),
                    child: LinearProgressIndicator(
                      value: filesCubit.imageUrls.length /
                          filesCubit.images.length,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          Colors.deepOrange),
                    ))
                : ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: filesCubit.images.length,
                    separatorBuilder: (context, index) => 8.0.widthBox,
                    itemBuilder: (context, index) => Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            HelperFunctions.imagePreviewDialog(
                              context,
                              file: filesCubit.images[index],
                            );
                          },
                          child: RoundedImage(
                            radius: 72,
                            radiusValue: 8,
                            memoryImage: filesCubit.images[index],
                          ).paddingOnly(top: 8),
                        ),
                        PositionedDirectional(
                          top: 0,
                          end: 0,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(50),
                            onTap: () =>
                                filesCubit.removeImageFromImagesList(index),
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: ThemeModel.of(context).danger,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.remove,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
