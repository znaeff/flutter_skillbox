import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';

typedef NativeStringLen = Int8 Function(Pointer<Utf8>);
typedef FFIStringLen = int Function(Pointer<Utf8>);

class FFIBridge {
  late FFIStringLen _getCSize;
  FFIBridge() {
    final DynamicLibrary dl = Platform.isAndroid
        ? DynamicLibrary.open('libsimple.so')
        : DynamicLibrary.process();
    _getCSize = dl.lookupFunction<NativeStringLen, FFIStringLen>('string_len');
  }

  int getCSize(String text) {
    Pointer<Utf8> charPointer = text.toNativeUtf8();
    return (_getCSize(charPointer));
  }
}
