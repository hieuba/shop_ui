import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shop_ui/data/app_data.dart';
import 'package:shop_ui/utils/constants.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  // search func
  onSearchFunc(String searh) {
    setState(() {
      itemOnSearch = mainList
          .where((element) => element.name.toLowerCase().contains(searh))
          .toList();
    });
  }

  @override
  void initState() {
    itemOnSearch = mainList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              // textfield
              buildSearchBar(size, textTheme),
              const SizedBox(height: 20),
              // gridview content
              Expanded(
                child: itemOnSearch.isNotEmpty
                    ? buildSearchContent(size, textTheme)
                    : buildSearchIsEmpty(textTheme),
              ),
            ],
          ),
        ),
      ),
    );
  }

  GridView buildSearchContent(Size size, TextTheme textTheme) {
    return GridView.builder(
      itemCount: itemOnSearch.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 2 / 3),
      itemBuilder: (context, index) {
        var product = itemOnSearch[index];
        return InkWell(
          onTap: () {},
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: size.height * .02,
                left: size.width * .01,
                right: size.width * .01,
                child: Container(
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
              ),
              Positioned(
                bottom: size.height * .04,
                child: Text(
                  product.name,
                  style: textTheme.displayMedium,
                ),
              ),
              Positioned(
                bottom: size.height * .01,
                child: RichText(
                  text: TextSpan(
                    text: '\$',
                    style: textTheme.displayLarge!.copyWith(
                      color: primaryColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: '${product.price}',
                        style: textTheme.displayLarge!.copyWith(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: CircleAvatar(
                  backgroundColor: primaryColor,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(LineIcons.addToShoppingCart),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  FadeInUp buildSearchIsEmpty(TextTheme textTheme) {
    return FadeInUp(
      delay: const Duration(milliseconds: 200),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('assets/images/search_fail.png'),
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Text(
              'No result found !!!',
              style: textTheme.displayLarge,
            )
          ],
        ),
      ),
    );
  }

  FadeInUp buildSearchBar(Size size, TextTheme textTheme) {
    return FadeInUp(
      delay: const Duration(milliseconds: 50),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: SizedBox(
          width: size.width,
          height: size.height * .07,
          child: TextField(
            controller: _textController,
            onChanged: (value) {
              onSearchFunc(value);
            },
            style: textTheme.displaySmall,
            decoration: InputDecoration(
              hintText: 'e.g Jean...',
              hintStyle: textTheme.displaySmall!.copyWith(
                color: Colors.grey,
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 20,
              ),
              filled: true,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _textController.clear();
                    FocusManager.instance.primaryFocus!.unfocus();
                  });
                },
                icon: const Icon(
                  Icons.clear,
                ),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(13),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
