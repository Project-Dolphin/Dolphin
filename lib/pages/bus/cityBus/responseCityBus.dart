class ResponseCityBus {
  late String arsNo;
  late String bstopId;
  late String bstopIdx;
  late String bustype;
  late String carNo1;
  late String carNo2;
  late String gpsX;
  late String gpsY;
  late String lineNo;
  late String lineid;
  late String lowplate1;
  late String lowplate2;
  late String min1;
  late String min2;
  late String nodeNm;
  late String station1;
  late String station2;

  ResponseCityBus(
      {this.arsNo = '',
      this.bstopId = '',
      this.bstopIdx = '',
      this.bustype = '',
      this.carNo1 = '',
      this.carNo2 = '',
      this.gpsX = '',
      this.gpsY = '',
      this.lineNo = '',
      this.lineid = '',
      this.lowplate1 = '',
      this.lowplate2 = '',
      this.min1 = '',
      this.min2 = '',
      this.nodeNm = '',
      this.station1 = '',
      this.station2 = ''});

  ResponseCityBus.fromJson(Map<String, dynamic> json) {
    arsNo = json['arsNo'];
    bstopId = json['bstopId'];
    bstopIdx = json['bstopIdx'];
    bustype = json['bustype'];
    carNo1 = json['carNo1'];
    carNo2 = json['carNo2'];
    gpsX = json['gpsX'];
    gpsY = json['gpsY'];
    lineNo = json['lineNo'];
    lineid = json['lineid'];
    lowplate1 = json['lowplate1'];
    lowplate2 = json['lowplate2'];
    min1 = json['min1'];
    min2 = json['min2'];
    nodeNm = json['nodeNm'];
    station1 = json['station1'];
    station2 = json['station2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['arsNo'] = this.arsNo;
    data['bstopId'] = this.bstopId;
    data['bstopIdx'] = this.bstopIdx;
    data['bustype'] = this.bustype;
    data['carNo1'] = this.carNo1;
    data['carNo2'] = this.carNo2;
    data['gpsX'] = this.gpsX;
    data['gpsY'] = this.gpsY;
    data['lineNo'] = this.lineNo;
    data['lineid'] = this.lineid;
    data['lowplate1'] = this.lowplate1;
    data['lowplate2'] = this.lowplate2;
    data['min1'] = this.min1;
    data['min2'] = this.min2;
    data['nodeNm'] = this.nodeNm;
    data['station1'] = this.station1;
    data['station2'] = this.station2;
    return data;
  }
}
