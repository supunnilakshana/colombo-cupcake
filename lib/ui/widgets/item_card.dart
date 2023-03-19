import 'package:cackeapp/models/product_model.dart';
import 'package:cackeapp/ui/styles/app_styles.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatefulWidget {
  final ProductModel pmodel;
  const ItemCard({super.key, required this.pmodel});

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 375), vsync: this);
    _animation = Tween(begin: 150.0, end: 260).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
        reverseCurve: Curves.easeOut));

    _controller.addListener(() {
      setState(() {});
    });

    setState(() {
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      //color: Colors.grey[200],
      child: Center(
        child: Container(
          height: 300,
          //width: 150.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 10.0,
                ),
                height: size.height * 0.15,
                width: size.width * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.pmodel.imageurl),
                  ),
                ),
              ),
              Flexible(
                child: AnimatedOpacity(
                  opacity: _animation.value == 260.0 ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
                          child: Text(
                            widget.pmodel.name,
                            style: const TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        'Rs.${widget.pmodel.price.toStringAsFixed(2)}',
                                        style: const TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    // Flexible(
                                    //   child: Row(
                                    //     children: [
                                    //       starIcon(Colors.yellow[700]!),
                                    //       starIcon(Colors.yellow[700]!),
                                    //       starIcon(Colors.yellow[700]!),
                                    //       starIcon(Colors.yellow[700]!),
                                    //       starIcon(Colors.grey[200]!),
                                    //     ],
                                    //   ),
                                    // ),
                                  ],
                                ),
                                Flexible(
                                  child: Container(
                                    height: 60.0,
                                    width: 60.0,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    child: Material(
                                      color: kPrimaryColordark,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ),
                                      child: InkWell(
                                        onTap: () {},
                                        child: const Center(
                                          child: Icon(
                                            Icons.shopping_cart,
                                            size: 25.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Container(
                        //   //margin: const EdgeInsets.only(bottom: 10.0),
                        //   width: size.width * 0.2,

                        //   decoration: BoxDecoration(
                        //     color: kPrimaryColordark,
                        //     borderRadius: BorderRadius.circular(12.0),
                        //     boxShadow: [
                        //       BoxShadow(
                        //         color: Colors.deepOrangeAccent.shade100,
                        //         offset: const Offset(0.0, 10.0),
                        //         spreadRadius: -5.0,
                        //         blurRadius: 10.0,
                        //       ),
                        //     ],
                        //   ),
                        //   child: Material(
                        //     color: Colors.transparent,
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(12.0),
                        //     ),
                        //     child: InkWell(
                        //       onTap: () {},
                        //       child: const Center(
                        //           child: Padding(
                        //         padding: EdgeInsets.all(4.0),
                        //         child: Icon(Icons.shopping_cart),
                        //       )),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Icon starIcon(Color color) {
    return Icon(
      Icons.star,
      size: 10.0,
      color: color,
    );
  }
}
