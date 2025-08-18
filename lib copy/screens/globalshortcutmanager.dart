import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GlobalShortcutManager extends StatefulWidget {
  final Widget child;

  final VoidCallback? onInsert;
  final VoidCallback? onSave;
  final VoidCallback? onSaveAndPrint;
  final VoidCallback? onAutoDate;
  final VoidCallback? onSales;
  final VoidCallback? onSalesItemWise;
  final VoidCallback? onPurchase;
  final VoidCallback? onPurchaseItemWise;
  final VoidCallback? onProfit;
  final VoidCallback? onBack;

  const GlobalShortcutManager({
    super.key,
    required this.child,
    this.onInsert,
    this.onSave,
    this.onSaveAndPrint,
    this.onAutoDate,
    this.onSales,
    this.onSalesItemWise,
    this.onPurchase,
    this.onPurchaseItemWise,
    this.onProfit,
    this.onBack,
  });

  @override
  State<GlobalShortcutManager> createState() => _GlobalShortcutManagerState();
}

class _GlobalShortcutManagerState extends State<GlobalShortcutManager> {
  final FocusNode _focusNode = FocusNode();
  final Set<String> _intentLocks = {}; // Prevent duplicate triggers

  void _handleIntent(String intent) {
    if (_intentLocks.contains(intent)) return; // Already running

    _intentLocks.add(intent);

    try {
      switch (intent) {
        case 'insert':
          widget.onInsert?.call();
        case 'save':
          widget.onSave?.call();
        case 'savePrint':
          widget.onSaveAndPrint?.call();
        case 'autoDate':
          widget.onAutoDate?.call();
        case 'sales':
          widget.onSales?.call();
        case 'salesItemWise':
          widget.onSalesItemWise?.call();
        case 'purchase':
          widget.onPurchase?.call();
        case 'purchaseItemWise':
          widget.onPurchaseItemWise?.call();
        case 'profit':
          widget.onProfit?.call();
        case 'back':
          widget.onBack?.call();
        default:
          debugPrint('Unhandled intent: $intent');
      }
    } catch (e) {
      debugPrint('Error in intent [$intent]: $e');
    } finally {
      _intentLocks.remove(intent);
    }
  }

  void _handleRawKeyEvent(KeyEvent event) {
    if (event is KeyboardListener) {
      switch (event.logicalKey) {
        case LogicalKeyboardKey.enter:
          debugPrint('Enter pressed');
        case LogicalKeyboardKey.arrowDown:
          debugPrint('Arrow Down pressed');
        case LogicalKeyboardKey.arrowUp:
          debugPrint('Arrow Up pressed');
        case LogicalKeyboardKey.arrowLeft:
          debugPrint('Arrow Left pressed');
        case LogicalKeyboardKey.arrowRight:
          debugPrint('Arrow Right pressed');
        case LogicalKeyboardKey.pageUp:
          debugPrint('Page Up pressed');
        case LogicalKeyboardKey.pageDown:
          debugPrint('Page Down pressed');
        case LogicalKeyboardKey.tab:
          debugPrint('Tab pressed');
        default:
          // No special handling for other keys
          break;
      }
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.alt, LogicalKeyboardKey.keyI):
            const _InsertIntent(),
        LogicalKeySet(LogicalKeyboardKey.f2): const _AutoDateIntent(),
        LogicalKeySet(LogicalKeyboardKey.f3): const _SaveIntent(),
        LogicalKeySet(LogicalKeyboardKey.f4): const _SavePrintIntent(),
        LogicalKeySet(LogicalKeyboardKey.f5): const _SalesIntent(),
        LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.f5):
            const _SalesItemWiseIntent(),
        LogicalKeySet(LogicalKeyboardKey.f6): const _PurchaseIntent(),
        LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.f6):
            const _PurchaseItemWiseIntent(),
        LogicalKeySet(LogicalKeyboardKey.f12): const _ProfitIntent(),
        LogicalKeySet(LogicalKeyboardKey.escape): const _BackIntent(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          _InsertIntent: CallbackAction<_InsertIntent>(
            onInvoke: (_) => _handleIntent('insert'),
          ),
          _AutoDateIntent: CallbackAction<_AutoDateIntent>(
            onInvoke: (_) => _handleIntent('autoDate'),
          ),
          _SaveIntent: CallbackAction<_SaveIntent>(
            onInvoke: (_) => _handleIntent('save'),
          ),
          _SavePrintIntent: CallbackAction<_SavePrintIntent>(
            onInvoke: (_) => _handleIntent('savePrint'),
          ),
          _SalesIntent: CallbackAction<_SalesIntent>(
            onInvoke: (_) => _handleIntent('sales'),
          ),
          _SalesItemWiseIntent: CallbackAction<_SalesItemWiseIntent>(
            onInvoke: (_) => _handleIntent('salesItemWise'),
          ),
          _PurchaseIntent: CallbackAction<_PurchaseIntent>(
            onInvoke: (_) => _handleIntent('purchase'),
          ),
          _PurchaseItemWiseIntent: CallbackAction<_PurchaseItemWiseIntent>(
            onInvoke: (_) => _handleIntent('purchaseItemWise'),
          ),
          _ProfitIntent: CallbackAction<_ProfitIntent>(
            onInvoke: (_) => _handleIntent('profit'),
          ),
          _BackIntent: CallbackAction<_BackIntent>(
            onInvoke: (_) => _handleIntent('back'),
          ),
        },
        child: Focus(
          autofocus: true,
          focusNode: _focusNode,
          child: KeyboardListener(
            focusNode: FocusNode(),
            onKeyEvent: _handleRawKeyEvent,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

// Custom intent classes for type-safe matching
class _InsertIntent extends Intent {
  const _InsertIntent();
}

class _AutoDateIntent extends Intent {
  const _AutoDateIntent();
}

class _SaveIntent extends Intent {
  const _SaveIntent();
}

class _SavePrintIntent extends Intent {
  const _SavePrintIntent();
}

class _SalesIntent extends Intent {
  const _SalesIntent();
}

class _SalesItemWiseIntent extends Intent {
  const _SalesItemWiseIntent();
}

class _PurchaseIntent extends Intent {
  const _PurchaseIntent();
}

class _PurchaseItemWiseIntent extends Intent {
  const _PurchaseItemWiseIntent();
}

class _ProfitIntent extends Intent {
  const _ProfitIntent();
}

class _BackIntent extends Intent {
  const _BackIntent();
}
