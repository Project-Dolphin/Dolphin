// 가장 가까운 버스는 1, 2번째 버스는 2
class ArriveInfo {
  String nodeNm;
  int carNo1; // 1 버스 번호판
  int carNo2; // 2 버스 번호판
  int lowplate1; // 1 버스의 저상버스 여부
  int lowplate2; // 2 버스의 저상버스 여부
  int min1; // 1 버스의 도착 예정 시간
  int min2; // 2 버스의 도착 예정 시간
  int station1; // 1 버스 도착까지 남은 정류장 수
  int station2; // 2 버스 도착까지 남은 정류장 수

  ArriveInfo(
      {this.nodeNm,
      this.carNo1,
      this.carNo2,
      this.lowplate1,
      this.lowplate2,
      this.min1,
      this.min2,
      this.station1,
      this.station2});

  factory ArriveInfo.fromJson(Map<String, dynamic> json) {
    return ArriveInfo(
        nodeNm: json['nodeNm'],
        carNo1: json['carNo1'],
        carNo2: json['carNo2'],
        lowplate1: json['lowplate1'],
        lowplate2: json['lowplate2'],
        min1: json['min1'],
        min2: json['min2'],
        station1: json['station1'],
        station2: json['station2']);
  }
}
