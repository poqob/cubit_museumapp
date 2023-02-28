import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:museum_app/cubit/bloc.dart';
import 'package:museum_app/cubit/museum_states.dart';

class BlocMuseumsView extends StatelessWidget {
  const BlocMuseumsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MuseumCubits(),
      child: buildScaffold(),
    );
  }

  Scaffold buildScaffold() => Scaffold(
        appBar: AppBar(
          title: const Text('Museums'),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.replay))
          ],
        ),
        body: BlocConsumer<MuseumCubits, MuseumStates>(
          listener: (context, state) {
            //it can be empty.
            //works after every state changes.
            //Scaffold.of(context).showBottomSheet((context) => Text(state.toString()));
          },
          builder: (BuildContext context, state) {
            if (state is MuseumInitial) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //const Text("hello"),
                  MaterialButton(
                    onPressed: () {
                      context.read<MuseumCubits>().getMuseums();
                    },
                    color: Colors.red,
                  )
                ],
              );
            } else if (state is MuseumLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MuseumLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) => Image.network(
                    state.museums[index].img), //Text(state.museums[index].img),
                itemCount: state.museums.length,
              );
            } else {
              MuseumsError error = state as MuseumsError;
              return Text(error.message);
            }
          },
        ),
      );
}
