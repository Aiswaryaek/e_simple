import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/ui_state.dart';
import '../providers/home_provider.dart';
import '../repositories/catalog_repository.dart';
import '../styles/colors.dart';
import '../styles/text_style.dart';

class AllCategories extends StatefulWidget {
  const AllCategories({Key? key}) : super(key: key);

  @override
  State<AllCategories> createState() => _AllCategoriesState();
}

class _AllCategoriesState extends State<AllCategories> {
  HomeProvider homeProvider = HomeProvider(
    catalogRepository: CatalogRepository(),
  );

  @override
  void initState() {
    super.initState();
    homeProvider.getCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: richTextColor,
          title: Text(
            'All Categories',
            style: btnTextStyle,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: allCategories(),
        )
      ),
    );
  }

  Widget allCategories() {
    return ChangeNotifierProvider<HomeProvider>(
      create: (ctx) {
        return homeProvider;
      },
      child: Consumer<HomeProvider>(builder: (ctx, data, _) {
        var state = data.getCategoryListLiveData().getValue();
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
          return GridView.builder(shrinkWrap: true,
            itemCount: data.list.length,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 3,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (context, index) => Column(
              children: [
                Flexible(
                  child: Column(
                    children: [
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.only(top: 3),
                          height: 90,
                          width: MediaQuery.of(context).size.width *0.27,
                          decoration: BoxDecoration(border: Border.all(color: cardColor),
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.network(data.list[index].image!,height: 63,  fit: BoxFit.contain),

                              Container(
                                height: 20,
                                decoration: BoxDecoration(
                                    color: cardColor,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(13),
                                      bottomRight: Radius.circular(13),
                                    )
                                ),
                                child: Center(child: Text(data.list[index].name!.split(' ').take(1).join(' '),style: smallText,)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
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
}
