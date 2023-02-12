import 'package:flutter/material.dart';

class CartListTile extends StatelessWidget {
  const CartListTile({
    Key? key,
    required this.text,
    required this.price,
  }) : super(key: key);

  final String text;
  final String price;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12, //color of shadow
            spreadRadius: 1, //spread radius
            blurRadius: 0, // blur radius
            offset: Offset(0, 0), // changes position of shadow
          )
        ],
      ),
      width: size.width,
      height: 50,
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(color: Colors.black54, fontSize: 15),
            textAlign: TextAlign.center,
          ),
          Spacer(),
          Text(
            '${price} kr',
            style: TextStyle(color: Colors.black54, fontSize: 15),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
