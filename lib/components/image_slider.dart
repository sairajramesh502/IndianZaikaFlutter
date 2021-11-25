import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:indian_zaika/constants/constants.dart';
import 'package:shimmer/shimmer.dart';

class BannerSlider extends StatefulWidget {
  const BannerSlider({Key? key}) : super(key: key);

  @override
  _BannerSliderState createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  int _dataLength = 1;

  @override
  void initState() {
    getSliderImageFromDb();
    super.initState();
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getSliderImageFromDb() async {
    var _fireStore = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _fireStore.collection('Slider').get();
    if (mounted) {
      setState(() {
        _dataLength = snapshot.docs.length;
      });
    }
    return snapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width / 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: kCardBackColor,
        ),
        child: Column(
          children: [
            if (_dataLength != 0)
              FutureBuilder(
                future: getSliderImageFromDb(),
                builder: (_,
                    AsyncSnapshot<
                            List<QueryDocumentSnapshot<Map<String, dynamic>>>>
                        snapShot) {
                  return snapShot.data == null
                      ? Shimmer.fromColors(
                          baseColor: kCardBackColor,
                          highlightColor: kShimmerHighlight,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.width / 2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: kCardBackColor,
                            ),
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: CarouselSlider.builder(
                              itemCount: snapShot.data!.length,
                              itemBuilder: (BuildContext context, index, _) {
                                DocumentSnapshot<Map<String, dynamic>>
                                    sliderImage = snapShot.data![index];
                                Map<String, dynamic>? getImage =
                                    sliderImage.data();
                                return SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Image.network(
                                      getImage!['image'],
                                      fit: BoxFit.fill,
                                    ));
                              },
                              options: CarouselOptions(
                                  viewportFraction: 1,
                                  initialPage: 0,
                                  autoPlay: true,
                                  height: MediaQuery.of(context).size.width / 2,
                                  onPageChanged:
                                      (int i, carouselPageChangedReason) {
                                    setState(() {});
                                  })),
                        );
                },
              ),
          ],
        ),
      ),
    );
  }
}
