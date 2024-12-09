import 'package:riverpod/riverpod.dart';
import '../models/login_model.dart';
import '../services/api_service.dart';
import '../services/database_helper.dart';

// This will create an instance of LoginViewModel
final loginViewModelProvider = StateNotifierProvider<LoginViewModel, AsyncValue<SignInResponse>>((ref) {
  return LoginViewModel(ApiService(), DatabaseHelper.instance);
});

class LoginViewModel extends StateNotifier<AsyncValue<SignInResponse>> {
  final ApiService _apiService;
  final DatabaseHelper _dbHelper;

  // Initialize with an empty response or a default value
  LoginViewModel(this._apiService, this._dbHelper)
      : super(AsyncData(SignInResponse(message: '', success: false, data: null)));

  // Login method to hit the API and store the response in the local database
  Future<void> login(String mobileNo, String roleId, String fcmKey) async {
    state = const AsyncLoading();  // Set state to loading before the API call
    try {
      final loginRequest = SignInRequest(mobileNo: mobileNo, roleId: roleId, fcmKey: fcmKey);

      // Make the API call
      final loginResponse = await _apiService.login(loginRequest);

      // Save the response to the local database
      await _dbHelper.saveUserData(loginResponse);

      // Update the state with the login response after saving it
      state = AsyncData(loginResponse);
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);  // Set error state in case of failure
    }
  }

  // Get the saved user data from the local database
  Future<void> getUserData() async {
    try {
      final user = await _dbHelper.getUserData();

      // If user data exists, update the state with it
      if (user != null) {
        state = AsyncData(user);
      } else {
        // Handle case where no user data is found
        state =   AsyncData(SignInResponse(message: 'No user data found', success: false, data: null));
      }
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);  // Set error state in case of failure
    }
  }

  // Method to delete user data from local database
  Future<void> deleteUserData() async {
    try {
      await _dbHelper.deleteUser();  // Delete from DB
      state =   AsyncData(SignInResponse(message: 'User data deleted', success: false, data: null));
    } catch (e, stackTrace) {
  state = AsyncError(e, stackTrace);  // Set error state in case of failure
}
  }
}
