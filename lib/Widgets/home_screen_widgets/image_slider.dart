import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:wadi_shop/constants.dart';
import 'package:wadi_shop/data/image_slider_data.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({super.key});

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  final _imageCorntroller = CarouselController();
  var currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {},
          child: CarouselSlider(
            carouselController: _imageCorntroller,
            items: imagesForSlider
                .map((image) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        image,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ))
                .toList(),
            options: CarouselOptions(
              scrollPhysics: const BouncingScrollPhysics(),
              autoPlay: true,
              aspectRatio: 2.4,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
          ),
        ),
        Positioned(
            bottom: 10,
            right: 0,
            left: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...imagesForSlider
                    .asMap()
                    .entries
                    .map((entry) => GestureDetector(
                          onTap: () =>
                              _imageCorntroller.animateToPage(entry.key),
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            height: 10,
                            width: currentIndex == entry.key ? 18 : 10,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: currentIndex == entry.key
                                    ? kprimaryColor
                                    : Colors.white),
                          ),
                        ))
                    .toList(),
              ],
            ))
      ],
    );
  }
}
