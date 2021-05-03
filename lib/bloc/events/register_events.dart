abstract class RegisterEvent {
  String username;
  String email;
  String password;
  String phoneToken;

  RegisterEvent(this.username, this.email, this.password, this.phoneToken);
}

class RegisterMember extends RegisterEvent {
  RegisterMember(String username, String email, String password, String phoneToken) : super(username, email, password, phoneToken);
}
