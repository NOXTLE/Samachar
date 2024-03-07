import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:news/Services/state.dart';
import 'package:news/pages/component/newscard.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = ScrollController();
    return Consumer<MyState>(
      builder: (context, value, child) => OrientationBuilder(
        builder: (context, orientation) => Scaffold(
          appBar: AppBar(
              surfaceTintColor: Colors.transparent,
              centerTitle: true,
              title: Text("Samachar",
                  style:
                      GoogleFonts.monofett(fontSize: 34, color: Colors.black))),
          body: ListView(children: [
            Gap(20),
            Container(
              alignment: Alignment.center,
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  orientation == Orientation.landscape
                      ? SizedBox(width: MediaQuery.of(context).size.width / 12)
                      : Container(),
                  Expanded(
                    child: ListView.builder(
                        controller: controller,
                        scrollDirection: Axis.horizontal,
                        itemCount: value.categories.length,
                        itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: GestureDetector(
                                onTap: () {
                                  if (index == value.categories.length - 1 ||
                                      index == value.categories.length - 2) {
                                  } else if (orientation ==
                                      Orientation.landscape) {
                                  } else {
                                    controller.jumpTo(index * 104);
                                  }
                                  value.select(index);
                                },
                                child: Container(
                                  height: 100,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        value.selected_index == index
                                            ? BoxShadow(
                                                offset: Offset(1, 1),
                                                color: Colors.grey.shade400,
                                                spreadRadius: 1,
                                                blurRadius: 1)
                                            : BoxShadow()
                                      ],
                                      borderRadius: BorderRadius.circular(20),
                                      color: value.selected_index == index
                                          ? value.selected_color
                                          : Colors.white),
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(value.categories[index],
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight:
                                                value.selected_index == index
                                                    ? FontWeight.bold
                                                    : FontWeight.normal)),
                                  ),
                                ),
                              ),
                            )),
                  ),
                ],
              ),
            ),
            Gap(10),
            FutureBuilder(
                future: value.Headlines(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                        height: MediaQuery.of(context).size.height,
                        child: Image.asset(
                          "lib/img/Animation - 1708309251590.gif",
                          height: 100,
                        ));
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("AN ERROR OCCURED"),
                            GestureDetector(
                              onTap: () => value.refresh(),
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Icon(Icons.replay_outlined))),
                            )
                          ]),
                    );
                  }
                  var data = snapshot.data;

                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height - 160,
                      child: ListView.builder(
                          itemCount: data['articles'].length,
                          itemBuilder: (context, index) => Padding(
                              padding: EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  ScrollController sc = ScrollController();
                                  showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              1.5,
                                          child: Stack(
                                              alignment: Alignment.bottomCenter,
                                              children: [
                                                Container(
                                                  decoration: const BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(20),
                                                              topRight: Radius
                                                                  .circular(
                                                                      20))),
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      1.7,
                                                  child: Content(
                                                    url: data['articles'][index]
                                                        ['url'],
                                                    Description:
                                                        data['articles'][index]
                                                            ['description'],
                                                    content: data['articles']
                                                        [index]['content'],
                                                    date: data['articles']
                                                                [index]
                                                            ['publishedAt']
                                                        .toString(),
                                                    title: data['articles']
                                                        [index]['title'],
                                                    author: data['articles']
                                                        [index]['author'],
                                                    image_url: data['articles']
                                                                [index]
                                                            ['urlToImage']
                                                        .toString(),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 0,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        color: Colors.white),
                                                    child: IconButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        icon: Icon(
                                                          Icons.close,
                                                          color: Colors.black,
                                                        )),
                                                  ),
                                                )
                                              ]),
                                        );
                                      });
                                },
                                child: NewsCard(
                                  image_url: data['articles'][index]
                                          ['urlToImage']
                                      .toString(),
                                  title: data['articles'][index]['title']
                                      .toString(),
                                ),
                              ))),
                    ),
                  );
                }),
          ]),
        ),
      ),
    );
  }
}

class Content extends StatelessWidget {
  Content(
      {super.key,
      required this.date,
      required this.author,
      required this.image_url,
      required this.title,
      required this.content,
      required this.url,
      required this.Description});

  String date;
  String image_url;
  var title;
  var author;
  String content;
  String Description;
  String url;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            child: image_url == "null"
                ? Image.network(
                    "https://img.freepik.com/free-photo/3d-rendering-illustration-letter-blocks-forming-word-news-white-background_181624-60840.jpg")
                : Image.network(image_url)),
        Container(
          child: Column(children: []),
        ),
        Expanded(
          child: ListView(children: [
            Gap(10),
            Center(child: Text("Author : $author")),
            Center(child: Text(date.substring(0, 10))),
            Gap(10),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Positioned(
                    child: Text(title,
                        style: GoogleFonts.merriweather(
                            fontWeight: FontWeight.bold, fontSize: 18)))),
            Gap(10),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text(Description)),
          ]),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 70,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromARGB(255, 163, 233, 165)),
          child: Positioned(
            bottom: 0,
            child: GestureDetector(
              onTap: () async {
                await FlutterWebBrowser.openWebPage(url: url);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Read Full Article",
                    style: GoogleFonts.raleway(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
