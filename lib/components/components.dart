import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:softag/components/consts.dart';
import 'package:softag/screens/main_screen/cubit/cubit.dart';
import 'package:softag/screens/main_screen/models/category.dart';
import 'package:softag/screens/main_screen/models/favorite_model.dart';
import 'package:softag/screens/main_screen/models/product.dart';
import 'package:softag/size_config.dart';

Widget titleScreen({
  required String title,
}) =>
    Text(
      title,
      style: TextStyle(
        fontSize: SizeConfig.scaleTextFont(30),
      ),
    );

Widget desScreen({
  required String des,
}) =>
    Text(
      des,
      style: TextStyle(
        fontSize: SizeConfig.scaleTextFont(14),
        color: Colors.grey,
      ),
    );

Widget defaultFromField({
  required TextEditingController controller,
  bool obscureText = false,
  TextInputType keyboard = TextInputType.text,
  required String validatorString,
  required String label,
  required IconData prefix,
  var function,
  IconData suffix = Icons.visibility,
  bool needSuffix = false,
}) =>
    SizedBox(
      height: SizeConfig.scaleHeight(56),
      width: SizeConfig.scaleWidth(307),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboard,
        validator: (value) {
          if (value!.isEmpty) {
            return validatorString;
          }
          return null;
        },
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(23),
            borderSide: BorderSide(
              color: Color.fromRGBO(242, 242, 242, 1),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(23),
            borderSide: BorderSide(
              color: Color.fromRGBO(242, 242, 242, 1),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(23),
          ),
          filled: true,
          prefixIcon: Icon(
            prefix,
            color: Colors.black54,
          ),
          suffixIcon: needSuffix
              ? IconButton(
                  onPressed: function,
                  icon: Icon(
                    suffix,
                    color: Colors.black54,
                  ),
                )
              : SizedBox(),
          hintText: label,
          hintStyle: TextStyle(
            fontSize: SizeConfig.scaleTextFont(14),
            color: Color.fromRGBO(182, 183, 183, 1),
          ),
          labelText: label,
          labelStyle: TextStyle(
            fontSize: SizeConfig.scaleTextFont(16),
            color: Colors.black54,
          ),
          fillColor: Color.fromRGBO(242, 242, 242, 1),
        ),
      ),
    );

Widget defaultButton(
  BuildContext context, {
  required String title,
  required VoidCallback function,
  required RoundedLoadingButtonController controller,
}) =>
    SizedBox(
      height: SizeConfig.scaleHeight(56),
      width: SizeConfig.scaleWidth(307),
      child: RoundedLoadingButton(
        controller: controller,
        onPressed: function,
        child: Text(title),
        height: SizeConfig.scaleHeight(51),
        width: MediaQuery.of(context).size.width,
        color: defaultColor,
        elevation: 5,
      ),
    );

Widget defaultRichText({
  required String startTitle,
  required String endTitle,
  required VoidCallback function,
}) =>
    RichText(
      text: TextSpan(
          style: TextStyle(
            fontSize: SizeConfig.scaleTextFont(14),
            color: greyColor,
          ),
          text: startTitle,
          children: [
            TextSpan(
                recognizer: TapGestureRecognizer()..onTap = function,
                text: endTitle,
                style: TextStyle(
                  color: defaultColor,
                )),
          ]),
    );

Widget bottomBarItem({
  required String title,
  required IconData icon,
  required int index,
  required int currentIndex,
  required PageController pageController,
}) =>
    Padding(
      padding: EdgeInsetsDirectional.only(
          top: SizeConfig.scaleHeight(30), bottom: SizeConfig.scaleHeight(27)),
      child: InkWell(
        onTap: () {
          pageController.jumpToPage(index);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: index == currentIndex ? defaultColor : greyColor,
              size: SizeConfig.scaleHeight(20),
            ),
            Text(
              title,
              style: TextStyle(
                color: index == currentIndex ? defaultColor : greyColor,
                fontSize: SizeConfig.scaleTextFont(12),
              ),
            ),
          ],
        ),
      ),
    );

