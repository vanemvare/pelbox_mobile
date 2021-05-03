abstract class DeliveryEvent {
  String accessToken;

  DeliveryEvent(this.accessToken);
}

class TakeDelivery extends DeliveryEvent {
  int organizationId;
  int orderId;

  TakeDelivery(String accessToken, int organizationId, int orderId) : super(accessToken) {
    this.organizationId = organizationId;
    this.orderId = orderId;
  }
}

class LeaveDelivery extends DeliveryEvent {
  int organizationId;
  int orderId;

  LeaveDelivery(String accessToken, int organizationId, int orderId) : super(accessToken) {
    this.organizationId = organizationId;
    this.orderId = orderId;
  }
}
