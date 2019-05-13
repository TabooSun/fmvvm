part of fmvvm.bindings;

/// Class to expend for all StatelessWidgets that plan to use data in a viewmodel for display.
///
/// Databinding is not allowed in a StatelessWidget per se as there is no ability to update
/// in either direction. Instead the values in the ViewModel can be retrived and used
/// in construction of the widget.
abstract class FmvvmStatelessWidget<V extends BindableBase>
    extends StatelessWidget implements BindableBaseHolder<V> {
  /// Creates the FmvvmStatelessWidget object.
  ///
  /// [_viewModel] is the view model to be used.
  /// [_isNavigable] should be true if this widget will be treated like a page instead of part
  /// of a page.
  @mustCallSuper
  FmvvmStatelessWidget(this._bindableBase, this._isNavigable, {Key key})
      : super(key: key) {
    if (_bindableBase is! ViewModel && _isNavigable) {
      throw ArgumentError(
          "Navigable FmvvmStatelessWidget objects must be of type ViewModel");
    }
  }

  final V _bindableBase;
  final bool _isNavigable;

  /// The class's viewmodel reference.
  V get bindableBase => _bindableBase;

  /// Builds the presentaiton for the widget.
  ///
  /// If this StatelessWidget isNavigatable, the NavigationService's context is set to this context.
  @override
  @mustCallSuper
  Widget build(BuildContext context) {
    if (_isNavigable) {
      Core.componentResolver.resolveType<NavigationService>().currentContext =
          context;
    }
    return null;
  }

  /// Returns a value from a BindableBase instance.
  ///
  /// [source] - An instance of the BindableBase object to get a value from.
  /// [value] - The value from the BinbalbeBase object.
  /// [valueConverter] - A ValueConverter instance to convert the value from the [value]
  /// parameter to one expected by the widget.
  @protected
  Object getValueWithConversion(BindableBase source, Object value,
      fmvvm_interfaces.ValueConverter valueConverter,
      {Object converterParameter}) {
    return valueConverter.convert(source, value, parameter: converterParameter);
  }
}
