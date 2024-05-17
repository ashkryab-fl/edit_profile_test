import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_profile/pages/edit_profile/bloc/edit_profile_event.dart';
import 'package:test_profile/pages/edit_profile/bloc/edit_profile_state.dart';
import 'package:test_profile/services/user_data_service.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  UserServices userServices;

  EditProfileBloc(this.userServices) : super(EditProfileState()) {
    userServices.loadUserInfo().then((user){
      if(userServices.userInfo.isNotEmpty){
        add(InitEditProfileEvent());
      }
    });

    on<InitEditProfileEvent>(
        (event, emit) {
          //todo fill state from userServices.userInfo
        });

    on<GotAvatarEditProfileEvent>(
        (event, emit) => emit(state.copyWith(newAvatarPath: event.avatarPath)));

    on<RemoveAvatarEditProfileEvent>(
        (event, emit) => emit(state.copyWith(newAvatarPath: '')));

    on<RemoveFirstNameErrorEvent>(
        (event, emit) => emit(state.copyWith(firstNameInputError: '')));

    on<RemoveLastNameErrorEvent>(
        (event, emit) => emit(state.copyWith(lastNameInputError: '')));

    on<RemoveNickNameErrorEvent>(
        (event, emit) => emit(state.copyWith(nickNameInputError: '')));

    on<LettersOnAvatarChanged>(
        (event, emit) => emit(state.copyWith(lettersOnAvatar: event.text)));

    on<GotCountryEditProfileEvent>((event, emit) => emit(
        state.copyWith(country: event.country, countryInputError: '')));

    on<GotDateEditProfileEvent>((event, emit) => emit(
        state.copyWith(dateOfBirth: event.date, dateOfBirthInputError: '')));

    on<SaveEditProfileEvent>((event, emit) {
      var newState = state.copyWith(
          firstNameInputError: validateFirstName(event.firstName.trim()),
          lastNameInputError: validateLastName(event.lastName.trim()),
          nickNameInputError: validateNickName(event.nickName.trim()),
          countryInputError: validateCountry(state.country ?? ''),
          dateOfBirthInputError: validateDate(state.dateOfBirth));

      if ([
        state.nickNameInputError,
        state.lastNameInputError,
        state.firstNameInputError,
        state.dateOfBirthInputError,
        state.countryInputError
      ].where((e) => e != null).isEmpty) {
     // todo  userServices.saveUserInfo({...});
      }
      emit(newState);
    });
  }

  String? validateFirstName(String firstName) {
    if (firstName.isEmpty) {
      return "First name cannot be empty";
    } else if (firstName.length <= 3) {
      return "First name must be at least 4 characters long";
    } else {
      return null; // Valid first name
    }
  }

  String? validateLastName(String lastName) {
    if (lastName.isEmpty) {
      return "Last name cannot be empty";
    } else if (lastName.length <= 3) {
      return "Last name must be at least 4 characters long";
    } else {
      return null; // Valid last name
    }
  }

  String? validateNickName(String username) {
    if (username.length != 6) {
      return "Username must be 6 characters long";
    } else if (!username.startsWith(RegExp(r'[A-Z]'))) {
      return "Username must start with a capital letter";
    } else if (!RegExp(r'[a-z]').hasMatch(username)) {
      return "Username must contain at least one lowercase letter";
    } else if (!RegExp(r'[0-9]').hasMatch(username)) {
      return "Username must contain at least one digit";
    } else {
      return null; // Valid username
    }
  }

  String? validateCountry(String country) {
    if (country.isEmpty) {
      return "Please select country";
    } else {
      return null;
    }
  }

  String? validateDate(DateTime? date) {
    if (date == null) {
      return "Please select date";
    } else {
      return null;
    }
  }
}
