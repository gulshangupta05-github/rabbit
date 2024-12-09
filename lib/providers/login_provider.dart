
import 'package:demo/models/login_model.dart';
import 'package:riverpod/riverpod.dart';
import '../services/api_service.dart';

final loginProvider = FutureProvider.family<SignInResponse, SignInRequest>((ref, loginRequest) async {
  final apiService = ApiService();
  return await apiService.login(loginRequest);
});
