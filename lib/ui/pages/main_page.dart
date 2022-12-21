import 'package:flutter/material.dart';
import 'package:flutter_mask/ui/components/remain_stat_list_tile.dart';
import 'package:provider/provider.dart';

import 'package:flutter_mask/view-model/store_model.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  // @override
  // void initState() {
  //   super.initState();
  //   // then은 앞 함수에 대한 callback 함수
  //   storeRepository.fetch().then((value) {
  //     // value는 StoreRepository 클래스에서 return하는 결과값
  //     setState(() {
  //       stores = value;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final storeModel = Provider.of<StoreModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("마스크 재고 있는 곳  : ${storeModel.stores.length}곳"),
        actions: [
          IconButton(
              onPressed: () {
                storeModel.fetch();
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: storeModel.isLoading
          ? loadingWidget()
          : ListView(
              children: storeModel.stores.map((e) {
                return RemainStatListTile(e);
              }).toList(),
            ),
    );
  }

  Widget loadingWidget() {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("정보를 가져오는 중입니다."),
            CircularProgressIndicator()
          ]),
    );
  }
}
