import 'package:uuid/uuid.dart';

/// Block kinds supported by the unified editor.
enum BlockKind { text, checklist, image }

/// In-memory representation of an editor block. Each block knows how to
/// serialize itself to a Map for the Note model's `blocks` field.
sealed class EditorBlock {
  final String id;
  EditorBlock({required this.id});

  Map<String, dynamic> toMap();

  static EditorBlock fromMap(Map<String, dynamic> map) {
    final type = map['type'] as String;
    final id = map['id'] as String? ?? const Uuid().v4();
    switch (type) {
      case 'text':
        return TextBlock(id: id, text: map['text'] as String? ?? '');
      case 'checklist':
        return ChecklistBlock(
          id: id,
          text: map['text'] as String? ?? '',
          checked: map['checked'] as bool? ?? false,
        );
      case 'image':
        return ImageBlock(id: id, path: map['path'] as String? ?? '');
      default:
        return TextBlock(id: id);
    }
  }
}

class TextBlock extends EditorBlock {
  String text;
  TextBlock({required super.id, this.text = ''});

  @override
  Map<String, dynamic> toMap() => {'type': 'text', 'id': id, 'text': text};
}

class ChecklistBlock extends EditorBlock {
  String text;
  bool checked;
  ChecklistBlock({
    required super.id,
    this.text = '',
    this.checked = false,
  });

  @override
  Map<String, dynamic> toMap() => {
        'type': 'checklist',
        'id': id,
        'text': text,
        'checked': checked,
      };
}

class ImageBlock extends EditorBlock {
  String path;
  ImageBlock({required super.id, required this.path});

  @override
  Map<String, dynamic> toMap() => {'type': 'image', 'id': id, 'path': path};
}

EditorBlock newTextBlock([String text = '']) =>
    TextBlock(id: const Uuid().v4(), text: text);

EditorBlock newChecklistBlock([String text = '']) =>
    ChecklistBlock(id: const Uuid().v4(), text: text);

EditorBlock newImageBlock(String path) =>
    ImageBlock(id: const Uuid().v4(), path: path);
