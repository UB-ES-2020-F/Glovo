import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class TextLink extends StatefulWidget {
  String _text;
  //Function _onTap;
  void Function(BuildContext) _onTap;
  TextStyle _linkStyle;
  TextStyle _hoverStyle;
  BuildContext _context;
  Key key;

  @override
  TextLink(
      this._text, this._onTap, this._linkStyle, this._hoverStyle, this._context,
      {this.key})
      : super(key: key ?? Key("text-link-default-value"));

  _TextLinkState createState() =>
      _TextLinkState(_text, _onTap, _linkStyle, _hoverStyle, _context);
}

class _TextLinkState extends State<TextLink> {
  String _text;
  void Function(BuildContext) _onTap;

  TextStyle _linkStyle;
  TextStyle _hoverStyle;
  bool _hover = false;
  BuildContext _context;

  _TextLinkState(this._text, this._onTap, this._linkStyle, this._hoverStyle,
      this._context);

  @override
  Widget build(BuildContext context) {
    var textSpan = TextSpan(
        text: this._text,
        style: this._hover ? this._hoverStyle : this._linkStyle,
        recognizer: TapGestureRecognizer()
          ..onTap = () => this._onTap(_context));
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(child: Text.rich(textSpan)),
      onHover: (event) {
        setState(() {
          this._hover = true;
        });
      },
      onExit: (event) {
        setState(() {
          this._hover = false;
        });
      },
    );
  }
}
