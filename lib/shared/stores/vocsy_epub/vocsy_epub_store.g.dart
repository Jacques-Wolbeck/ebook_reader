// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vocsy_epub_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$VocsyEpubStore on _VocsyEpubStore, Store {
  late final _$filePathAtom =
      Atom(name: '_VocsyEpubStore.filePath', context: context);

  @override
  String get filePath {
    _$filePathAtom.reportRead();
    return super.filePath;
  }

  @override
  set filePath(String value) {
    _$filePathAtom.reportWrite(value, super.filePath, () {
      super.filePath = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_VocsyEpubStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$downloadAsyncAction =
      AsyncAction('_VocsyEpubStore.download', context: context);

  @override
  Future<void> download(BookModel book) {
    return _$downloadAsyncAction.run(() => super.download(book));
  }

  late final _$startDownloadAsyncAction =
      AsyncAction('_VocsyEpubStore.startDownload', context: context);

  @override
  Future<void> startDownload(BookModel book) {
    return _$startDownloadAsyncAction.run(() => super.startDownload(book));
  }

  @override
  String toString() {
    return '''
filePath: ${filePath},
isLoading: ${isLoading}
    ''';
  }
}
