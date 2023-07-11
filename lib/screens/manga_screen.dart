import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../constants.dart';
import '../models/manga_model.dart';

import '../api/dio_services.dart';
import '../widgets/anime_card_widget/anime_card_widget.dart';

class MangaScreen extends StatelessWidget {
  const MangaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPaleLavender,
      body: FutureBuilder<List<MangaModel>>(
        future: APIService().fetchTopManga(kMangas),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            final mangas = snapshot.data!;
            return GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: 250,
              ),
              itemCount: mangas.length,
              itemBuilder: (context, index) {
                final anime = mangas[index];
                return Container(
                  margin: EdgeInsets.symmetric(
                    vertical: kDefaultPadding,
                    horizontal: kDefaultPadding - 5,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 100.w,
                        height: 140.h,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(kBorderRadius),
                          child: Image.network(
                            anime.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        mangas[index].title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: kSecondaryColor,
                          fontSize: kBigText,
                          fontFamily: kDefaultFont,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Score: ',
                            style: TextStyle(
                              color: kSecondaryColor,
                              fontSize: 12,
                              fontFamily: kDefaultFont,
                            ),
                          ),
                          Container(
                            height: 17,
                            width: 40,
                            decoration: const BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.elliptical(100, 100),
                                right: Radius.elliptical(100, 100),
                              ),
                            ),
                            padding: EdgeInsets.zero, // Remove all padding
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                '${mangas[index].score}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: kDefaultPadding,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: kDefaultFont,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Failed to fetch manga data'),
            );
          }
          return const Center(
            child: Text('No data available'),
          );
        },
      ),
    );
  }
}
