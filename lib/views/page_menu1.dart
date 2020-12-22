import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../constants/color_palette.dart';
import '../constants/constant.dart';
import '../utils/helper.dart';

class PageMenu1 extends StatefulWidget {
  @override
  _PageMenu1State createState() => _PageMenu1State();
}

class _PageMenu1State extends State<PageMenu1> {
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Keluar Aplikasi?',
              style: TextStyle(
                  color: ColorPalette.btnNewColor, fontWeight: FontWeight.bold),
            ),
            content: Text('Anda akan keluar dari Aplikasi'),
            actions: [
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Tidak'),
              ),
              FlatButton(
                onPressed: () => SystemNavigator.pop(),
                child: Text('Iya'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return _onWillPop();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: ColorPalette.appBarColor,
          title: Row(
            children: [
              Image.asset(
                "assets/logo.png",
                width: 80.0,
                height: 80.0,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(5.0),
                  height: 35.0,
                  child: Text(
                    appTitle,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ),
              ),
            ],
          ),
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: ScrollPhysics(),
          children: [
            Column(
              children: [
                Container(
                    height: 220.0,
                    margin: EdgeInsets.only(left: 16, right: 16, top: 10),
                    child: _getBanner(context)),
                Container(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      _getSaldo(),
                      GestureDetector(
                        onTap: () {
                          setState(() {});
                        },
                        child: Container(
                            margin: EdgeInsets.only(left: 5.0, right: 5.0),
                            child: Icon(
                              Icons.refresh,
                              color: ColorPalette.iconColor,
                              size: 40.0,
                            )),
                      ),
                      Expanded(
                          child: Container(
                        width: double.infinity,
                        height: 40,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: ColorPalette.iconColor),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(right: 5),
                                        child: Image.asset(
                                          "assets/wallet.png",
                                          color: Colors.white,
                                        )),
                                    Text(
                                      "Isi Saldoku",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))
                    ],
                  ),
                ),
                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: 16.0, bottom: 10.0, right: 16.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: Text(
                                    "Berita",
                                    style: TextStyle(
                                        color: ColorPalette.iconColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0),
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                  padding: EdgeInsets.all(10),
                                  height: 1,
                                  decoration: BoxDecoration(color: Colors.grey),
                                )),
                              ],
                            ),
                          ),
                          _getDataArticle(),
                          Container(
                            margin: EdgeInsets.only(
                                top: 10.0,
                                left: 16.0,
                                bottom: 10.0,
                                right: 16.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: Text(
                                    "Komunitas",
                                    style: TextStyle(
                                        color: ColorPalette.iconColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                  padding: EdgeInsets.all(10),
                                  height: 1,
                                  decoration: BoxDecoration(color: Colors.grey),
                                )),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: 12.0,
                                bottom: 30.0,
                                right: 12.0,
                                top: 15.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          height: 70.0,
                                          width: 70.0,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(22.0),
                                              color: ColorPalette.iconColor),
                                          child: InkWell(
                                            onTap: () {},
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.forum,
                                                    color: Colors.white,
                                                    size: 40,
                                                  )
                                                ]),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          margin: EdgeInsets.only(top: 5.0),
                                          child: Text("Menu 1",
                                              style: TextStyle(fontSize: 12.0)),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          height: 70.0,
                                          width: 70.0,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(22.0),
                                              color: ColorPalette.iconColor),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.receipt,
                                                  color: Colors.white,
                                                  size: 40,
                                                )
                                              ]),
                                        ),
                                      ),
                                      Stack(
                                          overflow: Overflow.visible,
                                          children: [
                                            Container(
                                                margin: EdgeInsets.only(top: 5),
                                                child: Column(children: [
                                                  Text('Menu 2',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                      )),
                                                ])),
                                           
                                          ])
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          height: 70,
                                          width: 70,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(22),
                                              color: ColorPalette.iconColor),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.search,
                                                  color: Colors.white,
                                                  size: 40,
                                                )
                                              ]),
                                        ),
                                      ),
                                      Stack(
                                        overflow: Overflow.visible,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(top: 5.0),
                                            child: Column(
                                              children: [
                                                Text("Menu 3",
                                                  style: TextStyle(
                                                    fontSize: 12.0
                                                  )
                                                ),
                                              ],
                                            )
                                          ),
                                        ]
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          height: 70,
                                          width: 70,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(22),
                                              color: ColorPalette.iconColor),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                    "assets/ic_ynci.png"),
                                              ]),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 5.0),
                                        child: Text("Menu 4",
                                            style: TextStyle(fontSize: 12.0)),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: 12.0,
                                bottom: 60.0,
                                right: 12.0,
                                top: 10.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          height: 70.0,
                                          width: 70.0,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(22),
                                              color: ColorPalette.iconColor),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                    "assets/ic_instagram.png"),
                                              ]),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 5.0),
                                        child: Text("Menu 5",
                                            style: TextStyle(fontSize: 12.0)),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          height: 70.0,
                                          width: 70.0,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(22.0),
                                              color: ColorPalette.iconColor),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                    "assets/ic_youtube.png"),
                                              ]),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 5.0),
                                        child: Text("Menu 6",
                                            style: TextStyle(fontSize: 12.0)),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          height: 70,
                                          width: 70,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(22),
                                              color: ColorPalette.iconColor),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(
                                                  Icons.shopping_cart,
                                                  color: Colors.white,
                                                  size: 40,
                                                )
                                              ]),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 5),
                                        child: Text("Menu 7",
                                            style: TextStyle(fontSize: 12)),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          height: 70,
                                          width: 70,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(22),
                                              color: ColorPalette.iconColor),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.phone_android,
                                                  color: Colors.white,
                                                  size: 40,
                                                )
                                              ]),
                                        ),
                                      ),
                                      Stack(
                                          overflow: Overflow.visible,
                                          children: [
                                            Container(
                                                margin: EdgeInsets.only(top: 5.0),
                                                child: Column(
                                                  children: [
                                                    Text("Menu 8",
                                                        style: TextStyle(
                                                            fontSize: 12.0)),
                                                  ],
                                                )),
                                        
                                          ])
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _getDataArticle() {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: 1,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(left: 16.0, right: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: 100.0,
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: CachedNetworkImage(
                              imageUrl: '',
                              width: double.infinity,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Center(
                                  child: SizedBox(
                                      width: 15.0,
                                      height: 15.0,
                                      child: CircularProgressIndicator())),
                              errorWidget: (context, url, error) => Center(
                                  child: Image.asset(
                                "assets/default_image.png",
                                width: double.infinity,
                                fit: BoxFit.cover,
                              )),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.black26),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: Text(
                                'Content',
                                maxLines: 2,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _getBanner(BuildContext context) {
    List _images = [
      'https://images.squarespace-cdn.com/content/v1/594d574abe6594333aa767d8/1584850241889-58TKFREHAN9D09KG1WYB/ke17ZwdGBToddI8pDm48kOggE0Ch6pMGalwtLMqzsSB7gQa3H78H3Y0txjaiv_0fDoOvxcdMmMKkDsyUqMSsMWxHk725yiiHCCLfrh8O1z5QPOohDIaIeljMHgDF5CVlOqpeNLcJ80NK65_fV7S1Ufo5RWkg_J4of0jUNHaDHx6pZKBvpVYzidBWCapg0tuoMuEaB2HPGSYDV-11UTcW2g/red-dark.jpg?format=2500w',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDG1Nt93Ts6WaEVN0P34CZNmZAE7q0l-U5wQ&usqp=CAU',
      'https://www.brightquilting.co.uk/wp-content/uploads/2019/09/salt-dyed-batics-darkpink021.jpg'
    ];
    return Container(
        child: CarouselSlider(
      items: _images.map((image) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: Image.network(
              image,
              fit: BoxFit.contain,
            ),
          ),
        );
      }).toList(),
      options: CarouselOptions(
        height: 220,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        viewportFraction: 1.0,
      ),
    ));
  }

  Widget _getSaldo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: <Widget>[
            Image.asset("assets/coin.png"),
            Container(
              margin: EdgeInsets.only(left: 4),
              child: Text(
                "Saldo Anda",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        Text(
          ConnexistHelper.formatCurrency(double.parse('1000')),
          style: TextStyle(
            color: ColorPalette.iconColor,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
