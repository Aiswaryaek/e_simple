import 'package:flutter/material.dart';
import '../core/live_data.dart';
import '../core/ui_state.dart';
import '../models/signup_model.dart';
import '../repositories/auth_repository.dart';

class SignUpProvider extends ChangeNotifier {
  AuthRepository authRepository;

  SignUpProvider({required this.authRepository});

  var signUpModel = SignUpModel();
  LiveData<UIState<SignUpModel>> signUpLiveData =
      LiveData<UIState<SignUpModel>>();

  LiveData<UIState<SignUpModel>> getSignUpLiveData() {
    return signUpLiveData;
  }

  void initialState() {
    signUpLiveData.setValue(Initial());
    notifyListeners();
  }

  Future<void> signUp(
      String email, String password, String firstName, String lastName) async {
    try {
      signUpLiveData.setValue(IsLoading());
      signUpModel =
          await authRepository.signUpData(email, password, firstName, lastName);
      if (signUpModel.id != null) {
        signUpLiveData.setValue(Success(signUpModel));
      } else {
        signUpLiveData.setValue(Failure(signUpModel.toString()));
      }
    } catch (ex) {
      signUpLiveData.setValue(Failure(ex.toString()));
    } finally {
      notifyListeners();
    }
  }
}
