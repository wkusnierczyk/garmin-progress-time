using Toybox.Application;
using Toybox.Graphics;

import Toybox.Lang;


// Colors
const HOUR_COLOR = Graphics.COLOR_WHITE;
const MINUTES_COLOR = Graphics.COLOR_LT_GRAY;
const SECONDS_COLOR = Graphics.COLOR_DK_GRAY;


// Time rendering
const MAX_HOURS = 23;
const MAX_MINUTES = 59;


// Fonts
const HOUR_FONT = Application.loadResource(Rez.Fonts.HourFont);
const MINUTES_FONT = Application.loadResource(Rez.Fonts.MinutesFont);
const SECONDS_FONT = Application.loadResource(Rez.Fonts.SecondsFont);


// Settings
const CUSTOMIZE_MENU_TITLE = Application.loadResource(Rez.Strings.CustomizeMenuTitle);

const SHOW_DIGITS_MENU_LABEL = Application.loadResource(Rez.Strings.ShowDigitsMenuTitle);
const SHOW_DIGITS_PROPERTY = "ShowDigits";
const SHOW_DIGITS_DEFAULT = true;

const LAYOUT_MENU_LABEL = Application.loadResource(Rez.Strings.LayoutMenuTitle);
const LAYOUT_PROPERTY = "Layout";
const LAYOUT_DEFAULT = 0;
const LAYOUT_OPTIONS as Array = Application.loadResource(Rez.JsonData.LayoutOptions);

const THEME_MENU_LABEL = Application.loadResource(Rez.Strings.ThemeMenuTitle);
const THEME_PROPERTY = "Theme";
const THEME_DEFAULT = 0;
const THEME_OPTIONS = Application.loadResource(Rez.JsonData.ThemeOptions);