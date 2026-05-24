import 'dart:io';

String humanFileSize(int bytes) {
  if (bytes <= 0) return '0 B';
  const suffixes = ['B', 'KB', 'MB', 'GB'];
  var index = 0;
  var value = bytes.toDouble();
  while (value >= 1024 && index < suffixes.length - 1) {
    value /= 1024;
    index++;
  }
  return '${value.toStringAsFixed(1)} ${suffixes[index]}';
}

String friendlyFileName(File file) {
  return file.path.split('/').last;
}
