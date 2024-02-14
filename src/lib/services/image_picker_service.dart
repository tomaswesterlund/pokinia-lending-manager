import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  Future<XFile?> pickImage(ImageSource source) async {
    final returnedImage =
        await ImagePicker().pickImage(source: source);

    return returnedImage;
  }

  Future pickImageFromGallery() async {
    return pickImage(ImageSource.gallery);
  }

  Future pickImageFromCamera() async {
    return pickImage(ImageSource.camera);
  }
}
