import 'dart:async';

class CompositeSubscription implements StreamSubscription<Never> {
  final List<StreamSubscription<dynamic>> _subscriptionsList = [];

  void add(StreamSubscription<dynamic> subscription) {
    _subscriptionsList.add(subscription);
  }

  void dispose() {
    for (var subscription in _subscriptionsList) {
      subscription.cancel();
    }
    _subscriptionsList.clear();
  }

  @override
  Future<E> asFuture<E>([E? futureValue]) {
    throw UnimplementedError();
  }

  @override
  Future<void> cancel() {
    throw UnimplementedError();
  }

  @override
  bool get isPaused => throw UnimplementedError();

  @override
  void onData(void Function(Never data)? handleData) {
    throw UnimplementedError();
  }

  @override
  void onDone(void Function()? handleDone) {
    throw UnimplementedError();
  }

  @override
  void onError(Function? handleError) {
    throw UnimplementedError();
  }

  @override
  void pause([Future<void>? resumeSignal]) {
    throw UnimplementedError();
  }

  @override
  void resume() {
    throw UnimplementedError();
  }
}

extension DisposedByExt<T> on StreamSubscription<T> {
  void disposedBy(CompositeSubscription compositeSubscription) {
    compositeSubscription._subscriptionsList.add(this);
    return;
  }
}
