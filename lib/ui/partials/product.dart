import 'package:flutter/material.dart';
import 'package:readerscorner/models/Product.dart';
import 'package:readerscorner/scoped-models/main_model.dart';
import 'package:readerscorner/ui/screens/product.dart';
import 'package:readerscorner/ui/widgets/rating_bar.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shadow/shadow.dart';

Widget productPartial(Product product, Size _deviceSize, BuildContext context) {
  return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
    _deviceSize = MediaQuery.of(context).size;

    var iconButton = product.order_limit > 0
        ? IconButton(
            onPressed: () {
              final Map<String, dynamic> _data = {
                "product": product.id,
                "qunatinty": "1"
              };
              model.addToCart(_data, context);
            },
            icon: Icon(Icons.shopping_cart, color: Colors.grey))
        : IconButton(
            onPressed: () {
              model.showFlushBar(context, "Sorry!this item is not avilable");
            },
            icon: Icon(Icons.shopping_cart, color: Colors.grey));
    var sizedBox = SizedBox(
        width: _deviceSize.width * 0.4,
        child: Card(
          elevation: 2.0,
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10.0,
                      offset: Offset(0.0, 10.0))
                ]),
                margin: EdgeInsets.all(15),
                child: FadeInImage(
                  image: NetworkImage(product.image),
                  placeholder: AssetImage('images/no-product-image.png'),
                  height: 152,
                ),
              ),
              Container(color: Colors.white, padding: EdgeInsets.only(top: 10)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: Container(
                  color: Colors.white,
                  width: double.infinity,
                  height: 40,
                  child: Text(
                    product.name,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 12.0,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            product.avg_rate != null
                                ? ratingBar(0)
                                : ratingBar(0),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: Container(
                  color: Colors.white,
                  width: double.infinity,
                  height: 20,
                  child: product.author_name != null
                      ? RichText(
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          text: TextSpan(
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black87),
                              text: 'By : ${product.author_name.trim()}'),
                        )
                      : Text(''),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: Container(
                  color: Colors.white,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'EGP${product.price}0',
                          // 'EGP${product.price}',
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                        iconButton
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
    return GestureDetector(
        onTap: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              fullscreenDialog: false,
              builder: (BuildContext context) => ProductScreen(
                curProduct: product,
              ),
            ),
          );
        },
        child: sizedBox);
  });
}
