import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shop_ui/coponents/reusable_able_cart_for_row.dart';
import 'package:shop_ui/coponents/reusable_btn.dart';
import 'package:shop_ui/coponents/reusable_text.dart';
import 'package:shop_ui/data/app_data.dart';
import 'package:shop_ui/utils/constants.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  // calculate total
  double calculateSubTotal() {
    double total = 0;
    if (itemOnCart.isEmpty) {
      total = 0;
    } else {
      for (var item in itemOnCart) {
        total = total + item.price.toDouble() * item.value;
      }
    }
    return total;
  }

  // calculate shipping
  double calculateShipping() {
    double total = 0.0;
    if (calculateSubTotal() < 2000 && calculateSubTotal() >= 1000) {
      total = 10;
    } else if (calculateSubTotal() < 1000) {
      total = 25;
    } else {
      total = 0;
    }
    return total;
  }

  // calculate total
  double calculateTotal() {
    return calculateShipping() + calculateSubTotal();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _buildAppbar(textTheme, context),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            SizedBox(
              width: size.width,
              height: size.height * .6,
              child: itemOnCart.isNotEmpty
                  ? ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: itemOnCart.length,
                      itemBuilder: (context, index) {
                        var current = itemOnCart[index];
                        return Container(
                          margin: const EdgeInsets.all(5),
                          height: size.height * .25,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // image content
                              Container(
                                margin: const EdgeInsets.all(5),
                                height: size.height,
                                width: size.width * .4,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(current.imageUrl),
                                        fit: BoxFit.cover),
                                    color: Colors.black26,
                                    boxShadow: const [
                                      BoxShadow(
                                        offset: Offset(0, 4),
                                        blurRadius: 4,
                                        color: Colors.black38,
                                      )
                                    ]),
                              ),
                              // info content
                              Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: size.width * .5,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            current.name,
                                            style: textTheme.displayMedium,
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (index <
                                                      itemOnCart.length) {
                                                    itemOnCart.removeAt(index);
                                                  } else {
                                                    return;
                                                  }
                                                });
                                              },
                                              icon: const Icon(Icons.close))
                                        ],
                                      ),
                                    ),
                                    ReuseableText(price: current.price),
                                    SizedBox(
                                      height: size.height * .04,
                                    ),
                                    Text(
                                      'Size: ${sizes[3]}',
                                      style: textTheme.displaySmall,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: size.height * .058),
                                      height: size.height * .04,
                                      width: size.width * .4,
                                      child: Row(
                                        children: [
                                          _myBtn(size, () {
                                            setState(() {
                                              print('is Active');
                                              current.value >= 0
                                                  ? current.value++
                                                  : null;
                                            });
                                          }, Icons.add),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Text(
                                              current.value.toString(),
                                              style: TextStyle(fontSize: 20.sp),
                                            ),
                                          ),
                                          _myBtn(size, () {
                                            setState(() {
                                              current.value > 1
                                                  ? current.value--
                                                  : null;
                                            });
                                          }, Icons.remove),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/empty.png',
                          fit: BoxFit.cover,
                        ),
                        Text(
                          'No item added yet!!',
                          style: textTheme.displayLarge,
                        )
                      ],
                    ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: size.width,
                height: size.height * .36,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 10,
                  ),
                  child: Column(
                    children: [
                      FadeInUp(
                        delay: const Duration(milliseconds: 300),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Promo/student code or voucher',
                              style: textTheme.displayMedium,
                            ),
                            const Icon(Icons.arrow_forward_ios)
                          ],
                        ),
                      ),
                      FadeInUp(
                        delay: const Duration(milliseconds: 400),
                        child: ReusableAbleCartForRow(
                            text: 'Sub total', price: calculateSubTotal()),
                      ),
                      FadeInUp(
                          delay: const Duration(milliseconds: 500),
                          child: ReusableAbleCartForRow(
                              text: 'Shipping', price: calculateShipping())),
                      const Divider(),
                      FadeInUp(
                          delay: const Duration(milliseconds: 600),
                          child: ReusableAbleCartForRow(
                              text: 'Total', price: calculateTotal())),
                      const Spacer(),
                      FadeInUp(
                        delay: const Duration(milliseconds: 700),
                        child: ReuseableButton(
                            text: 'Checkout',
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => Cart(),
                              ));
                            }),
                      ),
                      SizedBox(height: size.height * .004),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _myBtn(Size size, VoidCallback onTap, IconData icon) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size.height * .05,
        width: size.width * .1,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  AppBar _buildAppbar(TextTheme textTheme, BuildContext context) {
    return AppBar(
      title: Text(
        'My cart',
        style: textTheme.displayMedium,
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(
          Icons.arrow_back_rounded,
          color: Colors.black,
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              LineIcons.user,
              color: Colors.black,
            ))
      ],
    );
  }
}
