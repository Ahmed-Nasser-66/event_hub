import 'dart:io';
import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/features/widgets/custom_back_button.dart';
import 'package:event_hub/features/widgets/custom_button_auth.dart';
import 'package:event_hub/features/widgets/text_form_field.dart';
import 'package:event_hub/l10n/app_localizations.dart';
import 'package:event_hub/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController username = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController confirmpass = TextEditingController();

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  void dispose() {
    pass.dispose();
    confirmpass.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    final user = context.read<UserProvider>();

    username.text = user.name;
    email.text = user.email;
  }

  File? _image;
  final ImagePicker picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        backgroundColor: AppColors.grey,
        leading: CustomBackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            Form(
              key: formState,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    l10n.editProfileTitle,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Stack(
                        children: [
                          GestureDetector(
                            onTap: pickImageFromGallery,
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage: _image != null
                                  ? FileImage(_image!)
                                  : (context.read<UserProvider>().image != null
                                        ? FileImage(
                                            context.read<UserProvider>().image!,
                                          )
                                        : null),
                              child:
                                  (_image == null &&
                                      context.read<UserProvider>().image ==
                                          null)
                                  ? const Icon(Icons.person, size: 35)
                                  : null,
                            ),
                          ),

                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: pickImageFromCamera,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                  color: AppColors.orange,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.camera_alt,
                                  size: 18,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 15),
                      GestureDetector(
                        onTap: pickImageFromGallery,
                        child: Text(
                          l10n.changePicture,
                          style: const TextStyle(
                            color: AppColors.orange,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    l10n.fullName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 5),
                  CustomTextForm(
                    hinttext: l10n.fullName,
                    mycontroller: username,
                    validator: (val) {
                      if (val != null && val.isNotEmpty && val.length < 3) {
                        return "Name too short";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 10),
                  Text(
                    l10n.email,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 5),
                  CustomTextForm(
                    hinttext: l10n.emailExample,
                    mycontroller: email,
                    validator: (val) {
                      if (val != null && val.isNotEmpty) {
                        if (!RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        ).hasMatch(val)) {
                          return l10n.enterValidEmail;
                        }
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 10),
                  Text(
                    l10n.phoneNumber,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 5),
                  CustomTextForm(
                    hinttext: l10n.enterPhoneNumber,
                    mycontroller: phone,
                    validator: (val) {
                      if (val != null && val.isNotEmpty) {
                        if (!RegExp(r'^[0-9]{11}$').hasMatch(val)) {
                          return l10n.phoneMustBe11Digits;
                        }
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 10),
                  Text(
                    l10n.password,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 5),
                  CustomTextForm(
                    hinttext: l10n.enterPassword,
                    mycontroller: pass,
                    isPassword: true,
                    validator: (val) {
                      if (val != null && val.isNotEmpty) {
                        if (val.length < 8) {
                          return l10n.passwordMinLength;
                        }
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 10),
                  Text(
                    l10n.retypePassword,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 5),
                  CustomTextForm(
                    hinttext: l10n.retypePasswordHint,
                    mycontroller: confirmpass,
                    isPassword: true,
                    validator: (val) {
                      if (val != null && val.isNotEmpty && val != pass.text) {
                        return l10n.passwordsDoNotMatch;
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 40),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButtonAuth(
                          title: l10n.cancel,
                          color: AppColors.grey,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: CustomButtonAuth(
                          title: l10n.save,
                          color: AppColors.orange,
                          onPressed: () {
                            if (formState.currentState!.validate()) {
                              final user = context.read<UserProvider>();

                              context.read<UserProvider>().setUser(
                                username.text.isEmpty
                                    ? user.name
                                    : username.text,
                                email.text.isEmpty ? user.email : email.text,
                                pass.text.isEmpty ? user.password : pass.text,
                                newImage: _image ?? user.image,
                              );

                              Navigator.pop(context);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void pickImageFromGallery() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  void pickImageFromCamera() async {
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }
}
