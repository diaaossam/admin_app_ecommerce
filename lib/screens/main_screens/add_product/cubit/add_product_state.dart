part of 'add_product_cubit.dart';

@immutable
abstract class AddProductState {}


class AddProductInitial extends AddProductState {}
class SetErrorsAddProduct extends AddProductState {}
class RemoveErrorsAddProduct extends AddProductState {}


class UploadProductLoadingState extends AddProductState {}
class UploadProductSuccessState extends AddProductState {}
class UploadProductFailerState extends AddProductState {
  String errorMsg;

  UploadProductFailerState(this.errorMsg);
}

class CategoryChangeListState extends AddProductState {}
class PopulerChangeListState extends AddProductState {}
