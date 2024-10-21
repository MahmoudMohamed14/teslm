import 'package:delivery/common/translate/app_local.dart';
import 'package:flutter/material.dart';

import '../../../../../Utilities/FilesHandler/files_cubit.dart';
import '../../../../../common/colors/theme_model.dart';
import '../../../../../common/translate/strings.dart';

class SelectImagesWidget extends StatefulWidget {
  const SelectImagesWidget({super.key});

  @override
  State<SelectImagesWidget> createState() => _SelectImagesWidgetState();
}

class _SelectImagesWidgetState extends State<SelectImagesWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (context) => SizedBox(
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                            pickFileProvider(
                              context,
                              multiImages: true,
                            );
                            // pickImageFromGallery(
                            //     context);
                          },
                          child: Container(
                            width: 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ThemeModel.mainColor,
                            ),
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.file_copy_outlined,
                                  color: Colors.white,
                                ),
                                Text(
                                  Strings.file.tr(context),
                                  style: const TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                            pickFileProvider(context,
                                multiImages: false, openCamera: true);
                            // pickImageFromCamera(
                            //     context);
                          },
                          child: Container(
                            width: 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ThemeModel.mainColor,
                            ),
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: [
                                const Icon(Icons.camera_alt_rounded,
                                    color: Colors.white),
                                Text(
                                  Strings.camera.tr(context),
                                  style: const TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ));
      },
      child: const CircleAvatar(
        radius: 20,
        backgroundColor: ThemeModel.mainColor,
        child: Icon(Icons.camera_alt_rounded, color: Colors.white, size: 26),
      ),
    );
  }
}
