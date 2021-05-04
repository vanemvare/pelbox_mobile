abstract class PelBoxEvent {
  String accessToken;

  PelBoxEvent(this.accessToken);
}

class BoxAllSettings extends PelBoxEvent {
  BoxAllSettings(String accessToken) : super(accessToken);
}

class GetBoxLocking extends PelBoxEvent {
  GetBoxLocking(String accessToken) : super(accessToken);
}

class GetBoxDismantle extends PelBoxEvent {
  GetBoxDismantle(String accessToken) : super(accessToken);
}

class UpdateSecurityKey extends PelBoxEvent {
  String securityKey;

  UpdateSecurityKey(String accessToken, String securityKey)
      : super(accessToken) {
    this.securityKey = securityKey;
  }
}

class PingBox extends PelBoxEvent {
  PingBox(String accessToken) : super(accessToken);
}

class UpdateLocking extends PelBoxEvent {
  bool locked;

  UpdateLocking(String accessToken, bool locked) : super(accessToken) {
    this.locked = locked;
  }
}

class UpdateDismantle extends PelBoxEvent {
  bool dismantle;

  UpdateDismantle(String accessToken, bool dismantle) : super(accessToken) {
    this.dismantle = dismantle;
  }
}

class UpdateExpandingValue extends PelBoxEvent {
  int expandingValue;

  UpdateExpandingValue(String accessToken, int expandingValue)
      : super(accessToken) {
    this.expandingValue = expandingValue;
  }
}

class UpdateDoorStatus extends PelBoxEvent {
  String doorStatus;

  UpdateDoorStatus(String accessToken, String doorStatus) : super(accessToken) {
    this.doorStatus = doorStatus;
  }
}
