class LoginState {
  final String email;
  final String password;
  final bool isLoading;

  LoginState({this.email = '' , this.password = '', this.isLoading = false});
@override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;
  LoginState copyWith({String? email, String? password, bool? isLoading}){
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading
    );
  }

}