

import 'package:equatable/equatable.dart';
import 'package:example_case/bloc/model/post_model.dart';
import 'package:example_case/bloc/service/service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class DioCubit extends Cubit<DioState> {
  final PostService postService;
  DioCubit(this.postService) : super(const DioState());

  Future<void> fetchItems() async {
    emit(const DioState(isLoading: true));
    final items= await postService.fetchItems();
    emit(DioState(isLoading: false,items: items));
    
  }
}

class DioState extends Equatable {
  final bool isLoading;
  final List<PostModel>? items;

  const DioState({this.isLoading = false, this.items});

  @override
  List<Object?> get props => [isLoading, items];
}
