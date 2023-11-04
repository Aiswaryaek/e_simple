// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_simple/features/all_categories.dart';
import 'package:e_simple/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/ui_state.dart';
import '../providers/home_provider.dart';
import '../repositories/catalog_repository.dart';
import '../styles/text_style.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CarouselController _controller = CarouselController();
  HomeProvider homeProvider = HomeProvider(
    catalogRepository: CatalogRepository(),
  );
  List<String> images = [
    "https://wellcurve.in/blog/wp-content/uploads/2021/08/Organic-Food-Brands.jpg",
    "https://media.licdn.com/dms/image/D4D12AQEr77UTzYNHVA/article-cover_image-shrink_720_1280/0/1689577293355?e=2147483647&v=beta&t=8ma6vGDXH7VDhWvutRBcpOwQL9tCLIxnFfVnGLkLkTc",
    "https://organicindia.com/cdn/shop/files/Diwali_Offer_1920x800_99959b13-7aa4-403d-8baf-31e324717c26.jpg?v=1698296700",
    "https://www.shopickr.com/wp-content/uploads/2015/06/amazon-india-24-organic-food-discount-6-17-2015-555x250.jpg"
  ];

  @override
  void initState() {
    super.initState();
    homeProvider.getCategoryList();
    homeProvider.getTrendingList();
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
                'Home Page',
                style: btnTextStyle,
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
                child: categoryList(context))));
  }

  Widget categoryList(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>(
      create: (ctx) {
        return homeProvider;
      },
      child:
      Consumer<HomeProvider>(builder: (ctx, data, _) {
        var state = data.getCategoryListLiveData().getValue();
        if (state is IsLoading) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 1.3,
            child: Center(
              child: CircularProgressIndicator(
                color: cardColor,
              ),
            ),
          );
        } else if (state is IsEmpty) {
          return Text('This List Is Empty');
        } else if (state is Success) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                  const EdgeInsets.only(left: 15, right: 15, top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Top Categories', style: homeText),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AllCategories(),
                            ),
                          );
                        },
                        child: Text('See all', style: richText),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 9),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 138,
                            child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: data.list.length,
                                separatorBuilder: (context, _) => const SizedBox(width: 9),
                                itemBuilder: (context, index) => InkWell(
                                  child: Container(
                                    padding: const EdgeInsets.only(top: 7,right: 7,left: 7),
                                    height: 110,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        color: whiteColor,
                                        border: Border.all(
                                          color: cardColor,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(11))),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Image.network(data.list[index].image!,fit: BoxFit.cover,height: 40,),
                                        Text(
                                          data.list[index].name!,
                                          overflow: TextOverflow.ellipsis,
                                          style: homeText,
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          'foods grown without artificial pesticides or fertilizers',
                                          overflow: TextOverflow.fade,
                                          style: categoryText,
                                        ),
                                        const SizedBox(height: 8),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 7, right: 7,bottom: 0),
                                          width: 125,
                                          height: 20,
                                          child: OutlinedButton(
                                            onPressed: () async {},
                                            child: Text('View Detail',
                                                style: smallText),
                                            style: OutlinedButton.styleFrom(
                                              backgroundColor: cardColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              side: BorderSide(
                                                  width: 0.7,
                                                  color: cardColor),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                          ),
                        ],
                      ),
                      SizedBox(height: 14),
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 150.0,
                          viewportFraction: 1,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration:
                          Duration(milliseconds: 600),
                          enlargeCenterPage: false,
                        ),
                        carouselController: _controller,
                        items: images
                            .map((item) => Container(
                          child: Center(
                            child: ClipRRect(
                                borderRadius:
                                BorderRadius.circular(12),
                                child: Image.network(
                                  item,
                                  fit: BoxFit.cover,
                                  width: 1000,
                                )),
                          ),
                        ))
                            .toList(),
                      ),
                      SizedBox(height: 13),
                      Text('Trending Products', style: homeText),
                      SizedBox(height: 10),
                      trending_products(),
                      SizedBox(height: 15),
                      Image.asset('assets/images/offer_image.png'),
                      SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Image.asset('assets/images/icon-fresh.png',
                                    height: 44),
                                SizedBox(height: 5),
                                Text('100%', style: smallText),
                                Text('Natural', style: smallText),
                              ],
                            ),
                            Column(
                              children: [
                                Image.asset('assets/images/icon-healthy.png',
                                    height: 44),
                                SizedBox(height: 5),
                                Text('Healthy', style: smallText),
                                Text('Cooking', style: smallText),
                              ],
                            ),
                            Column(
                              children: [
                                Image.asset('assets/images/icon-natural.png',
                                    height: 44),
                                SizedBox(height: 5),
                                Text('Always', style: smallText),
                                Text('Fresh', style: smallText),
                              ],
                            ),
                            Column(
                              children: [
                                Image.asset('assets/images/icon-quality.png',
                                    height: 44),
                                SizedBox(height: 5),
                                Text('Best', style: smallText),
                                Text('Quality', style: smallText),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]);
        } else if (state is Failure) {
          return Center(
            child: Text('${state.error}'),
          );
        } else {
          return Container();
        }
      }),
    );
  }

  Widget trending_products() {
    return ChangeNotifierProvider<HomeProvider>(
      create: (ctx) {
        return homeProvider;
      },
      child: Consumer<HomeProvider>(builder: (ctx, data, _) {
        var state = data.getTrendingProductListLiveData().getValue();
        print(state);
        if (state is IsLoading) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 1.3,
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            ),
          );
        } else if (state is Initial) {
          return Text('This List Is Empty');
        } else if (state is Success) {
          return GridView.builder(
            itemCount: data.trendingList.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisExtent: 160,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (BuildContext context, int index) =>
                Column(
                  children: [
                    Flexible(
                      child: Container(
                        // height: 230,
                        decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                            border: Border.all(
                              color: cardColor,
                            )),
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 6),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                  EdgeInsets.only(left: 23),
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 10, top: 5),
                                      child: Image.network(
                                        data.trendingList[index].imgUrl!,
                                        height: 57,
                                        width: 82,
                                        // fit: BoxFit.fill
                                      )),
                                ),
                                SizedBox(width: 6),
                                Padding(
                                  padding:
                                  EdgeInsets.only(bottom: 33),
                                  child: Image.asset(
                                      'assets/images/organic.png',
                                      height: 17,
                                      width: 17,
                                      fit: BoxFit.contain),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Center(
                                child: Text(data.trendingList[index].name!,
                                    overflow: TextOverflow.ellipsis,
                                    style: smallText,
                                    textAlign: TextAlign.center),
                              ),
                            ),
                            Text('₹ ' + '${data.trendingList[index].price!.sale!}', style: smallText),
                            SizedBox(height: 8),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: 7, right: 7),
                                width: double.infinity,
                                height: 23.0,
                                child: OutlinedButton(
                                  onPressed: () async {},
                                  child: Text('View Detail',
                                      style: smallText),
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: cardColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(8),
                                    ),
                                    side: BorderSide(
                                        width: 0.7,
                                        color: cardColor),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
          );

        } else if (state is Failure) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 1.3,
            child: Center(
              child: Text('No products'),
            ),
          );
        } else {
          return Container();
        }
      }),
    );
  }
}
