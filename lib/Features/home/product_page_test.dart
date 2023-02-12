import 'package:flutter/material.dart';
import 'package:sv_craft/constant/constant.dart';

import '../../constant/color.dart';
import 'home_caroucel.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            //bottom: 447,
            child: Container(
              height: size.height * .22,
              width: size.width,
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white, //<-- SEE HERE
                      child: IconButton(
                        icon: Icon(
                          Icons.menu,
                          color: Colors.black,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Text(
                      'SHOP',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white, //<-- SEE HERE
                      child: IconButton(
                        icon: Icon(
                          Icons.shopping_cart,
                          color: Colors.black,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.12,
            left: size.width * .03,
            right: size.width * .03,
            //bottom: 447,
            child: CarouselImage(),
          ),
          Positioned(
            top: size.height * 0.37,
            left: 0,
            right: 0,
            //bottom: 447,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              //mainAxisSize: MainAxisSize.max,
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12, //color of shadow
                          spreadRadius: 2, //spread radius
                          blurRadius: 5, // blur radius
                          offset: Offset(0, 2), // changes position of shadow
                          //first paramerter of offset is left-right
                          //second parameter is top to down
                        )
                      ],
                    ),
                    width: 153,
                    height: 37,
                    child: Text('SUPER DEAL'),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12, //color of shadow
                          spreadRadius: 2, //spread radius
                          blurRadius: 5, // blur radius
                          offset: Offset(0, 2), // changes position of shadow
                          //first paramerter of offset is left-right
                          //second parameter is top to down
                        )
                      ],
                    ),
                    width: 153,
                    height: 37,
                    child: Text('NEW ARRIVALS'),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: size.height * 0.44,
            left: size.width * .03,
            right: size.width * .03,

            //bottom: 447,
            child: Container(
              height: 500,
              //color: Colors.blue,
              child: Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 20, bottom: 10),
                  itemCount: 100,
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: .8,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (BuildContext context, int index) => Container(
                    //color: Colors.green,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12, //color of shadow
                          spreadRadius: 2, //spread radius
                          blurRadius: 5, // blur radius
                          offset: Offset(0, 2), // changes position of shadow
                          //first paramerter of offset is left-right
                          //second parameter is top to down
                        )
                      ],
                    ),

                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Image.network(
                            'https://images.unsplash.com/photo-1618354691373-d851c5c3a990?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8c2hpcnR8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
                            fit: BoxFit.cover,
                            width: 120,
                            height: 150,
                          ),
                        ),
                        Text(
                          "Product Name",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "510.00",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    // height: 147,
                    // width: ,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
