import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class CloudinaryUploader {
  final String cloudName =
      'dmzdzq3ug'; // Replace with your Cloudinary cloud name
  final String apiKey = '926956693483974'; // Replace with your API key
  final String apiSecret =
      'p9YFAgKI8bwm4zI_VfrzYF3NVlI'; // Replace with your API secret

  Future<List<String>> uploadImages(List<File> images) async {
    List<String> imageUrls = [];

    for (File image in images) {
      String url = await uploadImage(image);
      if (url.isNotEmpty) {
        imageUrls.add(url);
      }
    }

    return imageUrls;
  }

  Future<String> uploadImage(File image) async {
    final mimeTypeData =
        lookupMimeType(image.path, headerBytes: [0xFF, 0xD8])?.split('/');
    if (mimeTypeData == null || mimeTypeData[0] != 'image') {
      print('File is not an image');
      return '';
    }
    final uploadUrl =
        Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');

    var request = http.MultipartRequest('POST', uploadUrl);

    // Add required parameters
    request.fields['api_key'] = apiKey;
    request.fields['timestamp'] =
        DateTime.now().millisecondsSinceEpoch.toString();

    // Generate the signature (using SHA-1 hash)
    final signature = generateSignature(request.fields);
    request.fields['signature'] = signature;

    // Attach the image file
    var multipartFile = await http.MultipartFile.fromPath(
      'file',
      image.path,
      contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
    );
    request.files.add(multipartFile);

    try {
      final response = await request.send();
      final responseData = await http.Response.fromStream(response);

      if (response.statusCode == 200) {
        final responseJson = jsonDecode(responseData.body);
        return responseJson['secure_url'] ?? '';
      } else {
        print('Error uploading image: ${response.reasonPhrase}');
        return '';
      }
    } catch (e) {
      print('Error uploading image: $e');
      return '';
    }
  }

  String generateSignature(Map<String, String> params) {
    // Sort params by key and concatenate them into a query string
    var sortedParams = params.keys.toList()..sort();
    var paramString =
        sortedParams.map((key) => '$key=${params[key]}').join('&');

    // Append the API secret to the query string
    paramString = paramString + apiSecret;

    // Create a SHA-1 hash of the string
    var bytes = utf8.encode(paramString);
    var digest = sha1.convert(bytes);

    return digest.toString();
  }
}
