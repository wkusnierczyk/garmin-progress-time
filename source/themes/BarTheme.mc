import Toybox.Lang;

class BarTheme {

    private static const KEY_ELAPSED = "elapsed";
    private static const KEY_REMAINING = "remaining";
    private static const KEY_OUTLINE = "outline";
    private static const KEY_FONT = "font";

    private var _elapsed as Number;
    private var _remaining as Number;
    private var _outline as Number;
    private var _font as Number;

    function initialize(data as Dictionary) {
        _elapsed = parseColor(data, KEY_ELAPSED);
        _remaining = parseColor(data, KEY_REMAINING);
        _outline = parseColor(data, KEY_OUTLINE);
        _font = parseColor(data, KEY_FONT);
    }

    private function parseColor(data as Dictionary, key as String) as Number {
        var colorStr = data[key] as String?;
        if (colorStr != null) {
            return colorStr.toLongWithBase(16).toNumber();
        }
        return 0x000000;
    }

    function getElapsed() as Number {
        return _elapsed;
    }

    function getRemaining() as Number {
        return _remaining;
    }

    function getOutline() as Number {
        return _outline;
    }

    function getFont() as Number {
        return _font;
    }
    
}