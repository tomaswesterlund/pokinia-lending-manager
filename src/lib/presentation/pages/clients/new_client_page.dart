import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pokinia_lending_manager/core/enums/states.dart';
import 'package:pokinia_lending_manager/core/util/string_extensions.dart';
import 'package:pokinia_lending_manager/domain/services/avatar_service.dart';
import 'package:pokinia_lending_manager/domain/services/image_picker_service.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/buttons/my_cta_button.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/input/my_text_form_field.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/texts/headers/header_four_text.dart';
import 'package:pokinia_lending_manager/view_models/pages/client/new_client_page_view_model.dart';
import 'package:provider/provider.dart';

class NewClientPage extends StatelessWidget {
  NewClientPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  File? _selectedAvatar;

  void _addClient(BuildContext context, NewClientPageViewModel vm) async {
    if (_formKey.currentState!.validate()) {
      var avatarImagePath = "";
      if (_selectedAvatar != null) {
        avatarImagePath = await AvatarService().uploadAvatar(_selectedAvatar!);
      }

      var name = _nameController.text;
      var phoneNumber = _phoneNumberController.text;
      var address = _addressController.text;

      await vm.createClient(name, phoneNumber, address, avatarImagePath).fold(
          (error) => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error adding client: ${error.message}'),
                  backgroundColor: Colors.red,
                ),
              ),
          (success) => Navigator.pop(context));
    }
  }

  Future _pickImage(ImageSource source) async {
    final returnedImage = await ImagePickerService().pickImage(source);

    if (returnedImage != null) {
      _selectedAvatar = File(returnedImage.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NewClientPageViewModel>(builder: (context, vm, _) {
      return Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _getHeaderWidget(context, vm),
            _getAvatarWidget(vm),
            _getNameWidget(vm),
            _getPhoneNumberWidget(vm),
            _getAddressWidget(vm),
            _getAddClientButtonWidget(context, vm)
          ],
        ),
      );
    });
  }

  Widget _getHeaderWidget(BuildContext context, NewClientPageViewModel vm) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const HeaderFourText(text: "Add client"),
          IconButton(
              disabledColor: Colors.grey,
              onPressed: vm.state == States.loading
                  ? null
                  : () => Navigator.pop(context),
              icon: const Icon(Icons.close))
        ],
      ),
    );
  }

  Widget _getAvatarWidget(NewClientPageViewModel vm) {
    return Column(
      children: [
        _selectedAvatar != null
            ? AdvancedAvatar(
                size: 96,
                image: FileImage(_selectedAvatar!),
                foregroundDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF008080),
                    width: 2.0,
                  ),
                ),
              )
            : Center(
                child: Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5EAEB),
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: const Color(0xFF008080), width: 2),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.face,
                      color: Color(0xFF008080),
                      size: 72, // You can adjust the size of the icon as needed
                    ),
                  ),
                ),
              ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () => vm.state == States.loading
                  ? null
                  : _pickImage(ImageSource.gallery),
              icon: const Icon(
                Icons.photo,
                size: 48.0,
                color: Color(0xFF008080),
              ),
            ),
            const SizedBox(width: 20),
            IconButton(
              onPressed: () => vm.state == States.loading
                  ? null
                  : _pickImage(ImageSource.camera),
              icon: const Icon(
                Icons.camera_alt,
                size: 48.0,
                color: Color(0xFF008080),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _getNameWidget(NewClientPageViewModel vm) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: MyTextFormField(
          labelText: 'Name',
          enabled: vm.state == States.ready,
          validator: (value) {
            if (value.isNullOrEmpty()) {
              return "Name can't be empty";
            }

            return null;
          },
          controller: _nameController),
    );
  }

  Widget _getPhoneNumberWidget(NewClientPageViewModel vm) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: MyTextFormField(
        labelText: 'Phone number',
        enabled: vm.state == States.ready,
        validator: (value) {
          // if (value.isNullOrEmpty()) {
          //   return "Phone number can't be empty";
          // }

          return null;
        },
        controller: _phoneNumberController,
      ),
    );
  }

  Widget _getAddressWidget(NewClientPageViewModel vm) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: MyTextFormField(
        labelText: 'Address',
        enabled: vm.state == States.ready,
        validator: (value) {
          return null;
        },
        controller: _addressController,
      ),
    );
  }

  Widget _getAddClientButtonWidget(
      BuildContext context, NewClientPageViewModel vm) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
      child: MyCtaButton(
        text: "Add client",
        isProcessing: vm.state == States.loading,
        onPressed: () => _addClient(context, vm),
      ),
    );
  }
}
