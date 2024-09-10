import 'package:flutter/material.dart';
import 'package:test_flutter_vvkhanh/presentation/widgets/high_light_text.widget.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/model/address.model.dart';

class ItemAddress extends StatefulWidget {
  final AddressModel addressModel;
  final String searchQuery;

  const ItemAddress(
      {super.key, required this.addressModel, required this.searchQuery});

  @override
  State<ItemAddress> createState() => _ItemAddressState();
}

class _ItemAddressState extends State<ItemAddress> {
  void _openGoogleMaps() async {
    final url =
        'https://www.google.com/maps/dir/?api=1&destination=${widget.addressModel.position.lat},${widget.addressModel.position.lng}';
    final Uri _url = Uri.parse(url);

    if (await launchUrl(_url)) {
      print("success");
    } else {
      print("loi");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _openGoogleMaps,
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            Image.asset(
              'assets/location-sign.png',
              width: 32,
            ),
            Expanded(
              child: HighlightText(
                text: widget.addressModel.title,
                highlight: widget.searchQuery,
                ignoreCase: true,
                style: TextStyle(color: Colors.grey),
              ),
            ),

            Icon(Icons.turn_right)
          ],
        ),
      ),
    );
  }


}
