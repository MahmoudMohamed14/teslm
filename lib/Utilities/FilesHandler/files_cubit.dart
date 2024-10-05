import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/images_model.dart';
import 'files_states.dart';

Future pickFileProvider(BuildContext context,
        {bool multiImages = false, bool openCamera = false}) async =>
    await BlocProvider.of<DragFilesCubit>(context).pickFile(
        allowMultiple: multiImages, context: context, openCamera: openCamera);

List<GenericFile> imagesProvider(BuildContext context) =>
    BlocProvider.of<DragFilesCubit>(context).images;

class DragFilesCubit extends Cubit<FilesStates> {
  DragFilesCubit() : super(FilesInitialState());
  static DragFilesCubit get(context) => BlocProvider.of(context);
  List<GenericFile> _images = [];
  bool mustSelectOneImage = false;

  List<GenericFile> get images => _images;

  Future clearImages() async {
    if (_images.isEmpty) return;

    emit(ClearFilesLoadingState());
    _images = [];

    emit(ClearFilesSuccessState());
  }

  Future removeImageFromImagesList(int index) async {
    if (_images.isEmpty) return;
    emit(ClearSingleFileLoadingState());
    _images.removeAt(index);
    emit(ClearSingleFileSuccessState());
  }

  //*   pick an image
  Future pickFile(
      {bool allowMultiple = true,
      required BuildContext context,
      bool openCamera = false}) async {
    emit(PickFilesLoadingState());
    if (openCamera) {
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        if (!allowMultiple) {
          _images = [];
        }
        int length = await image.length();
        _images.add(GenericFile.fromPlatformFile(
            PlatformFile(path: image.path, name: image.name, size: length)));
        emit(PickFilesSuccessState());
      }
    } else {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowedExtensions: GenericFile.allowExtensions,
        type: FileType.custom,
        allowMultiple: allowMultiple,
      );

      if (result != null && result.files.isNotEmpty) {
        if (!allowMultiple) {
          _images = [];
        }
        // result.files
        // if(allowMultiple){
        for (var e in result.files) {
          if (e.bytes != null) {
            _images.add(GenericFile.fromPlatformFile(e));
          } else {
            if (e.path != null) _images.add(GenericFile.fromPlatformFile(e));
          }
        }
      }

      emit(PickFilesSuccessState());
    }
  }
}
