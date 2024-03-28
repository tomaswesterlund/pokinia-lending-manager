import 'dart:io';

import 'package:circular_image/circular_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pokinia_lending_manager/domain/services/image_picker_service.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/texts/headers/header_five_text.dart';

class MyImagePicker extends StatefulWidget {
  final String title;
  final bool isProcessing;

  final Function(File) onImageSelected;

  const MyImagePicker({
    super.key,
    required this.title,
    required this.isProcessing,
    required this.onImageSelected,
  });

  @override
  State<MyImagePicker> createState() => _MyImagePickerState();
}

class _MyImagePickerState extends State<MyImagePicker> {
  File? _selectedImage;

  Future _pickImage(ImageSource source) async {
    final returnedImage = await ImagePickerService().pickImage(source);

    if (returnedImage == null) return;

    setState(() {
      _selectedImage = File(returnedImage.path);
    });

    widget.onImageSelected(File(returnedImage.path));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.title.isNotEmpty ?
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: HeaderFiveText(text: widget.title),
        ) : const SizedBox.shrink(),
        if (_selectedImage != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: CircularImage(
                source: _selectedImage!.path,
                radius: 50,
                borderWidth: 2,
                borderColor: widget.isProcessing
                    ? const Color(0xFF979797)
                    : const Color(0xFF008080)),
          )
        else
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5EAEB),
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: widget.isProcessing
                          ? const Color(0xFF979797)
                          : const Color(0xFF008080),
                      width: 2),
                ),
                child: Center(
                  child: Icon(
                    Icons.receipt,
                    color: widget.isProcessing
                        ? const Color(0xFF979797)
                        : const Color(0xFF008080),
                    size: 72, // You can adjust the size of the icon as needed
                  ),
                ),
              ),
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: widget.isProcessing
                  ? null
                  : () => _pickImage(ImageSource.gallery),
              icon: const Icon(Icons.photo, size: 48.0),
              color: const Color(0xFF008080),
            ),
            const SizedBox(width: 20),
            IconButton(
              onPressed: widget.isProcessing
                  ? null
                  : () => _pickImage(ImageSource.camera),
              icon: const Icon(Icons.camera_alt, size: 48.0),
              color: const Color(0xFF008080),
            ),
          ],
        ),
      ],
    );
  }
}
