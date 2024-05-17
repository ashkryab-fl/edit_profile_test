abstract class EditProfileEvent {}

class GotAvatarEditProfileEvent extends EditProfileEvent {
  final String avatarPath;

  GotAvatarEditProfileEvent({required this.avatarPath});
}

class InitEditProfileEvent extends EditProfileEvent {}
class RemoveAvatarEditProfileEvent extends EditProfileEvent {}

class RemoveFirstNameErrorEvent extends EditProfileEvent {}

class RemoveLastNameErrorEvent extends EditProfileEvent {}

class RemoveNickNameErrorEvent extends EditProfileEvent {}
class LettersOnAvatarChanged extends EditProfileEvent {
  final String text;

  LettersOnAvatarChanged({required this.text});
}

class SaveEditProfileEvent extends EditProfileEvent {
  final String firstName;
  final String lastName;
  final String nickName;

  SaveEditProfileEvent(
      {required this.firstName,
      required this.lastName,
      required this.nickName});
}

class GotCountryEditProfileEvent extends EditProfileEvent {
  final String country;

  GotCountryEditProfileEvent({required this.country});
}

class GotDateEditProfileEvent extends EditProfileEvent {
  final DateTime date;

  GotDateEditProfileEvent({required this.date});
}
