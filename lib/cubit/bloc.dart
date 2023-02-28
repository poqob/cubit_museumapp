// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:museum_app/cubit/museum_states.dart';
import 'package:museum_app/data/api/museum_api.dart';
import 'package:museum_app/data/models/museum.dart';

//methods are written here according to MuseumStates.

class MuseumCubits extends Cubit<MuseumStates> {
  MuseumCubits() : super(const MuseumInitial());

  Future<void> getMuseums() async {
    try {
      emit(const MuseumLoading());

      Db db = Db();

      //museums that will be listed here.
      List<Museum> museums = <Museum>[];

      //connection to db
      await db.conn();

      //get all museum results from database
      await db.museumsResult.then((value) {
        for (var element in value) {
          museums.add(Museum(element[0], element[1], element[2]));
        }
      });

      await db.connKill();

      emit(MuseumLoaded(museums));
    } catch (e) {
      emit(MuseumsError(e.toString()));
    }
  }
}
