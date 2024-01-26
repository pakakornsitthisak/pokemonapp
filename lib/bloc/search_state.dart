import 'package:equatable/equatable.dart';

abstract class PaginationEvent extends Equatable {
  const PaginationEvent();

  @override
  List<Object?> get props => [];
}

class LoadPageEvent extends PaginationEvent {
  const LoadPageEvent();
}

class CheckIfNeedMoreDataEvent extends PaginationEvent {
  final int index;
  const CheckIfNeedMoreDataEvent({required this.index});

  @override
  List<Object?> get props => [index];
}
