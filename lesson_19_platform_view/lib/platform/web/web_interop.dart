@JS('ClicksNamespace')
library interop;

import 'dart:ui' as ui;
import 'dart:async';
import 'package:js/js.dart';

@JS('JsInteropEvent')
class _JsInperopEvent {
  external int value;
}

@JS('JsInteropEventType')
class EventType {
  // ignore: non_constant_identifier_names
  external static String get InteropEvent;
}

typedef _ClicksManagerEventListener = void Function(_JsInperopEvent event);

@JS('JsInteropManager')
class _JsInteropManager {
  external dynamic get buttonElement;
  external dynamic get editElement;
  external String getTextFromJs();
  external void setTextToJs(String text);
  external void addEventListener(
      String event, _ClicksManagerEventListener listener);
  external void removeEventListener(
      String event, _ClicksManagerEventListener listener);
}

class _EventListenerProvider {
  final _JsInteropManager _eventTarget;
  final List<StreamController<dynamic>> _controllers = [];

  _EventListenerProvider.forTarget(this._eventTarget);

  Stream<T> forEvent<T extends _JsInperopEvent>(String eventType) {
    late StreamController<T> controller;
    void _onEventReceived(event) {
      controller.add(event as T);
    }

    final _interopted = allowInterop(_onEventReceived);

    controller = StreamController.broadcast(
      onCancel: () => _eventTarget.removeEventListener(eventType, _interopted),
      onListen: () => _eventTarget.addEventListener(eventType, _interopted),
    );

    _controllers.add(controller);
    return controller.stream;
  }

  void dispose() {
    // ignore: avoid_function_literals_in_foreach_calls
    _controllers.forEach((controller) => controller.close());
  }
}

class InteropManager {
  final _interop = _JsInteropManager();

  late Stream<int> _buttonClicked;

  InteropManager() {
    final _streamProvider = _EventListenerProvider.forTarget(_interop);
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'web-button',
      (viewId) => _interop.buttonElement,
    );
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'web-edit',
      (viewId) => _interop.editElement,
    );
    _buttonClicked = _streamProvider
        .forEvent<_JsInperopEvent>('InteropEvent')
        .map((event) => event.value);
  }

  String getTextFromJs() => _interop.getTextFromJs();

  void setTextToJs(String text) => _interop.setTextToJs(text);

  Stream<int> get buttonClicked => _buttonClicked;
}
