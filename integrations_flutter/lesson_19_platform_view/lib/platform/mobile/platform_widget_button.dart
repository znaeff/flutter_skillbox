import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class PlatformWidgetButton extends StatelessWidget {
  const PlatformWidgetButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final Widget view;
    // This is used in the platform side to register the view.
    const String viewType = 'INTEGRATION_ANDROID_BUTTON';
    // Pass parameters to the platform side.
    const Map<String, dynamic> creationParams = <String, dynamic>{};

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        view = PlatformViewLink(
          viewType: viewType,
          surfaceFactory:
              (BuildContext context, PlatformViewController controller) {
            return AndroidViewSurface(
              controller: controller as AndroidViewController,
              gestureRecognizers: const <
                  Factory<OneSequenceGestureRecognizer>>{},
              hitTestBehavior: PlatformViewHitTestBehavior.opaque,
            );
          },
          onCreatePlatformView: (PlatformViewCreationParams params) {
            return PlatformViewsService.initSurfaceAndroidView(
              id: params.id,
              viewType: viewType,
              layoutDirection: TextDirection.ltr,
              creationParams: creationParams,
              creationParamsCodec: const StandardMessageCodec(),
              onFocus: () {
                params.onFocusChanged(true);
              },
            )
              ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
              ..create();
          },
        );
        break;
      // case TargetPlatform.iOS:
      // return widget on iOS.
      default:
        //throw UnsupportedError('Unsupported platform view');
        view = Text('$defaultTargetPlatform not supported');
    }
    return SizedBox(
      height: 40,
      width: 200,
      child: view,
    );
  }
}
