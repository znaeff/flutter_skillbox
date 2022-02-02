import 'package:flutter/material.dart';

class PersonCard extends Card {
  final BuildContext context;
  final String firstname;
  final String lastname;
  final String email;
  final String photo;

  static const double myRadius = 5.0;
  static const double myElevation = 4.0;
  static const double myPadding = 10.0;
  static const double myPhotoSizeBig = 100.0;
  static const double myPhotoSizeSmall = 50.0;
  static const String noPhoto = "No photo";

  PersonCard.vertical(
      {Key? key,
      required this.context,
      required this.firstname,
      required this.lastname,
      required this.email,
      required this.photo})
      : super(
          key: key,
          elevation: myElevation,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(myRadius))),
          child: Padding(
            padding: const EdgeInsets.all(myPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(myPadding),
                  child: SizedBox(
                    height: myPhotoSizeBig,
                    width: myPhotoSizeBig,
                    child: Image.asset(
                      'assets/$photo',
                      height: myPhotoSizeBig,
                      width: myPhotoSizeBig,
                      fit: BoxFit.fitHeight,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return const Center(child: Text(noPhoto));
                      },
                    ),
                  ),
                ),
                Text(firstname + ' ' + lastname),
                Text(email),
              ],
            ),
          ),
        );

  PersonCard.hosizontal(
      {Key? key,
      required this.context,
      required this.firstname,
      required this.lastname,
      required this.email,
      required this.photo})
      : super(
          key: key,
          //color: Colors.black12,
          elevation: myElevation,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(myRadius))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(myPadding),
                child: SizedBox(
                  height: myPhotoSizeSmall,
                  width: myPhotoSizeSmall,
                  child: Image.asset(
                    'assets/$photo',
                    height: myPhotoSizeSmall,
                    width: myPhotoSizeSmall,
                    fit: BoxFit.fitHeight,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return const Center(child: Text(noPhoto));
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: myPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(firstname + ' ' + lastname),
                    Text(email),
                  ],
                ),
              ),
            ],
          ),
        );
}
