class Weather {
  String? status;
  String? temparature;
  String? windSpeed;
  String? humidity;

  Weather({this.status, this.temparature, this.windSpeed, this.humidity});

  Weather.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    temparature = json['temparature'];
    windSpeed = json['windSpeed'];
    humidity = json['humidity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['temparature'] = this.temparature;
    data['windSpeed'] = this.windSpeed;
    data['humidity'] = this.humidity;
    return data;
  }
}
