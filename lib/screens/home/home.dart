import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_ui/data/app_data.dart';
import 'package:shop_ui/models/base_model.dart';
import 'package:shop_ui/screens/detail/detail.dart';
import 'package:shop_ui/utils/constants.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController _pageController = PageController(
    initialPage: 2,
    viewportFraction: .7,
  );

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // top two text
              _buildTopTwoText(theme),
              // category
              _buildCategory(size, theme),
              // body
              FadeInUp(
                delay: const Duration(
                  milliseconds: 500,
                ),
                child: Container(
                  margin: const EdgeInsets.only(top: 7),
                  height: size.height * .45,
                  width: size.width,
                  child: PageView.builder(
                    controller: _pageController,
                    physics: const BouncingScrollPhysics(),
                    itemCount: mainList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Detail(
                                baseModel: mainList[index],
                              ),
                            ));
                          },
                          child: _view(index, theme, size, _pageController));
                    },
                  ),
                ),
              ),
              // most popurlar text
              _buildPopularText(theme),
              // most popular content
              _buildPopularContent(size, theme)
            ],
          ),
        ),
      ),
    );
  }

  FadeInUp _buildPopularContent(Size size, TextTheme theme) {
    return FadeInUp(
      delay: const Duration(milliseconds: 700),
      child: SizedBox(
        height: size.height * .44,
        width: size.width,
        child: GridView.builder(
          itemCount: mainList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 2 / 3),
          itemBuilder: (context, index) {
            var product = mainList[index];
            return InkWell(
              onTap: () {},
              child: Column(
                children: [
                  Container(
                    width: size.width * .5,
                    height: size.height * .25,
                    margin:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0, 4),
                            blurRadius: 4,
                            color: Color.fromARGB(61, 0, 0, 0))
                      ],
                      image: DecorationImage(
                        image: AssetImage(
                          product.imageUrl,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(
                    product.name,
                    style: theme.displayMedium,
                  ),
                  RichText(
                    text: TextSpan(
                        text: '\$',
                        style: theme.displayLarge!.copyWith(
                          color: primaryColor,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: '${product.price}',
                            style: theme.displayLarge!.copyWith(
                              color: Colors.black,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  FadeInUp _buildPopularText(TextTheme theme) {
    return FadeInUp(
      delay: const Duration(milliseconds: 600),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Most popurlar',
              style: theme.displayMedium,
            ),
            Text(
              'See all',
              style: theme.headlineMedium,
            )
          ],
        ),
      ),
    );
  }

  FadeInUp _buildCategory(Size size, TextTheme theme) {
    return FadeInUp(
      delay: const Duration(milliseconds: 400),
      child: Container(
        margin: const EdgeInsets.only(top: 7),
        height: size.height * .14,
        width: size.width,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            var current = categories[index];
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    height: size.height * .07,
                    width: size.height * .07,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(
                            current.imageUrl,
                          ),
                          fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.008,
                  ),
                  Text(
                    current.title,
                    style: theme.displayMedium,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  FadeInUp _buildTopTwoText(TextTheme theme) {
    return FadeInUp(
      delay: const Duration(milliseconds: 300),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                  text: 'Find your',
                  style: theme.displayLarge,
                  children: [
                    TextSpan(
                      text: 'Style',
                      style: theme.displayLarge!.copyWith(
                        color: primaryColor,
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
            ),
            RichText(
              text: const TextSpan(
                  text: 'Be more beatiful with our',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    TextSpan(
                      text: ' Suggestions :))',
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _view(
      int index, TextTheme theme, Size size, PageController pageController) {
    return AnimatedBuilder(
      animation: pageController,
      builder: (context, child) {
        double value = 0.0;
        if (pageController.position.haveDimensions) {
          value = index.toDouble() - (pageController.page ?? 0);
          value = (value * .03).clamp(-1, 1);
        }
        return Transform.rotate(
          angle: 3.14 * value,
          child: _buildCard(size, mainList[index], theme),
        );
      },
    );
  }

  Column _buildCard(Size size, BaseModel product, TextTheme theme) {
    return Column(
      children: [
        Hero(
          tag: product.id,
          child: Container(
            width: size.width * .6,
            height: size.height * .35,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(product.imageUrl),
                fit: BoxFit.cover,
              ),
              boxShadow: const [
                BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 4,
                    color: Color.fromARGB(61, 0, 0, 0))
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            product.name,
            style: theme.displayMedium,
          ),
        ),
        RichText(
          text: TextSpan(
              text: '\$',
              style: theme.displayLarge!.copyWith(
                color: primaryColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: '${product.price}',
                  style: theme.displayLarge!.copyWith(
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]),
        ),
      ],
    );
  }
}
