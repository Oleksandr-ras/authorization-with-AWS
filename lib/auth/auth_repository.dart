class AuthRepository{
  Future<void> tryToLogin() async {
    print('attempting login');
    await Future.delayed(const Duration(seconds: 3));
    print('login');
    throw Exception('login failed');
  }
}