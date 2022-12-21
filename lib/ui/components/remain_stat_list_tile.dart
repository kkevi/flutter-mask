import 'package:flutter/material.dart';
import 'package:flutter_mask/model/store.dart';
import 'package:url_launcher/url_launcher.dart';

class RemainStatListTile extends StatelessWidget {
  final Store store;

  const RemainStatListTile(this.store, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(store.name ?? ""),
      subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(store.addr ?? ""),
        Text('${store.km}km'),
      ]),
      trailing: _buildRemainStatWidget(store),
      onTap: () {
        _launchUrl(store.lat!.toDouble(), store.lng!.toDouble());
        print("tap!");
      },
    );
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

  Future<void> _launchUrl(double lat, double lng) async {
    final Uri _url =
        Uri.parse('https://google.com/maps/search/?api=1&query=$lat,$lng ');
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }
}
