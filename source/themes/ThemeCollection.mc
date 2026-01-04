import Toybox.Lang;

class ThemeCollection {
    
    private static const KEY_ID = "id";
    private static const KEY_NAME = "name";
    private static const KEY_THEMES = "themes";
    private static const KEY_DEFAULT = "default";

    private var _id as String;
    private var _name as String;
    private var _themes as Dictionary<String, ChartTheme>;
    private var _currentThemeId as String;

    function initialize(data as Dictionary, allThemes as Dictionary<String, ChartTheme>) {
        _id = data[KEY_ID] as String;
        _name = data[KEY_NAME] as String;
        _currentThemeId = data[KEY_DEFAULT] as String;
        _themes = {};

        var themeIds = data[KEY_THEMES] as Array<String>?;
        if (themeIds != null) {
            for (var i = 0; i < themeIds.size(); i++) {
                var tId = themeIds[i];
                var theme = allThemes[tId];
                if (theme != null) {
                    _themes.put(tId, theme);
                }
            }
        }
    }

    function getId() as String {
        return _id;
    }

    function getName() as String {
        return _name;
    }

    function getTheme(id as String) as ChartTheme? {
        return _themes[id];
    }

    function getCurrentTheme() as ChartTheme? {
        return _themes[_currentThemeId];
    }
}
