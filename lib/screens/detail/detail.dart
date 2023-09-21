import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_ui/coponents/reusable_btn.dart';
import 'package:shop_ui/coponents/reusable_text.dart';
import 'package:shop_ui/data/app_data.dart';
import 'package:shop_ui/models/base_model.dart';
import 'package:shop_ui/utils/constants.dart';

class Detail extends StatefulWidget {
  const Detail({super.key, required this.baseModel});

  final BaseModel baseModel;

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  int selectedSize = 3;
  int selectedColor = 1;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppbar(context),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // top image
            _buildTopImage(size),
            // info content
            _buildInfoContent(size, theme),
            // select size
            _reusableText(theme, 'Select size'),
            //  sizes
            _buildSize(size),
            // select color
            _reusableText(theme, 'Select color'),
            // color
            _buildColor(size),
            // add to cart btn
            const Spacer(),
            _buildBtn(widget.baseModel),
          ],
        ),
      ),
    );
  }

  FadeInUp _reusableText(TextTheme theme, String text) {
    return FadeInUp(
      delay: const Duration(milliseconds: 400),
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
        child: Text(
          text,
          style: theme.displaySmall,
        ),
      ),
    );
  }

  FadeInUp _buildBtn(BaseModel data) {
    return FadeInUp(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 20),
        child: ReuseableButton(
            text: 'Add to cart',
            onTap: () {
              // AddToCart.addToCart(context, data);
              if (itemOnCart.contains(data)) {
                showText('san pham da ton tai', context);
                print('item da ton tai trong gio hang');
              } else {
                itemOnCart.add(data);
                showText('da them san pham vao gio hang', context);
                print('them vao gio hang thanh cong');
              }
            }),
      ),
    );
  }

  FadeInUp _buildColor(Size size) {
    return FadeInUp(
      delay: const Duration(milliseconds: 700),
      child: SizedBox(
        width: size.width,
        height: size.height * .08,
        child: ListView.builder(
          itemCount: colors.length,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            var current = colors[index];
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedColor = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: size.width * .12,
                  decoration: BoxDecoration(
                    color: current,
                    border: Border.all(
                      color: selectedColor == index
                          ? primaryColor
                          : Colors.transparent,
                      width: selectedColor == index ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  FadeInUp _buildSize(Size size) {
    return FadeInUp(
      delay: const Duration(milliseconds: 500),
      child: SizedBox(
        width: size.width * .9,
        height: size.height * .08,
        child: ListView.builder(
          itemCount: sizes.length,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            var current = sizes[index];
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedSize = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: size.width * .12,
                  decoration: BoxDecoration(
                    color: selectedSize == index
                        ? primaryColor
                        : Colors.transparent,
                    border: Border.all(color: primaryColor, width: 2),
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Center(
                    child: Text(
                      current,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color:
                            selectedSize == index ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  FadeInUp _buildInfoContent(Size size, TextTheme theme) {
    return FadeInUp(
      delay: const Duration(milliseconds: 300),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: size.width,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.baseModel.name,
                    style: theme.displaySmall,
                  ),
                  ReuseableText(
                    price: widget.baseModel.price,
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.006,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.orange,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(widget.baseModel.star.toString(),
                      style: theme.headlineSmall),
                  const SizedBox(
                    width: 8,
                  ),
                  Text("(${widget.baseModel.review.toString()}K+ review)",
                      style: theme.headlineSmall?.copyWith(color: Colors.grey)),
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: Colors.grey,
                    size: 15,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _buildTopImage(Size size) {
    return SizedBox(
      height: size.height * .5,
      width: size.width,
      child: Stack(
        children: [
          Hero(
            tag: widget.baseModel.id,
            child: Container(
              width: size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(widget.baseModel.imageUrl),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              child: Container(
                height: size.height * 0.1,
                width: size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: gradient,
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ))
        ],
      ),
    );
  }

  AppBar _buildAppbar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back_ios),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.favorite_border,
          ),
        ),
      ],
    );
  }
}

showText(String text, BuildContext context) {
  ScaffoldMessenger.of(context).clearSnackBars();
  return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(duration: const Duration(seconds: 2), content: Text(text)));
}
