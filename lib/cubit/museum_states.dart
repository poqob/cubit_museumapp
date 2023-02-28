//states are written here.

import 'package:flutter/foundation.dart';
import 'package:museum_app/data/models/museum.dart';

abstract class MuseumStates {
  const MuseumStates();
}

class MuseumInitial extends MuseumStates {
  const MuseumInitial();
}

class MuseumLoading extends MuseumStates {
  const MuseumLoading();
}

class MuseumLoaded extends MuseumStates {
  final List<Museum> museums;
  const MuseumLoaded(this.museums);

  //overriding equality operators
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MuseumLoaded && listEquals(other.museums, museums);
  }

  //overriding hashCode
  @override
  int get hashCode => museums.hashCode;
}

class MuseumsError extends MuseumStates {
  final String message;

  const MuseumsError(this.message);
}
