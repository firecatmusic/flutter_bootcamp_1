class FlightResponses {
  List<AllFlight>? allFlight;
  List<AllFlight>? popularFrom;
  List<AllFlight>? popularTo;

  FlightResponses({this.allFlight, this.popularFrom, this.popularTo});

  FlightResponses.fromJson(Map<String, dynamic> json) {
    if (json['all_flight'] != null) {
      allFlight = <AllFlight>[];
      json['all_flight'].forEach((v) {
        allFlight!.add(AllFlight.fromJson(v));
      });
    }
    if (json['popular_from'] != null) {
      popularFrom = <AllFlight>[];
      json['popular_from'].forEach((v) {
        popularFrom!.add(AllFlight.fromJson(v));
      });
    }
    if (json['popular_to'] != null) {
      popularTo = <AllFlight>[];
      json['popular_to'].forEach((v) {
        popularTo!.add(AllFlight.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (allFlight != null) {
      data['all_flight'] = allFlight!.map((v) => v.toJson()).toList();
    }
    if (popularFrom != null) {
      data['popular_from'] = popularFrom!.map((v) => v.toJson()).toList();
    }
    if (popularTo != null) {
      data['popular_to'] = popularTo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllFlight {
  String? airportName;
  String? businessId;
  String? airportCode;
  String? businessNameTransId;
  String? locationName;
  String? countryId;
  String? countryName;
  String? label;

  AllFlight(
      {this.airportName,
        this.businessId,
        this.airportCode,
        this.businessNameTransId,
        this.locationName,
        this.countryId,
        this.countryName,
        this.label});

  AllFlight.fromJson(Map<String, dynamic> json) {
    airportName = json['airport_name'];
    businessId = json['business_id'];
    airportCode = json['airport_code'];
    businessNameTransId = json['business_name_trans_id'];
    locationName = json['location_name'];
    countryId = json['country_id'];
    countryName = json['country_name'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['airport_name'] = airportName;
    data['business_id'] = businessId;
    data['airport_code'] = airportCode;
    data['business_name_trans_id'] = businessNameTransId;
    data['location_name'] = locationName;
    data['country_id'] = countryId;
    data['country_name'] = countryName;
    data['label'] = label;
    return data;
  }
}