import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sv_craft/Features/cart/controllar/cart_controller.dart';

class IncDecButton extends StatefulWidget {
  int count;
  int price;
  IncDecButton({Key? key, required this.count, required this.price})
      : super(key: key);

  @override
  State<IncDecButton> createState() => _IncDecButtonState();
}

class _IncDecButtonState extends State<IncDecButton> {
  //CartController cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        Text(widget.count.toString(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center),
        Container(
          height: 100,
          width: 40,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    widget.count++;
                  });
                  print('add');
                },
                child: Icon(Icons.add),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    widget.count--;
                  });
                  print('remove');
                },
                child: Icon(Icons.remove),
              ),
            ],
          ),
        ),
        Container(
          height: 100,
          width: size.width / 5,
          //color: Colors.blue,
          padding: EdgeInsets.only(right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () async {
                  // var responce = await _cartItemDeleteController.cartItemDelete(
                  //   _homeController.tokenGlobal,
                  //   _homeController.userId,
                  //   cartData.grocery[index].id,
                  //   'grocery',
                  // );
                  setState(() {});

                  // if (responce != null) {
                  //   setState(() {});
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => CartScreen()),
                  //   );

                  //   print("Item deleted");
                  // } else {
                  //   setState(() {});
                  //   print("Item not deleted");
                  // }
                },
                icon: Icon(Icons.delete),
                color: Colors.red,
              ),
              Text(
                "${widget.count * widget.price}kr",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
