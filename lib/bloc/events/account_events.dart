abstract class AccountEvent {
  String accessToken;

  AccountEvent(this.accessToken);
}

class AllSettings extends AccountEvent {
  AllSettings(String accessToken) : super(accessToken);
}

class AllCountries extends AccountEvent {
  AllCountries(String accessToken) : super(accessToken);
}


class UpdateFirstName extends AccountEvent {
  String firstName;

  UpdateFirstName(String accessToken, String firstName) : super(accessToken) {
    this.firstName = firstName;
  }
}

class UpdateLastName extends AccountEvent {
  String lastName;

  UpdateLastName(String accessToken, String lastName) : super(accessToken) {
    this.lastName = lastName;
  }
}

class UpdateCity extends AccountEvent {
  String city;

  UpdateCity(String accessToken, String city) : super(accessToken) {
    this.city = city;
  }
}

class UpdateCityAddress extends AccountEvent {
  String cityAddress;

  UpdateCityAddress(String accessToken, String cityAddress) : super(accessToken) {
    this.cityAddress = cityAddress;
  }
}

class UpdatePostalCode extends AccountEvent {
  String postalCode;

  UpdatePostalCode(String accessToken, String postalCode) : super(accessToken) {
    this.postalCode = postalCode;
  }
}

class UpdateCountry extends AccountEvent {
  String countryName;

  UpdateCountry(String accessToken, String countryName) : super(accessToken) {
    this.countryName = countryName;
  }
}

class CountryCode extends AccountEvent {
  String countryName;

  CountryCode(String accessToken, String countryName) : super(accessToken) {
    this.countryName = countryName;
  }
}

class UpdateGender extends AccountEvent {
  String gender;

  UpdateGender(String accessToken, String gender) : super(accessToken) {
    this.gender = gender;
  }
}

class GetMemberOrdersDetails extends AccountEvent {
  GetMemberOrdersDetails(String accessToken) : super(accessToken);
}

class GetAllMemberOrders extends AccountEvent {
  GetAllMemberOrders(String accessToken) : super(accessToken);
}

class GetUnreadNotifications extends AccountEvent {
  GetUnreadNotifications(String accessToken) : super(accessToken);
}

class ReadNotification extends AccountEvent {
  String id;

  ReadNotification(String accessToken, String id) : super(accessToken) {
    this.id = id;
  }
}

class GetOrganizationOrders extends AccountEvent {
  GetOrganizationOrders(String accessToken) : super(accessToken);
}

class GetOrganizationDeliveries extends AccountEvent {
  GetOrganizationDeliveries(String accessToken) : super(accessToken);
}

