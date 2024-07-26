
import 'package:example_case/bloc/cubit/cubit.dart';
import 'package:example_case/bloc/service/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewPage extends StatefulWidget {
  const ViewPage({super.key});

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<DioCubit>(
      create: (context) => DioCubit(PostService()),
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<DioCubit, DioState>(builder: (context, state) {
            return state.isLoading
                ? const CircularProgressIndicator()
                : const Text("PostsModelsTitles");
          }),
        ),
        body: BlocBuilder<DioCubit, DioState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.items != null && state.items!.isNotEmpty) {
              return ListView.builder(
                itemCount: state.items!.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(state.items?[index].title ?? ""),
                  );
                },
              );
            } else {
              return const Center(child: Text("No items found"));
            }
          },
        ),
        floatingActionButton: BlocBuilder<DioCubit, DioState>(
          builder: (context, state) {
            return FloatingActionButton(
              onPressed: () {
                context.read<DioCubit>().fetchItems();
              },
              child: const Icon(Icons.refresh),
            );
          },
        ),
      ),
    );
  }
}
