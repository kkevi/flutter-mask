import 'package:flutter/material.dart';
import 'package:flutter_mask/model/store.dart';

class RemainStatListTile extends StatelessWidget {
  final Store store;

  const RemainStatListTile(this.store, {super.key});

  @override
  Widget build(BuildContext context) {
    return _buildRemainStatWidget(store);
  }

  Widget _buildRemainStatWidget(Store store) {
    String remainStat = "판매중지";
    String desc = "판매중지";
    Color color = Colors.black;

    switch (store.remainStat) {
      case "plenty":
        remainStat = "충분";
        desc = "100개 이상";
        color = Colors.green;
        break;
      case "some":
        remainStat = "보통";
        desc = "30 ~ 100개";
        color = Colors.orange;
        break;
      case "few":
        remainStat = "부족";
        desc = "2 ~ 30개";
        color = Colors.red;
        break;
      case "empty":
        remainStat = "소진임박";
        desc = "1개 이하";
        color = Colors.grey;
        break;
      default:
    }

    return Column(
      children: [
        Text(
          remainStat,
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
        Text(
          desc,
          style: TextStyle(color: color),
        )
      ],
    );
  }
}
