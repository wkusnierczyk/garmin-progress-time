using Toybox.Application.Properties;
using Toybox.WatchUi;

import Toybox.Lang;

/**
 * Menu input delegate for the watch face customization screen.
 * @description
 *  Persists toggle and selection changes from menu items into application
 *  properties, then returns control to the parent view when the user exits.
 */

class ProgressDelegate extends WatchUi.Menu2InputDelegate {

    /**
     * Initialize the delegate and parent state.
     */
    function initialize() {
        Menu2InputDelegate.initialize();
    }

    /**
     * Handle selection changes for menu items.
     * @param item The menu item that was selected or toggled.
     */
    function onSelect(item) {

        var id = item.getId();

        if (id.equals(SHOW_DIGITS_PROPERTY) && item instanceof WatchUi.ToggleMenuItem) {
            Properties.setValue(SHOW_DIGITS_PROPERTY, item.isEnabled());
        }
        
    }

    /**
     * Close the menu view when the back button is pressed.
     */
    function onBack() {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }

}
