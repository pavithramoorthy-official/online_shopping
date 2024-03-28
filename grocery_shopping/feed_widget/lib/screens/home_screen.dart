import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_shopping/services/utilities.dart';
import 'package:grocery_shopping/widgets/feed_widget.dart';
import 'package:grocery_shopping/widgets/onsale_widget.dart';
import 'package:grocery_shopping/widgets/text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _offerImages = [
    'assets/images/offers/offer_01.jpg',
    'assets/images/offers/offer_02.webp',
    'assets/images/offers/offer_03.webp',
    'assets/images/offers/offer_05.webp'
  ];
  @override
  Widget build(BuildContext context) {
    //final themeState = Provider.of<DarkThemeProvider>(context);

    Utilities utilities = Utilities(context);
    final themeState = utilities.getTheme;
    Size size = utilities.getScreenSize;
    Color color = Utilities(context).color;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.33,
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return Image.asset(
                    _offerImages[index],
                    fit: BoxFit.fill,
                  );
                },
                autoplay: true,
                itemCount: _offerImages.length,
                pagination: const SwiperPagination(
                  alignment: Alignment.bottomCenter,
                  builder: DotSwiperPaginationBuilder(
                      activeColor: Colors.red, color: Colors.white),
                ),
                //control: SwiperControl(color: Colors.black), ==> display this >
              ),
            ),

            const SizedBox(
              height: 6,
            ),
            TextButton(
              onPressed: () {},
              child: TextWidget(
                text: "View All",
                color: Colors.cyan,
                textSize: 20,
                isTitle: true,
                maxlines: 1,
              ),
            ),

            // onsale widget starts here

            Row(
              children: [
                RotatedBox(
                  quarterTurns: -1,
                  child: Row(
                    children: [
                      TextWidget(
                        text: "On Sale".toUpperCase(),
                        color: Colors.red,
                        textSize: 20,
                        isTitle: true,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        IconlyLight.discount,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                Flexible(
                  child: SizedBox(
                    height: size.height * 0.26,
                    child: ListView.builder(
                        itemCount: 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, index) {
                          return const OnsaleWidget();
                        }),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: "Our Products",
                    color: color,
                    textSize: 22,
                    isTitle: true,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Browse all",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              crossAxisSpacing: 3,
              mainAxisSpacing: 3,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: size.width / size.width * 0.85,
              children: List.generate(4, (index) {
                return const FeedWidget();
              }),
            ),
          ],
        ),
      ),
    );
  }
}
