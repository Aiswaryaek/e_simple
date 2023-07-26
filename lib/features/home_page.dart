// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_simple/styles/colors.dart';
import 'package:flutter/material.dart';

import '../models/profile_model.dart';
import '../styles/text_style.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CarouselController _controller = CarouselController();
  final optionItems = <Profile>[];

  List<String> images = [
    "https://media.istockphoto.com/id/1136530201/photo/silhouette-of-business-people-work-together-in-office-concept-of-teamwork-and-partnership.jpg?s=612x612&w=0&k=20&c=xYRzaUW7Lnom31NEXaxQL_4ZI98G2kLnkxtIh1jwuEY=",
    "https://st4.depositphotos.com/3396639/27957/i/450/depositphotos_279572676-stock-photo-puzzled-female-director-elegant-suit.jpg",
    "https://thumbs.dreamstime.com/b/business-man-distribute-digital-mail-image-has-attached-release-35494611.jpg"
  ];

  @override
  void initState() {
    super.initState();
    optionItems.add(Profile('Aparna'));
    optionItems.add(Profile('Akhila'));
    optionItems.add(Profile('Akshay'));
    optionItems.add(Profile('Arjun'));
    optionItems.add(Profile('abhirami'));
    optionItems.add(Profile('Akash'));
    optionItems.add(Profile('Anjana'));
    optionItems.add(Profile('Saalviya'));
    optionItems.add(Profile('Anirudh'));
    optionItems.add(Profile('Sharath'));
    optionItems.add(Profile('Aswanth'));
    optionItems.add(Profile('Anagha'));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leading: SizedBox(),
        backgroundColor: richTextColor,
        title: Text(
          'Home',
          style: btnTextStyle,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 150.0,
                viewportFraction: 1,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 600),
                enlargeCenterPage: false,
              ),
              carouselController: _controller,
              items: images
                  .map((item) => Container(
                        child: Center(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                item,
                                fit: BoxFit.cover,
                                width: 1000,
                              )),
                        ),
                      ))
                  .toList(),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: optionItems.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => Container(
                  color: listBackgroundColor,
                  width: double.infinity,
                  child: Card(
                    semanticContainer: true,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: whiteColor, width: 1),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    margin: EdgeInsets.all(5),
                    child: ListTile(
                      leading: Transform.translate(
                        offset: Offset(-2, 0),
                        child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTH4kreGAFgebiJm_O8XNna2Uki8H_X7vc--IZdpjItGs3hH3WF9Pn6pokwMlI-Hb6qSe4&usqp=CAU',
                                  height: 81,
                                  width: 82,
                                  fit: BoxFit.fill),
                            )),
                      ),
                      title: Text(
                        optionItems[index].text,
                        style: normalText,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 11,
                        color: normalTextColor,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
