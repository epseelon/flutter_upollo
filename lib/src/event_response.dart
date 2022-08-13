class EventResponse {
  /// A token which can be sent to your own server so it can dig into the
  /// assessment of a user following events being reported for tracking by
  /// your client application.
  final String eventToken;

  //reserved "validation_signature";

  EventResponse({
    required this.eventToken,
  });

  static EventResponse? fromJson(dynamic json) {
    if (json == null) {
      return null;
    }
    return EventResponse(
      eventToken: json['eventToken'],
    );
  }

  @override
  String toString() {
    return 'EventResponse{eventToken: $eventToken}';
  }
}
