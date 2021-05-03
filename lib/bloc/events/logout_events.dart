abstract class LogoutEvent {
  String accessToken;
  String refreshToken;

  LogoutEvent(this.accessToken, this.refreshToken);
}

class LogoutMember extends LogoutEvent {
  LogoutMember(String accessToken, String refreshToken) : super(accessToken, refreshToken);
}
