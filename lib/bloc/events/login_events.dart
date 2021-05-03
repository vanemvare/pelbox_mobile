abstract class LoginEvent {
  String username;
  String password;

  LoginEvent(this.username, this.password);
}

class LoginMember extends LoginEvent {
  LoginMember(String username, String password) : super(username, password);
}
