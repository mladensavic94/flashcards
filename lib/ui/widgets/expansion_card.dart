import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

const Duration _kExpand = Duration(milliseconds: 250);

class ExpansionCard extends StatefulWidget {
  const ExpansionCard({
    Key? key,
    this.leading,
    required this.title,
    this.backgroundColor,
    this.onExpansionChanged,
    this.children = const <Widget>[],
    this.trailing,
    this.initiallyExpanded = false,
    this.color,
  }) : super(key: key);

  final Widget? leading;
  final Widget title;
  final ValueChanged<bool>? onExpansionChanged;
  final List<Widget> children;
  final Color? backgroundColor;
  final Widget? trailing;
  final bool initiallyExpanded;
  final Color? color;

  @override
  _ExpansionTileState createState() => _ExpansionTileState();
}

class _ExpansionTileState extends State<ExpansionCard>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _fastOutSlowIn =
      CurveTween(curve: Curves.fastOutSlowIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);

  late AnimationController _controller;
  late Animation<double> _iconTurns;
  late Animation<double> _heightFactor;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _kExpand, vsync: this);
    _heightFactor = _controller.drive(_fastOutSlowIn);
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));
    _isExpanded =
        PageStorage.of(context)?.readState(context) ?? widget.initiallyExpanded;
    if (_isExpanded) _controller.value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted) return;
          setState(() {});
        });
      }
      PageStorage.of(context)?.writeState(context, _isExpanded);
    });
    if (widget.onExpansionChanged != null)
      widget.onExpansionChanged!(_isExpanded);
  }

  Widget _buildChildren(BuildContext context, Widget? child) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTileTheme.merge(
                  child: Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: ListTile(
                      onTap: _handleTap,
                      leading: widget.leading ?? _defaultLeading(),
                      title: widget.title,
                      trailing: widget.trailing ??
                          Column(
                            children: [
                              Spacer(
                                flex: 2,
                              ),
                              RotationTransition(
                                turns: _iconTurns,
                                child: const Icon(Icons.expand_more),
                              ),
                              Spacer(
                                flex: 1,
                              ),
                            ],
                          ),
                    ),
                  )),
              Container(
                alignment: Alignment.topLeft,
                child: Padding(
                  child: SizeTransition(
                    sizeFactor: _heightFactor,
                    axis: Axis.vertical,
                    axisAlignment: 0,
                    child: child,
                  ),
                  padding: EdgeInsets.only(left: 10, bottom: 10, right: 10),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Column _defaultLeading() {
    return Column(
      children: [
        Spacer(
          flex: 2,
        ),
        CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(_isExpanded ? Icons.folder_open : Icons.folder, color: Colors.white,),
        ),
        Spacer(
          flex: 1,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;
    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: closed
          ? null
          : Container(
              height: MediaQuery.of(context).size.height * 0.08,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Padding(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.children),
                padding: EdgeInsets.only(left: 10, top: 10),
              ),
            ),
    );
  }
}
