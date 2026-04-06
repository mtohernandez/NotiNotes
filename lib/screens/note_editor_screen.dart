import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../helpers/photo_picker.dart';
import '../models/note.dart';
import '../providers/notes.dart';
import '../theme/app_tokens.dart';
import '../theme/notes_color_palette.dart';
import '../widgets/editor/checklist_block.dart';
import '../widgets/editor/editor_block.dart';
import '../widgets/editor/editor_toolbar.dart';
import '../widgets/editor/image_block.dart';
import '../widgets/editor/note_app_bar.dart';
import '../widgets/editor/text_block.dart';
import '../widgets/sheets/note_style_sheet.dart';
import '../widgets/sheets/reminder_sheet.dart';
import '../widgets/sheets/tag_sheet.dart';

/// The unified, single-screen note editor. Replaces the old TabController
/// (Content / Todo) implementation. Title, body blocks, and tags are all
/// part of one scrollable column. The toolbar above the keyboard is the
/// only entry point for converting blocks, picking style, reminders, etc.
class NoteEditorScreen extends StatefulWidget {
  static const routeName = '/note-editor';

  /// If non-null, edit an existing note. If null, a new note is created.
  final String? noteId;

  const NoteEditorScreen({super.key, this.noteId});

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  late Note _note;
  late TextEditingController _titleController;
  late List<EditorBlock> _blocks;
  final Map<String, FocusNode> _focusNodes = {};
  String? _focusedBlockId;

