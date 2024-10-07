import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

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

  ///   ----------------   Send Files To Backend   -----------
  // void uploadImageList() async {
  //   CloudinaryUploader uploader = CloudinaryUploader();
  //   List<String> uploadedUrls = await uploader.uploadImages(images
  //       .map(
  //         (e) => File(e.path),
  //       )
  //       .toList());
  //
  //   if (uploadedUrls.isNotEmpty) {
  //     print('Uploaded images URLs: $uploadedUrls');
  //   } else {
  //     print('Failed to upload images');
  //   }
  // }

  Future<List<String>> uploadSelectedImages() async {
    List<String> imageUrls = [];

    for (GenericFile image in images) {
      String? url = await sendFiles(image);
      if (url?.isNotEmpty ?? false) {
        imageUrls.add(url!);
        removeImageFromImagesList(_images.indexOf(image));
      }
      imageUrls.forEach((e) => print("Image Path>>>>>>>  $e"));
      print("<<<   ${imageUrls.length}   >>>");
    }
    clearImages();
    return imageUrls;
  }

  Future<String?> sendFiles(GenericFile singleImage) async {
    // Replace with your actual endpoint URL
    final url =
        Uri.parse('https://hunger-station-clone.vercel.app/upload-file');

    // Create a multipart request
    var request = http.MultipartRequest('POST', url);

    // Get MIME type of the file
    final mimeType = lookupMimeType(singleImage.path);
    final mimeTypeData =
        mimeType?.split('/') ?? ['application', 'octet-stream'];

    // Attach the file to the request
    request.files.add(await http.MultipartFile.fromPath(
      'file',
      singleImage.path,
      contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
    ));

    // Send the request
    try {
      final response = await request.send();
      final responseString = await response.stream.bytesToString();
      if (response.statusCode == 201) {
        debugPrint('File uploaded successfully');
        return responseString;
      } else {
        debugPrint('Failed to upload file: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error occurred while uploading file: $e');
    }
    return null;
  }
}
