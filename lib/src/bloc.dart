import 'composite_subscription.dart';

///
/// The [TremazeBlocEvents] class represents the base class for all events related to a specific
/// TremazeBLoC. This abstract class should be extended by individual event classes
/// to handle specific events related to a particular feature within the application.
///
/// The [dispose] method should be implemented to perform cleanup operations when the event is no longer needed.
///
/// Example:
/// ```dart
/// class FileDownloaderEvents extends TremazeBlocEvents {
///   final _startDownloadEvent = PublishSubject<void>();
///
///   final _encryptFileEvent = PublishSubject<void>();
///
///   final _decryptFileEvent = PublishSubject<void>();
///
///   final _deleteLocalFileEvent = PublishSubject<void>();
///
///   void startDownload() => _startDownloadEvent.add(null);
///
///   void decryptFile() => _decryptFileEvent.add(null);
///
///   void deleteLocalFile() => _deleteLocalFileEvent.add(null);
///
///   @override
///   void dispose() {
///     _startDownloadEvent.close();
///    _encryptFileEvent.close();
///     _decryptFileEvent.close();
///     _deleteLocalFileEvent.close();
///   }
/// }
///
/// ```
abstract class TremazeBlocEvents {

  const TremazeBlocEvents();

  /// Performs cleanup operations for the event.
  void dispose();
}

///
/// The [TremazeBloc] class serves as a base class for all TremazeBLoCs and manages
/// the lifecycle of events and subscriptions.
///
/// This class should be extended by individual BLoCs to manage events and subscriptions
/// related to a specific feature within the application.
///
/// A typical use case involves extending this class and providing a custom implementation
/// of the [TremazeBlocEvents] class for the specific feature.
///
/// The [dispose] method should be called when the BLoC is no longer needed, in order to
/// release resources and cancel any active subscriptions.
abstract class TremazeBloc<Events extends TremazeBlocEvents> {
  bool _isDisposed = false;

  /// Indicates whether the BLoC has been disposed.
  bool get isDisposed => _isDisposed;

  /// The [Events] instance used for managing events related to this BLoC.
  final Events events;

  /// A [CompositeSubscription] instance used to manage multiple subscriptions.
  final CompositeSubscription compositeSubscription;

  /// Constructs a new instance of the [TremazeBloc] class with the given [Events] instance.
  TremazeBloc(this.events, {CompositeSubscription? compositeSubscription})
      : compositeSubscription = compositeSubscription ?? CompositeSubscription();

  /// Performs cleanup operations for the BLoC, such as disposing of the [compositeSubscription].
  void dispose() {
    compositeSubscription.dispose();
    events.dispose();
    _isDisposed = true;
  }
}
