class EditProfileState{
  String? firstNameInputError;
  String? lastNameInputError;
  String? nickNameInputError;
  String? countryInputError;
  String? dateOfBirthInputError;
  String? lettersOnAvatar;

  String newAvatarPath;

  String? country;
  DateTime? dateOfBirth;

  EditProfileState({
    this.firstNameInputError,
    this.lastNameInputError,
    this.nickNameInputError,
    this.countryInputError,
    this.dateOfBirthInputError,
    this.newAvatarPath = '',
    this.country,
    this.dateOfBirth,
    this.lettersOnAvatar,
  });

  EditProfileState copyWith({
    String? firstNameInputError,
    String? lastNameInputError,
    String? nickNameInputError,
    String? countryInputError,
    String? dateOfBirthInputError,
    String? newAvatarPath,
    String? country,
    DateTime? dateOfBirth,
    String? lettersOnAvatar,
  }) {
    return EditProfileState(
      firstNameInputError: firstNameInputError ?? this.firstNameInputError,
      lastNameInputError: lastNameInputError ?? this.lastNameInputError,
      nickNameInputError: nickNameInputError ?? this.nickNameInputError,
      countryInputError: countryInputError ?? this.countryInputError,
      dateOfBirthInputError:
          dateOfBirthInputError ?? this.dateOfBirthInputError,
      newAvatarPath: newAvatarPath ?? this.newAvatarPath,
      country: country ?? this.country,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      lettersOnAvatar: lettersOnAvatar ?? this.lettersOnAvatar,
    );
  }


}