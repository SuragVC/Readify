import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_library_app/network/implementation.dart';
import 'package:my_library_app/schemas/schemas.dart';
import 'package:my_library_app/ui/widgets/book_container.dart';
import 'package:my_library_app/ui/widgets/loader.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;
  List<Book> healthList = [];
  List<Book> technologyList = [];
  List<Book> horrorList = [];
  List<String> carouselList = [
    "assets/sliders/slider_1.png",
    "assets/sliders/slider_2.png",
    "assets/sliders/slider_3.png",
    "assets/sliders/slider_4.png",
  ];
  @override
  void initState() {
    loadBooks();
    super.initState();
  }

  loadBooks() async {
    healthList = await NetWorkImplementation.getBookListByCategory("health");
    technologyList =
        await NetWorkImplementation.getBookListByCategory("technology");
    horrorList = await NetWorkImplementation.getBookListByCategory("horror");
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: width,
      height: height,
      child: _isLoading
          ? const CustomLoader()
          : SingleChildScrollView(
              child: Column(
                children: [
                  //CarouselSlider
                  carouselSlider(carouselList),
                  const Divider(),
                  Container(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      children: [
                        headerText("Health"),
                        const Divider(),
                        gapBuilder(),
                        layoutBuilderForBookContainer(context, healthList),
                        gapBuilder(),
                        headerText("Technology"),
                        const Divider(),
                        layoutBuilderForBookContainer(context, technologyList),
                        headerText("Horror"),
                        const Divider(),
                        gapBuilder(),
                        layoutBuilderForBookContainer(context, horrorList)
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

carouselSlider(List<String> carouselList) {
  return CarouselSlider.builder(
    options: CarouselOptions(
      height: kIsWeb ? 400 : 200,
      autoPlay: true,
      autoPlayInterval: const Duration(seconds: 3),
      autoPlayAnimationDuration: const Duration(milliseconds: 800),
      autoPlayCurve: Curves.fastOutSlowIn,
      enlargeCenterPage: true,
      enlargeFactor: 0.3,
    ),
    itemCount: 4,
    itemBuilder: (BuildContext context, int index, int pageViewIndex) =>
        Padding(
      padding: const EdgeInsets.all(5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.asset(
          carouselList[index],
          fit: kIsWeb ? BoxFit.fill : BoxFit.fitWidth,
          width: MediaQuery.of(context)
              .size
              .width, // Full width of the screen minus padding
          height: double.infinity, // Take full height available
        ),
      ),
    ),
  );
}

gapBuilder() {
  return const SizedBox(
    height: 10,
  );
}

headerText(String header) {
  return Align(
    alignment: Alignment.topLeft,
    child: InkWell(
      child: Text(header),
    ),
  );
}

layoutBuilderForBookContainer(BuildContext context, List<Book> bookList) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  return SizedBox(
    width: width * 0.9,
    height: kIsWeb ? height * 0.2 : height * 0.2,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: bookList.length > 10 ? 20 : bookList.length,
      itemBuilder: (context, index) {
        return LayoutBuilder(
          builder: (context, constraints) {
            double containerHeight = kIsWeb
                ? constraints.maxHeight * 0.9
                : constraints.maxHeight * 0.8;
            double containerWidth = kIsWeb
                ? constraints.maxWidth * 0.1
                : constraints.maxWidth * 0.8;
            return SizedBox(
              width: kIsWeb ? width * 0.1 : width * 0.3,
              height: height * 0.9,
              child: BookContainer(
                title: bookList[index].volumeInfo!.title!,
                imageUrl: bookList[index].volumeInfo?.imageLinks?.thumbnail,
                containerHeight: containerHeight,
                containerWidth: containerWidth,
              ),
            );
          },
        );
      },
    ),
  );
}