  @override
  void initState() {
    super.initState();
    final notes = context.read<Notes>();
    if (widget.noteId != null) {
      _note = notes.findById(widget.noteId!);
    } else {
      _note = Note(
        {},
        null,
        null,
        [],
        null,
        null,
        id: const Uuid().v4(),
        title: '',
        content: '',
        dateCreated: DateTime.now(),
        colorBackground: NotesColorPalette.defaultSwatch.light,
        fontColor: const Color(0xFF1A1A1A),
        hasGradient: false,
      );
      notes.addNote(_note);
    }
    _titleController = TextEditingController(text: _note.title);
    _blocks = _note.blocks.isEmpty
        ? [newTextBlock()]
        : _note.blocks.map(EditorBlock.fromMap).toList();

    // Autofocus the first block on new notes after the first frame.
    if (widget.noteId == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_blocks.isNotEmpty) {
          _focusBlock(_blocks.first.id);
        }
      });
    }
  }

  @override
  void dispose() {
    _persist();
    _titleController.dispose();
    for (final f in _focusNodes.values) {
      f.dispose();
    }
    super.dispose();
  }

  FocusNode _focusFor(String id) =>
      _focusNodes.putIfAbsent(id, () => FocusNode()..addListener(() {
            if (_focusNodes[id]?.hasFocus == true) {
              setState(() => _focusedBlockId = id);
            }
          }));

  void _focusBlock(String id) {
    _focusFor(id).requestFocus();
    setState(() => _focusedBlockId = id);
  }

  void _persist() {
    final notes = context.read<Notes>();
    notes.updateTitle(_note.id, _titleController.text);
    notes.replaceBlocks(_note.id, _blocks.map((b) => b.toMap()).toList());
  }

  void _onBlockChanged() {
    // Mutations to block.text are made directly by the child widgets;
    // we just need to persist on a debounced cadence. For simplicity v2
    // persists on every change. Hive writes are cheap.
    _persist();
  }

  void _insertTextBlockBelow(String afterId) {
    final i = _blocks.indexWhere((b) => b.id == afterId);
    if (i < 0) return;
    final newBlock = newTextBlock();
    setState(() {
      _blocks.insert(i + 1, newBlock);
    });
    _persist();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusBlock(newBlock.id);
    });
  }

  void _insertChecklistBlockBelow(String afterId) {
    final i = _blocks.indexWhere((b) => b.id == afterId);
    if (i < 0) return;
    final newBlock = newChecklistBlock();
    setState(() {
      _blocks.insert(i + 1, newBlock);
    });
    _persist();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusBlock(newBlock.id);
    });
  }

  void _deleteBlock(String id) {
    final i = _blocks.indexWhere((b) => b.id == id);
    if (i < 0 || _blocks.length == 1) return;
    setState(() {
      _blocks.removeAt(i);
    });
    _persist();
    final focusIndex = (i - 1).clamp(0, _blocks.length - 1);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusBlock(_blocks[focusIndex].id);
    });
  }

  void _convertCurrentBlock() {
    final id = _focusedBlockId ?? (_blocks.isNotEmpty ? _blocks.first.id : null);
    if (id == null) return;
    final i = _blocks.indexWhere((b) => b.id == id);
    if (i < 0) return;
    final current = _blocks[i];
    EditorBlock replacement;
    if (current is TextBlock) {
      replacement = ChecklistBlock(id: current.id, text: current.text);
    } else if (current is ChecklistBlock) {
      replacement = TextBlock(id: current.id, text: current.text);
    } else {
      return;
    }
    setState(() {
      _blocks[i] = replacement;
    });
    _persist();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusBlock(replacement.id);
    });
  }

  Future<void> _addImage() async {
    final picked = await PhotoPicker.pickImage(ImageSource.gallery, 80);
    if (picked == null) return;
    final block = newImageBlock(picked.path);
    setState(() => _blocks.add(block));
    _persist();
  }

  void _deleteImageBlock(String id) {
    final i = _blocks.indexWhere((b) => b.id == id);
    if (i < 0) return;
    final block = _blocks[i];
    if (block is ImageBlock) {
      try {
        File(block.path).deleteSync();
      } catch (_) {}
    }
    setState(() => _blocks.removeAt(i));
    _persist();
  }

  Future<void> _openStyleSheet() async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => NoteStyleSheet(noteId: _note.id),
    );
    setState(() {
      _note = context.read<Notes>().findById(_note.id);
    });
  }

  Future<void> _openReminderSheet() async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => ReminderSheet(noteId: _note.id),
    );
    setState(() {
      _note = context.read<Notes>().findById(_note.id);
    });
  }

  Future<void> _openTagSheet() async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => TagSheet(noteId: _note.id),
    );
    setState(() {
      _note = context.read<Notes>().findById(_note.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final notes = context.watch<Notes>();
    // Refresh the local Note reference whenever the provider rebuilds (e.g.
    // after a sheet edits color/reminder/tags).
    _note = notes.findByIdOrNull(_note.id) ?? _note;
    final brightness = Theme.of(context).brightness;
    final swatch = NotesColorPalette.swatchFor(_note.colorBackground);
    final autoTextColor = swatch?.autoTextColor(brightness);

    final background = _note.hasGradient && _note.gradient != null
        ? null
        : _note.colorBackground;

    final currentBlock = _focusedBlockId == null
        ? (_blocks.isNotEmpty ? _blocks.first : null)
        : _blocks.firstWhere(
            (b) => b.id == _focusedBlockId,
            orElse: () => _blocks.first,
          );
    final currentIsChecklist = currentBlock is ChecklistBlock;

    return Scaffold(
      backgroundColor: background,
      extendBodyBehindAppBar: true,
      appBar: NoteAppBar(
        isPinned: _note.isPinned,
        onTogglePin: () {
          context.read<Notes>().togglePin(_note.id);
          setState(() {
            _note = context.read<Notes>().findById(_note.id);
          });
        },
        onDelete: () async {
          final confirmed = await showDialog<bool>(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Delete note?'),
              content: const Text('This cannot be undone.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Delete', style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          );
          if (confirmed == true && mounted) {
            context.read<Notes>().deleteNote(_note.id);
            if (mounted) Navigator.of(context).pop();
          }
        },
        foregroundColor: autoTextColor,
      ),
      body: Container(
        decoration: _note.hasGradient && _note.gradient != null
            ? BoxDecoration(gradient: _note.gradient)
            : _note.patternImage != null
                ? BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(_note.patternImage!),
                      fit: BoxFit.cover,
                      opacity: 0.5,
                      colorFilter: ColorFilter.mode(
                        _note.colorBackground,
                        BlendMode.softLight,
                      ),
                    ),
                  )
                : null,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.md,
                  ),
                  children: [
                    TextField(
                      controller: _titleController,
                      maxLength: 80,
                      onChanged: (_) => _persist(),
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            color: autoTextColor,
                          ),
                      cursorColor:
                          autoTextColor ?? Theme.of(context).colorScheme.primary,
                      decoration: InputDecoration(
                        isCollapsed: true,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        filled: false,
                        counterText: '',
                        contentPadding: EdgeInsets.zero,
                        hintText: 'Title',
                        hintStyle:
                            Theme.of(context).textTheme.displayLarge?.copyWith(
                                  color: (autoTextColor ?? Colors.grey)
                                      .withValues(alpha: 0.4),
                                ),
                      ),
                    ),
                    const Gap(AppSpacing.xs),
                    Text(
                      DateFormat('MMM d · HH:mm').format(_note.dateCreated),
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: (autoTextColor ?? Colors.grey)
                                .withValues(alpha: 0.6),
                          ),
                    ),
                    if (_note.reminder != null) ...[
                      const Gap(AppSpacing.sm),
                      _ReminderChip(
                        date: _note.reminder!,
                        textColor: autoTextColor,
                        onTap: _openReminderSheet,
                      ),
                    ],
                    if (_note.tags.isNotEmpty) ...[
                      const Gap(AppSpacing.sm),
                      _TagsRow(tags: _note.tags, textColor: autoTextColor),
                    ],
                    const Gap(AppSpacing.md),
                    ..._blocks.map((block) => _buildBlock(block, autoTextColor)),
                    const Gap(AppSpacing.xxxl),
                  ],
                ),
              ),
              EditorToolbar(
                currentBlockIsChecklist: currentIsChecklist,
                onToggleChecklist: _convertCurrentBlock,
                onAddImage: _addImage,
                onOpenStyleSheet: _openStyleSheet,
                onOpenReminderSheet: _openReminderSheet,
                onOpenTagSheet: _openTagSheet,
                onDoneEditing: () {
                  FocusScope.of(context).unfocus();
                  _persist();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBlock(EditorBlock block, Color? textColor) {
    return KeyedSubtree(
      key: ValueKey(block.id),
      child: switch (block) {
        TextBlock() => TextBlockWidget(
            block: block,
            focusNode: _focusFor(block.id),
            onChanged: (_) => _onBlockChanged(),
            onInsertBelow: () => _insertTextBlockBelow(block.id),
            onDeleteBlock: () => _deleteBlock(block.id),
            textColor: textColor,
          ),
        ChecklistBlock() => ChecklistBlockWidget(
            block: block,
            focusNode: _focusFor(block.id),
            onChanged: (_) => _onBlockChanged(),
            onCheckedChanged: (v) {
              setState(() => block.checked = v);
              _persist();
            },
            onInsertBelow: () => _insertChecklistBlockBelow(block.id),
            onConvertToText: () {
              final i = _blocks.indexWhere((b) => b.id == block.id);
              if (i < 0) return;
              final replacement = TextBlock(id: block.id, text: block.text);
              setState(() => _blocks[i] = replacement);
              _persist();
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _focusBlock(replacement.id);
              });
            },
            textColor: textColor,
          ),
        ImageBlock() => ImageBlockWidget(
            path: block.path,
            onDelete: () => _deleteImageBlock(block.id),
          ),
      },
    );
  }
}

class _ReminderChip extends StatelessWidget {
  final DateTime date;
  final Color? textColor;
  final VoidCallback onTap;
  const _ReminderChip({
    required this.date,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = textColor ?? Theme.of(context).colorScheme.onSurface;
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.xs + 2,
          ),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(AppRadius.full),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.notifications_active_outlined, size: 14, color: color),
              const Gap(AppSpacing.xs),
              Text(
                DateFormat('MMM d · HH:mm').format(date),
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: color,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TagsRow extends StatelessWidget {
  final Set<String> tags;
  final Color? textColor;
  const _TagsRow({required this.tags, required this.textColor});

  @override
  Widget build(BuildContext context) {
    final color = textColor ?? Theme.of(context).colorScheme.onSurface;
    return SizedBox(
      height: 28,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: tags.length,
        separatorBuilder: (_, __) => const Gap(AppSpacing.xs),
        itemBuilder: (_, i) {
          final tag = tags.elementAt(i);
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppRadius.full),
            ),
            alignment: Alignment.center,
            child: Text(
              '#$tag',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: color,
                  ),
            ),
          );
        },
      ),
    );
  }
}
