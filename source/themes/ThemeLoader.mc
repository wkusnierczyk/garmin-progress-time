import Toybox.Lang;
import Toybox.WatchUi;


class ThemeLoader {

    private static const KEY_COLLECTIONS = "collections";
    private static const KEY_DEFAULTS = "defaults";
    private static const KEY_THEMES = "themes";
    private static const KEY_COLLECTION = "collection";

    private var _collections as Dictionary<String, ThemeCollection>;
    private var _currentCollectionId as String;


    function initialize() {
        _collections = {};
        _currentCollectionId = "";
        load();
    }

    private function load() as Void {
        var json = WatchUi.loadResource(Rez.JsonData.Themes) as Dictionary?;
        if (json == null) {
            return;
        }

        // 1. Parse all themes into a temporary map
        var allThemes = {} as Dictionary<String, ChartTheme>;
        var themesData = json[KEY_THEMES] as Array<Dictionary>?;
        if (themesData != null) {
            for (var i = 0; i < themesData.size(); ++i) {
                var theme = new ChartTheme(themesData[i]);
                allThemes.put(theme.getId(), theme);
            }
        }

        // 2. Parse collections, resolving themes from the map
        var collectionsData = json[KEY_COLLECTIONS] as Array<Dictionary>?;
        if (collectionsData != null) {
            for (var i = 0; i < collectionsData.size(); ++i) {
                var collection = new ThemeCollection(collectionsData[i], allThemes);
                _collections.put(collection.getId(), collection);
            }
        }

        // 3. Set initial defaults
        var defaults = json[KEY_DEFAULTS] as Dictionary?;
        if (defaults != null) {
            var collectionId = defaults[KEY_COLLECTION] as String?;
            if (collectionId != null && _collections.hasKey(collectionId)) {
                _currentCollectionId = collectionId;
            } else {
                // TODO: might fail if no collections have been parsed
                _currentCollectionId = _collections.keys()[0];
            }

        }

    }

    function getCurrentCollection() as ThemeCollection? {
        return _collections[_currentCollectionId];
    }

    function getCurrentTheme() as ChartTheme? {
        var collection = getCurrentCollection();
        if (collection != null) {
            return collection.getCurrentTheme();
        }
        return null;
    }

}
