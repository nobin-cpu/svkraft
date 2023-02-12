import 'package:flutter/material.dart';

class Resturanthome extends StatefulWidget {
  const Resturanthome({Key? key}) : super(key: key);

  @override
  State<Resturanthome> createState() => _ResturanthomeState();
}

class _ResturanthomeState extends State<Resturanthome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 200,
            centerTitle: true,
            bottom: AppBar(
              title: Container(
                height: 45,
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 5, left: 15),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        print('sesarch');
                      },
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "What are you looking for ?",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              elevation: 20,
            ),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  height: 100,
                  child: Center(
                    child: Text('eee'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
