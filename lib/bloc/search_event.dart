import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

class LoadedPageEvent extends SearchEvent {}

class CheckIfNeedMoreDataEvent extends SearchEvent {
  final int index;
  const CheckIfNeedMoreDataEvent({required this.index});

  @override
  List<Object?> get props => [index];
}
