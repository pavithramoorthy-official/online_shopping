import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:grocery_shopping/services/utilities.dart';
import 'package:grocery_shopping/widgets/onsale_widget.dart';

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
    'assets/images/offers/offer_04.webp',
    'assets/images/offers/offer_05.webp'
  ];
  @override
  Widget build(BuildContext context) {
    //final themeState = Provider.of<DarkThemeProvider>(context);

    Utilities utilities = Utilities(context);
    final themeState = utilities.getTheme;
    Size size = utilities.getScreenSize;

    return Scaffold(
      body: Column(
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

          // onsale widget starts here
          SizedBox(
            height: size.height * 0.26,
            child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index) {
                  return OnsaleWidget();
                }),
          ),
        ],
      ),
    );
  }
}
