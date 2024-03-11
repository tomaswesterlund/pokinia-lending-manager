import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pokinia_lending_manager/providers/client_provider.dart';
import 'package:pokinia_lending_manager/providers/user_settings_provider.dart';
import 'package:pokinia_lending_manager/services/avatar_service.dart';
import 'package:pokinia_lending_manager/services/image_picker_service.dart';
import 'package:pokinia_lending_manager/ui/components/buttons/my_cta_button.dart';
import 'package:pokinia_lending_manager/ui/components/input/my_text_form_field.dart';
import 'package:pokinia_lending_manager/ui/components/overlays.dart';
import 'package:pokinia_lending_manager/ui/components/texts/headers/header_four_text.dart';
import 'package:pokinia_lending_manager/util/string_extensions.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NewClientPage extends StatefulWidget {
  const NewClientPage({super.key});

  @override
  State<NewClientPage> createState() => _NewClientPageState();
}

class _NewClientPageState extends State<NewClientPage> {
  final supabase = Supabase.instance.client;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  File? _selectedAvatar;
  OverlayEntry? _loadingOverlay;
  bool _isProcessing = false;

  void _addClient() async {
    if (_formKey.currentState!.validate()) {
      setOnProcessing(true);

      var clientProvider = Provider.of<ClientProvider>(context, listen: false);
      var userSettingsProvider =
          Provider.of<UserSettingsProvider>(context, listen: false);
      var user = supabase.auth.currentUser!;
      var userSettings = userSettingsProvider.getByUserId(user.id);

      var avatarImagePath = "";
      if (_selectedAvatar != null) {
        avatarImagePath = await AvatarService().uploadAvatar(_selectedAvatar!);
      }

      var name = _nameController.text;
      var phoneNumber = _phoneNumberController.text;
      var address = _addressController.text;

      var response = await clientProvider.createClient(
          organizationId: userSettings.selectedOrganzationId,
          name: name,
          phoneNumber: phoneNumber,
          address: address,
          avatarImagePath: avatarImagePath);

      setOnProcessing(false);

      if (mounted) {
        if (response.statusCode == 200) {
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error adding client: ${response.message}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  void setOnProcessing(bool newValue) {
    setState(() {
      _isProcessing = newValue;

      if (_isProcessing) {
        _loadingOverlay = createLoadingOverlay(context);
        Overlay.of(context).insert(_loadingOverlay!);
      } else {
        _loadingOverlay?.remove();
      }
    });
  }

  Future _pickImage(ImageSource source) async {
    final returnedImage = await ImagePickerService().pickImage(source);

    if (returnedImage == null) return;

    setState(() {
      _selectedAvatar = File(returnedImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    var clientService = Provider.of<ClientProvider>(context, listen: false);

    return Consumer<UserSettingsProvider>(
        builder: (context, userSettingsService, _) {
      var user = supabase.auth.currentUser!;
      var userSettings = userSettingsService.getByUserId(user.id);

      return Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _getHeaderWidget(),
            _getAvatarWidget(),
            _getNameWidget(),
            _getPhoneNumberWidget(),
            _getAddressWidget(),
            _getAddClientButtonWidget(clientService)
          ],
        ),
      );
    });
  }

  Widget _getHeaderWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const HeaderFourText(text: "Add client"),
          IconButton(
              disabledColor: Colors.grey,
              onPressed: _isProcessing ? null : () => Navigator.pop(context),
              icon: const Icon(Icons.close))
        ],
      ),
    );
  }

  Widget _getAvatarWidget() {
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
              onPressed: () =>
                  _isProcessing ? null : _pickImage(ImageSource.gallery),
              icon: const Icon(
                Icons.photo,
                size: 48.0,
                color: Color(0xFF008080),
              ),
            ),
            const SizedBox(width: 20),
            IconButton(
              onPressed: () =>
                  _isProcessing ? null : _pickImage(ImageSource.camera),
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

  Widget _getNameWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: MyTextFormField(
          labelText: 'Name',
          enabled: !_isProcessing,
          validator: (value) {
            if (value.isNullOrEmpty()) {
              return "Name can't be empty";
            }

            return null;
          },
          controller: _nameController),
    );
  }

  Widget _getPhoneNumberWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: MyTextFormField(
        labelText: 'Phone number',
        enabled: !_isProcessing,
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

  Widget _getAddressWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: MyTextFormField(
        labelText: 'Address',
        enabled: !_isProcessing,
        validator: (value) {
          return null;
        },
        controller: _addressController,
      ),
    );
  }

  Widget _getAddClientButtonWidget(ClientProvider clientService) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
      child: MyCtaButton(
        text: "Add client",
        isProcessing: _isProcessing,
        onPressed: _isProcessing ? null : _addClient,
      ),
    );
  }
}
