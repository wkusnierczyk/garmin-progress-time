// using Toybox.Application.Properties;
using Toybox.WatchUi;

import Toybox.Lang;

/*!
    @class ProgressMenu
    @brief Settings menu for configuring the Progress Time data field.

    @details
    The menu exposes user-facing settings backed by app properties. Each entry
    reads the current value, renders a human-friendly label, and writes back to
    the same property when changed.

    @note
    This menu relies on `PropertyUtils.getPropertyElseDefault` to keep defaults
    consistent with the app's global configuration.
*/
class ProgressMenu extends WatchUi.Menu2 {

    /*!
        @function initialize
        @brief Initialize the menu and populate all settings items.

        @details
        - Adds a toggle for showing or hiding digits.
        - Adds a list item for layout selection with the current option name.
        - Additional menu items can be enabled by uncommenting the template.
    */
    function initialize() {

        Menu2.initialize({:title => CUSTOMIZE_MENU_TITLE});

        var withDigits = PropertyUtils.getPropertyElseDefault(SHOW_DIGITS_PROPERTY, SHOW_DIGITS_DEFAULT);
        addItem(new WatchUi.ToggleMenuItem(
            SHOW_DIGITS_MENU_LABEL, 
            null, 
            SHOW_DIGITS_PROPERTY, 
            withDigits, 
            null
        ));

        var layoutSelection = PropertyUtils.getPropertyElseDefault(LAYOUT_PROPERTY, LAYOUT_DEFAULT);
        var layoutName = LAYOUT_OPTIONS[layoutSelection];
        addItem(new WatchUi.MenuItem(
            LAYOUT_MENU_LABEL, 
            layoutName, 
            LAYOUT_PROPERTY, 
            null
        ));

    }

}
