import 'dart:async';
import 'package:flutter/material.dart';
import 'package:memory_game/data/data.dart';
import 'package:memory_game/models/tile_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  List<TileModel> gridViewTiles = [];
  List<TileModel> questionPairs = [];

  @override
  void initState() {
    super.initState();
    reStart();
  }
  void reStart() {
    myPairs = getPairs();
    myPairs.shuffle();
    gridViewTiles = myPairs;
    Future.delayed(const Duration(seconds: 0), () {
      setState(() {
        // Here you can write your code for open new view
        questionPairs = getQuestionPairs();
        gridViewTiles = questionPairs;
        selected = false;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            points != 800 ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "$points/800",
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Text(
                  "Points",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w300),
                ),
              ],
            ) : Container(),
            SizedBox(
              height: 20,
            ),
            points != 800 ? GridView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  mainAxisSpacing: 0.0, maxCrossAxisExtent: 100.0),
              children: List.generate(gridViewTiles.length, (index) {
                return Tile(
                  imagePathUrl: gridViewTiles[index].getImageAssetPath()!,
                  tileIndex: index,
                  parent: this,
                );
              }),
            ) : Expanded(
              child: Center(
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      points = 0;
                      reStart();
                    });
                  },
                  child: Container(
                    height: 50,
                    width: 200,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Text("Replay", style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w500
                    ),),
                  ),
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}



class Tile extends StatefulWidget {
  final String? imagePathUrl;
  final int? tileIndex;
  final HomeState? parent;

   Tile({this.imagePathUrl, this.tileIndex, this.parent});

  @override
  TileState createState() => TileState();
}

class TileState extends State<Tile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!selected) {
          setState(() {
            myPairs[widget.tileIndex!].setIsSelected(true);
          });
          if (selectedTile != "") {
            /// testing if the selected tiles are same
            if (selectedTile == myPairs[widget.tileIndex!].getImageAssetPath()) {
              points = points + 100;

              TileModel tileModel = new TileModel();
              print(widget.tileIndex);
              selected = true;
              Future.delayed(const Duration(seconds: 2), () {
                tileModel.setImageAssetPath("");
                myPairs[widget.tileIndex!] = tileModel;
                print(selectedIndex);
                myPairs[selectedIndex!] = tileModel;
                this.widget.parent!.setState(() {});
                setState(() {
                  selected = false;
                });
                selectedTile = "";
              });
            } else {
              selected = true;
              Future.delayed(const Duration(seconds: 2), () {
                this.widget.parent!.setState(() {
                  myPairs[widget.tileIndex!].setIsSelected(false);
                  myPairs[selectedIndex!].setIsSelected(false);
                });
                setState(() {
                  selected = false;
                });
              });

              selectedTile = "";
            }
          } else {
            setState(() {
              selectedTile = myPairs[widget.tileIndex!].getImageAssetPath()!;
              selectedIndex = widget.tileIndex;
            });

            print(selectedTile);
            print(selectedIndex);
          }
        }
      },
      child: Container(
        margin: EdgeInsets.all(5),
        child: myPairs[widget.tileIndex!].getImageAssetPath() != null &&
            myPairs[widget.tileIndex!].getImageAssetPath() != ""
            ? Image.asset(myPairs[widget.tileIndex!].getIsSelected() != null && myPairs[widget.tileIndex!].getIsSelected()!
            ? myPairs[widget.tileIndex!].getImageAssetPath()!
            : widget.imagePathUrl!)
            : Container(
          color: Colors.white,
          child: Image.asset("assets/correct.png"),
        ),
      ),
    );
  }
}
