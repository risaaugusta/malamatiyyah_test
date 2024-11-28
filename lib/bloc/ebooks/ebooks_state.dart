part of 'ebooks_bloc.dart';

abstract class EbooksState {}

class EbooksInitial extends EbooksState {}

class EbooksLoading extends EbooksState {}

class EbooksLoaded extends EbooksState {
  final List<DataEbooks> listEbooks;

  EbooksLoaded(this.listEbooks);
}

class EbooksError extends EbooksState {
  final String errorMessage;

  EbooksError(this.errorMessage);
}
