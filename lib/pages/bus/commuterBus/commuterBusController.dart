import 'package:get/get.dart';

class CommuterBusController extends GetxController {
  bool isLoading = true;
  List<String> busList = [
    '통근 버스 1호 출근',
    '통근 버스 2호 출근',
    '통근 버스 3호 출근',
    '통근 버스 1호 퇴근',
    '통근 버스 2호 퇴근',
    '통근 버스 3호 퇴근',
  ];
  String selectedBus = DateTime.now().hour > 20 || DateTime.now().hour < 10
      ? '통근 버스 1호 출근'
      : '통근 버스 1호 퇴근';
  List<List<String>> stationList_1 = [
    [
      '풍년혼수마트',
      '롯데캐슬 상가 앞',
      '장전동 놀이터',
      '온천장 홈플러스',
      '롯데백화점 정류장',
      '삼성프라자(온천점)',
      '교대역',
      '연산동, 연제초교',
      '양정역',
      '부전역',
      '서면역',
      '범일역 5번출구',
      '부산진역 7번출구',
      '부산역 3번출구',
      '영도대교 대궁한정식',
      '학교도착',
    ],
    [
      '학교출발',
      '영도구청',
      '중앙역',
      '부산역',
      '서면',
      '시청',
      '동래',
      '부산대',
    ]
  ];

  List<List<String>> stationList_2 = [
    [
      '서면역',
      '범일역 5번출구',
      '부산진역 7번출구',
      '부산역 3번출구',
      '영도대교 대궁한정식',
      '학교도착',
    ],
    [
      '학교출발',
      '중리 관사앞',
      '영도소방서',
      '롯데백화점 (광복점)',
      '부산역',
      '부산진역',
      '문현동',
      '대연동',
    ]
  ];

  List<List<String>> stationList_3 = [
    [
      '연산9동 안락뜨란채',
      '망미동 주공아파트',
      '수영국민은행',
      '수영역 10번출구',
      '한서병원',
      'KBS방송국',
      '남천역 버스정류장',
      '봄봄카페',
      '더맛한우',
      '대연자이아파트 후문',
      '한라아파트',
      '동삼동 농협',
      '부산항대교',
      '학교도착',
    ],
    [
      '학교출발',
      '부산항대교',
      '경성대',
      '남천역',
      '수영로타리',
      '망미동 주공아파트',
    ]
  ];

  @override
  void onInit() {
    super.onInit();
  }

  void setSelectedBus(station) {
    selectedBus = station;
    update();
  }

  void setIsLoading(loading) {
    isLoading = loading;
    update();
  }
}
