import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong/latlong.dart';

import '../model/store.dart';

class StoreRepository {
  final distance = Distance();

  Future<List<Store>> fetch(double lat, double lng) async {
    // 함수 바깥에서 선언된 stores가 함수 내로 들어오면서 매번 새로 stores가 생성됨. 따라서 stores를 매번 clear() 해줄 필요도 없음.
    final stores = <Store>[];
    var url = Uri.parse(
        "https://gist.githubusercontent.com/junsuk5/bb7485d5f70974deee920b8f0cd1e2f0/raw/063f64d9b343120c2cb01a6555cf9b38761b1d94/sample.json");
    print("lat: $lat, lng: $lng");

    var response = await http.get(url);
    final jsonResult = jsonDecode(response.body);
    final jsonStores = jsonResult["stores"];

    jsonStores.forEach((e) {
      final store = Store.fromJson(e);
      final km = distance.as(
          LengthUnit.Kilometer,
          LatLng(store.lat!.toDouble(), store.lng!.toDouble()),
          LatLng(lat, lng));
      store.km = km;

      stores.add(store);
    });

    return stores
        .where((element) =>
            element.remainStat == "plenty" ||
            element.remainStat == "some" ||
            element.remainStat == "few")
        .toList();
  }
}
