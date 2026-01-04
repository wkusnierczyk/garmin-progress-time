using Toybox.Application;
using Toybox.Graphics;

import Toybox.Lang;

/**
 * Shared constants for settings menu labels, property keys, defaults, and option
 * lists used by the app and settings UI.
 *
 * String constants are loaded from resources so they remain localizable, while
 * keys/defaults are centralized to keep settings behavior consistent.
 */

/**
 * Title string shown at the top of the customization menu.
 */
const CUSTOMIZE_MENU_TITLE = Application.loadResource(Rez.Strings.CustomizeMenuTitle);

/**
 * Menu label for the "show digits" toggle.
 */
const SHOW_DIGITS_MENU_LABEL = Application.loadResource(Rez.Strings.ShowDigitsMenuTitle);
/**
 * Settings storage key for whether numeric digits are displayed.
 */
const SHOW_DIGITS_PROPERTY = "ShowDigits";
/**
 * Default value for the "show digits" toggle.
 */
const SHOW_DIGITS_DEFAULT = true;

/**
 * Menu label for the layout picker.
 */
const LAYOUT_MENU_LABEL = Application.loadResource(Rez.Strings.LayoutMenuTitle);
/**
 * Settings storage key for the selected layout.
 */
const LAYOUT_PROPERTY = "Layout";
/**
 * Default layout index used when no user setting exists.
 */
const LAYOUT_DEFAULT = 0;
/**
 * Array of layout option labels loaded from JSON resources.
 */
const LAYOUT_OPTIONS as Array = Application.loadResource(Rez.JsonData.LayoutOptions);

/**
 * Menu label for the theme picker.
 */
const THEME_MENU_LABEL = Application.loadResource(Rez.Strings.ThemeMenuTitle);
/**
 * Settings storage key for the selected theme.
 */
const THEME_PROPERTY = "Theme";
/**
 * Default theme index used when no user setting exists.
 */
const THEME_DEFAULT = 0;
/**
 * Array of theme option labels loaded from JSON resources.
 */
const THEME_OPTIONS = Application.loadResource(Rez.JsonData.ThemeOptions);
