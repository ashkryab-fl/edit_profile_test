import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_profile/common_widgets/app_custom_input_widget.dart';
import 'package:test_profile/common_widgets/app_text_button.dart';
import 'package:test_profile/common_widgets/dialogs/cupertino_model_popup.dart';
import 'package:test_profile/pages/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:test_profile/pages/edit_profile/bloc/edit_profile_event.dart';
import 'package:test_profile/pages/edit_profile/bloc/edit_profile_state.dart';
import 'package:test_profile/pages/edit_profile/widgets/awatar_widget.dart';
import 'package:country_picker/country_picker.dart';

import '../../common_widgets/app_text_input_widget.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final firstNameTec = TextEditingController();
  final lastNameTec = TextEditingController();
  final nickNameTec = TextEditingController();

  @override
  void initState() {
    firstNameTec.addListener(() {
      BlocProvider.of<EditProfileBloc>(context)
          .add(RemoveFirstNameErrorEvent());
      getAvatarLetters();
    });

    lastNameTec.addListener(() {
      BlocProvider.of<EditProfileBloc>(context).add(RemoveLastNameErrorEvent());
      getAvatarLetters();
    });
    nickNameTec.addListener(() {
      BlocProvider.of<EditProfileBloc>(context).add(RemoveNickNameErrorEvent());
    });
    WidgetsBinding.instance.addPostFrameCallback((d) {
      //init bloc state;
    });
    super.initState();
  }

  @override
  void dispose() {
    firstNameTec.dispose();
    lastNameTec.dispose();
    nickNameTec.dispose();
    super.dispose();
  }

  void getAvatarLetters() {
    var bloc = BlocProvider.of<EditProfileBloc>(context);
    if (bloc.state.newAvatarPath.isEmpty) {
      var text = '';
      if (firstNameTec.text.trim().isNotEmpty) {
        text = text + firstNameTec.text[1];
      }
      if (lastNameTec.text.trim().isNotEmpty) {
        text = text + lastNameTec.text[1];
      }
      bloc.add(LettersOnAvatarChanged(text: text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(
          CupertinoIcons.arrow_left,
          color: Colors.black87,
        ),
        actions: [
          AppTextButton(
              text: 'Done',
              onPress: () {
                BlocProvider.of<EditProfileBloc>(context).add(
                    SaveEditProfileEvent(
                        firstName: firstNameTec.text,
                        lastName: lastNameTec.text,
                        nickName: nickNameTec.text));
              })
        ],
        backgroundColor: Colors.white,
        title: const Text('Personal account'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: BlocBuilder<EditProfileBloc, EditProfileState>(
              builder: (context, EditProfileState state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ..._buildAvatarArea(state, context),
                    ..._buildTextField(state, context),
                    AppCustomInputWidget(
                        hint: 'Country of residence',
                        onTap: () {
                          showCountryPicker(
                            context: context,
                            showPhoneCode: true,
                            // optional. Shows phone code before the country name.
                            onSelect: (Country country) {
                              BlocProvider.of<EditProfileBloc>(context).add(
                                  GotCountryEditProfileEvent(
                                      country: country.name));
                            },
                          );
                        },
                        error: state.countryInputError,
                        isEmpty: state.country?.isEmpty ?? true,
                        child: Text(state.country ?? '')),
                    const SizedBox(height: 10),
                    AppCustomInputWidget(
                        hint: 'Date of birth',
                        onTap: () {
                          BlocProvider.of<EditProfileBloc>(context).add(
                              GotDateEditProfileEvent(date: DateTime.now()));
                          showAppDialog(
                              CupertinoDatePicker(
                                  initialDateTime: DateTime.now(),
                                  mode: CupertinoDatePickerMode.date,
                                  maximumDate: DateTime.now(),
                                  use24hFormat: true,
                                  onDateTimeChanged: (DateTime newTime) {
                                    BlocProvider.of<EditProfileBloc>(context)
                                        .add(GotDateEditProfileEvent(
                                            date: newTime));
                                  }),
                              context);
                        },
                        error: state.dateOfBirthInputError,
                        isEmpty: state.dateOfBirth == null,
                        child: Text(state.dateOfBirth
                                ?.toIso8601String()
                                .split('T')
                                .first ??
                            '')),
                    const SizedBox(height: 20),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTextField(EditProfileState state, BuildContext context) {
    return [
      AppTextInputWidget(
        hint: 'First name',
        controller: firstNameTec,
        error: state.firstNameInputError,
        onTap: () => BlocProvider.of<EditProfileBloc>(context)
            .add(RemoveFirstNameErrorEvent()),
      ),
      const SizedBox(height: 10),
      AppTextInputWidget(
        hint: 'Last name',
        controller: lastNameTec,
        error: state.lastNameInputError,
        onTap: () => BlocProvider.of<EditProfileBloc>(context)
            .add(RemoveLastNameErrorEvent()),
      ),
      const SizedBox(height: 10),
      AppTextInputWidget(
        hint: 'Username, how other will see you in search',
        controller: nickNameTec,
        error: state.nickNameInputError,
        onTap: () => BlocProvider.of<EditProfileBloc>(context)
            .add(RemoveNickNameErrorEvent()),
      ),
      const SizedBox(height: 10),
    ];
  }

  List<Widget> _buildAvatarArea(EditProfileState state, BuildContext context) {
    return [
      AvatarWidget(
        localPath: state.newAvatarPath,
        text: state.lettersOnAvatar ?? '',
      ),
      const SizedBox(height: 8),
      AppTextButton(
          text: 'Change photo',
          onPress: () {
            buildEditAvatarlPopup(context);
          }),
      const SizedBox(height: 10),
    ];
  }

  Future<dynamic> buildEditAvatarlPopup(BuildContext context) {
    return showCupertinoModalPopup(
      context: context,
      builder: (dialogContext) => CupertinoActionSheet(
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: const Text('Take a photo'),
            onPressed: () async {
              final ImagePicker picker = ImagePicker();
              final XFile? photo =
                  await picker.pickImage(source: ImageSource.camera);
              if (photo != null) {
                BlocProvider.of<EditProfileBloc>(context)
                    .add(GotAvatarEditProfileEvent(avatarPath: photo.path));
                Navigator.pop(dialogContext);
              }
            },
          ),
          CupertinoActionSheetAction(
              child: const Text('Open gallery'),
              onPressed: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? image =
                    await picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  BlocProvider.of<EditProfileBloc>(context)
                      .add(GotAvatarEditProfileEvent(avatarPath: image.path));
                  Navigator.pop(dialogContext);
                }
              }),
          CupertinoActionSheetAction(
            child: const Text('Remove photo'),
            onPressed: () {
              BlocProvider.of<EditProfileBloc>(context)
                  .add(RemoveAvatarEditProfileEvent());
              Navigator.pop(dialogContext);
            },
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(dialogContext);
            },
          ),
        ],
      ),
    );
  }
}
