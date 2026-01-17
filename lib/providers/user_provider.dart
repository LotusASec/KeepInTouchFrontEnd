import 'package:flutter/foundation.dart';
import 'package:keep_in_touch/models/user.dart';
import 'package:keep_in_touch/services/user_service.dart';

class UserProvider extends ChangeNotifier {
  final UserService _userService = UserService();

  List<User> _users = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<User> get users => _users;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchUsers() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _users = await _userService.getAllUsers();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<User> createUser(String name, String password, String role) async {
    final newUser = await _userService.createUser(name, password, role);
    _users.add(newUser);
    notifyListeners();
    return newUser;
  }

  Future<User> updateUser(int userId, String name, String role, {String? password}) async {
    final updatedUser = await _userService.updateUser(userId, name, role, password: password);
    final index = _users.indexWhere((u) => u.id == userId);
    if (index != -1) {
      _users[index] = updatedUser;
    }
    notifyListeners();
    return updatedUser;
  }

  Future<void> deleteUser(int userId) async {
    await _userService.deleteUser(userId);
    _users.removeWhere((u) => u.id == userId);
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
