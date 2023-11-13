class SignInStates {
  const SignInStates({this.email = "", this.password = ""});

  final String email;
  final String password;

  

  SignInStates copyWith({
    String? email, String? password
    }) {
    return SignInStates(
      email: email??this.email,
      password: password??this.password,
    );
  }
}
