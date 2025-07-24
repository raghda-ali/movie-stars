import 'package:equatable/equatable.dart';

class PersonImageEntity extends Equatable {
  final String filePath;
  final dynamic width;
  final dynamic height;

  const PersonImageEntity({required this.filePath, this.width, this.height});

  @override
  List<Object?> get props => [filePath, width, height];
}
