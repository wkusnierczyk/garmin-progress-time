using Toybox.Application.Properties;
using Toybox.WatchUi;

import Toybox.Lang;


class ProgressTimeMenu extends WatchUi.Menu2 {

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

        // var multiOptionSelection = PropertyUtils.getPropertyElseDefault(MULTI_OPTION_PROPERTY, MULTI_OPTION_DEFAULT);
        // var multiOptoinName = MULTI_OPTION_NAMES[multiOptionSelection];
        // addItem(new WatchUi.MenuItem(
        //     MULTI_OPTION_LABEL, 
        //     multiOptoinName, 
        //     MULTI_OPTION_PROPERTY, 
        //     null
        // ));

    }

}
