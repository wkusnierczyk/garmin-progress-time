import Toybox.Lang;

class ChartTheme {
    private static const KEY_ID = "id";
    private static const KEY_NAME = "name";
    private static const KEY_COLORS = "colors";
    private static const KEY_HOURS = "hours";
    private static const KEY_MINUTES = "minutes";
    private static const KEY_SECONDS = "seconds";

    private var _id as String;
    private var _name as String;
    private var _bars as Dictionary<String, BarTheme>;

    function initialize(data as Dictionary) {
        _id = data[KEY_ID] as String;
        _name = data[KEY_NAME] as String;
        _bars = {};

        var colors = data[KEY_COLORS] as Dictionary;
        if (colors != null) {
            addBarTheme(colors, KEY_HOURS);
            addBarTheme(colors, KEY_MINUTES);
            addBarTheme(colors, KEY_SECONDS);
        }
    }

    private function addBarTheme(colors as Dictionary, key as String) as Void {
        var barData = colors[key] as Dictionary;
        if (barData != null) {
            _bars.put(key, new BarTheme(barData));
        }
    }

    function getId() as String {
        return _id;
    }

    function getName() as String {
        return _name;
    }

    function getBarTheme(key as String) as BarTheme? {
        return _bars[key];
    }
}