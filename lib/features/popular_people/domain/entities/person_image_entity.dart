import 'package:equatable/equatable.dart';

class PersonImageEntity extends Equatable {
  final String filePath;

  const PersonImageEntity({required this.filePath});

  @override
  List<Object?> get props => [filePath];
}