Widget categoryHomeItem(CategoryData data) => Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        SizedBox(
          width: SizeConfig.scaleWidth(100),
          height: SizeConfig.scaleHeight(100),
          child: Image.network(
            data.image!,
            width: SizeConfig.scaleWidth(100),
            height: SizeConfig.scaleHeight(100),
            fit: BoxFit.cover,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
          ),
        ),
        Container(
          padding: EdgeInsets.all(SizeConfig.scaleHeight(3)),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(.7),
              borderRadius: BorderRadius.circular(7)),
          child: Text(
            '${data.name}',
            style: TextStyle(
              fontSize: SizeConfig.scaleTextFont(14),
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: SizeConfig.scaleWidth(1.3),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );

Widget productHomeItem(ProductsData productsData, BuildContext context) =>
    Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: SizeConfig.scaleHeight(10),
          ),
          Center(
            child: SizedBox(
              height: SizeConfig.scaleHeight(150),
              width: SizeConfig.scaleWidth(150),
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image.network(
                    '${productsData.image}',
                    height: SizeConfig.scaleHeight(150),
                    width: SizeConfig.scaleWidth(150),
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  ),
                  if (productsData.discount != 0)
                    Container(
                      padding: EdgeInsets.all(SizeConfig.scaleHeight(3)),
                      margin: EdgeInsets.all(SizeConfig.scaleHeight(3)),
                      child: Text(
                        'Discount',
                        style: TextStyle(
                          fontSize: SizeConfig.scaleTextFont(14),
                          color: Colors.white,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(.85),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.scaleHeight(15),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.scaleWidth(3)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${productsData.name}',
                  style: TextStyle(
                    fontSize: SizeConfig.scaleTextFont(16),
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Row(
                  children: [
                    Text(
                      'Price : ${productsData.price}\$',
                      style: TextStyle(
                          fontSize: SizeConfig.scaleTextFont(12),
                          color: defaultColor),
                    ),
                    SizedBox(
                      width: SizeConfig.scaleWidth(5),
                    ),
                    if (productsData.discount != 0)
                      Text(
                        '${productsData.oldPrice}',
                        style: TextStyle(
                          fontSize: SizeConfig.scaleTextFont(10),
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                        ),
                      ),
                    Spacer(),
                    IconButton(
                        icon: Icon(
                          MainCubit().get(context).favorite[productsData.id!] ??
                                  true
                              ? Icons.favorite
                              : Icons.favorite_border,
                          size: SizeConfig.scaleHeight(14),
                          color: MainCubit()
                                      .get(context)
                                      .favorite[productsData.id!] ??
                                  true
                              ? Colors.red
                              : Colors.black,
                        ),
                        onPressed: () {
                          MainCubit()
                              .get(context)
                              .changeFavorite(productsData.id!);
                        }),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

Widget productItemScreen(ProductsData productsData) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${productsData.name}',
          style: TextStyle(
            fontSize: SizeConfig.scaleTextFont(18),
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.start,
        ),
        SizedBox(
          height: SizeConfig.scaleHeight(15),
        ),
        SizedBox(
          height: SizeConfig.scaleHeight(150),
          width: double.infinity,
          child: Image.network(
            '${productsData.image}',
            height: SizeConfig.scaleHeight(150),
            width: double.infinity,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: SizeConfig.scaleHeight(15),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${productsData.price}\$',
              style: TextStyle(
                fontSize: SizeConfig.scaleTextFont(15),
                fontWeight: FontWeight.bold,
                color: defaultColor,
              ),
            ),
            SizedBox(
              height: SizeConfig.scaleHeight(30),
              width: SizeConfig.scaleWidth(130),
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Shop Now',
                  style: TextStyle(
                    fontSize: SizeConfig.scaleTextFont(20),
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  primary: Colors.blueAccent,
                ),
              ),
            ),
          ],
        ),
        Divider(),
      ],
    );

Widget categoryScreenItem(CategoryData categoryData) => Padding(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.scaleWidth(10),
          vertical: SizeConfig.scaleHeight(15)),
      child: ListTile(
        title: Text(
          '${categoryData.name}',
          style: TextStyle(
            fontSize: SizeConfig.scaleTextFont(16),
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: SizedBox(
          height: SizeConfig.scaleHeight(200),
          width: SizeConfig.scaleWidth(80),
          child: Image.network(
            '${categoryData.image}',
            height: SizeConfig.scaleHeight(200),
            width: SizeConfig.scaleWidth(80),
            fit: BoxFit.contain,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: SizeConfig.scaleHeight(14),
        ),
      ),
    );

Widget favoriteItem(DataModel dataModel,context) => Container(
  color: Colors.white,
  child: Padding(
    padding:  EdgeInsets.all(SizeConfig.scaleHeight(20)),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Center(
          child: SizedBox(
            height: SizeConfig.scaleHeight(150),
            width: SizeConfig.scaleWidth(150),
            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image.network(
                  '${dataModel.product!.image}',
                  height: SizeConfig.scaleHeight(150),
                  width: SizeConfig.scaleWidth(150),
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
                if (dataModel.product!.discount != 0)
                  Container(
                    padding: EdgeInsets.all(SizeConfig.scaleHeight(3)),
                    margin: EdgeInsets.all(SizeConfig.scaleHeight(3)),
                    child: Text(
                      'Discount',
                      style: TextStyle(
                        fontSize: SizeConfig.scaleTextFont(14),
                        color: Colors.white,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(.85),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
              ],
            ),
          ),
        ),


        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${dataModel.product!.name}',
                style: TextStyle(
                  fontSize: SizeConfig.scaleTextFont(16),
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              SizedBox(height: SizeConfig.scaleHeight(60),),
              Row(
                children: [
                  Text(
                    'Price : ${dataModel.product!.price}\$',
                    style: TextStyle(
                        fontSize: SizeConfig.scaleTextFont(12),
                        color: defaultColor),
                  ),
                  SizedBox(
                    width: SizeConfig.scaleWidth(5),
                  ),
                  if (dataModel.product!.discount != 0)
                    Text(
                      '${dataModel.product!.oldPrice}',
                      style: TextStyle(
                        fontSize: SizeConfig.scaleTextFont(10),
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey,
                      ),
                    ),
                  Spacer(),
                  IconButton(
                      icon: Icon(
                        MainCubit().get(context).favorite[dataModel.product!.id!] ??
                            true
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: SizeConfig.scaleHeight(14),
                        color: MainCubit()
                            .get(context)
                            .favorite[dataModel.product!.id!] ??
                            true
                            ? Colors.red
                            : Colors.black,
                      ),
                      onPressed: () {
                        MainCubit()
                            .get(context)
                            .changeFavorite(dataModel.product!.id!);
                      }),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);
