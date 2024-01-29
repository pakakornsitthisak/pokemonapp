import 'package:equatable/equatable.dart';

abstract class SearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends SearchState {}

class LoadedState extends SearchState {}

class LoadingState extends SearchState {}

class ErrorState extends SearchState {}
