using Toybox.Graphics;
using Toybox.Graphics;
using Toybox.System;

import Toybox.Lang;


class ProgressBar {

    hidden static const DEFAULT_ELAPSED_COLOR = Graphics.COLOR_WHITE;
    hidden static const DEFAULT_REMAINING_COLOR = Graphics.COLOR_LT_GRAY;
    hidden static const DEFAULT_SCREEN_FRACTION_WIDTH = 0.7;
    hidden static const DEFAULT_SCREEN_FRACTION_HEIGHT = 0.15;
    hidden static const DEFAULT_ELAPSED = 50;
    hidden static const DEFAULT_TOTAL = 100;
    hidden static const DEFAULT_RADIUS_FRACTION = 0.1;
    hidden static const DEFAULT_WITH_DIGITS = false;
    hidden static const DEFAULT_DIGITS_FONT = Graphics.FONT_SMALL;
    hidden static const DEFAULT_DIGITS_COLOR = Graphics.COLOR_BLACK;
    hidden static const DEFAULT_DIGITS_FORMAT = "%02d";
    hidden static const DIGITS_SPACING_FACTOR = 0.25;


    hidden var _atX as Number;
    hidden var _atY as Number;
    hidden var _width as Number;
    hidden var _height as Number;
    hidden var _elapsedColor as Graphics.ColorType = DEFAULT_ELAPSED_COLOR;
    hidden var _remainingColor as Graphics.ColorType = DEFAULT_REMAINING_COLOR;
    hidden var _elapsed as Number = DEFAULT_ELAPSED;
    hidden var _total as Number = DEFAULT_TOTAL;
    hidden var _radius;
    hidden var _withDigits as Boolean = DEFAULT_WITH_DIGITS;
    hidden var _digitsFont as Graphics.FontType= DEFAULT_DIGITS_FONT;
    hidden var _digitsColor as Graphics.ColorType = DEFAULT_DIGITS_COLOR;
    hidden var _digitsFormat as String = DEFAULT_DIGITS_FORMAT;


    function initialize() {
        var settings = System.getDeviceSettings();
        _width = (DEFAULT_SCREEN_FRACTION_WIDTH * settings.screenWidth).toNumber();
        _height = (DEFAULT_SCREEN_FRACTION_HEIGHT * settings.screenHeight).toNumber();
        _atX = (settings.screenWidth - _width) / 2;
        _atY = (settings.screenHeight - _height) / 2;
        _radius = (DEFAULT_RADIUS_FRACTION * _height).toNumber();
    }

    function at(x as Number, y as Number) as ProgressBar {
        _atX = x;
        _atY = y;
        return self;
    }

    hidden function withWidth(width as Number) as ProgressBar {
        _width = width;
        return self;
    }

    hidden function withHeight(height as Number) as ProgressBar {
        _height = height;
        return self;
    }

    function withElapsedColor(color as Graphics.ColorType) as ProgressBar {
        _elapsedColor = color;
        return self;
    }

    function withRemainingColor(color as Graphics.ColorType) as ProgressBar {
        _remainingColor = color;
        return self;
    }

    function withElapsed(elapsed as Number) as ProgressBar {
        _elapsed = elapsed;
        return self;
    }

    function withTotal(total as Number) as ProgressBar {
        _total = total;
        return self;
    }
    
    function withDigits() as ProgressBar {
        _withDigits = true;
        return self;
    }

    function withoutDigits() as ProgressBar {
        _withDigits = false;
        return self;
    }

    function withDigitsFont(font as Graphics.FontType) as ProgressBar {
        _digitsFont = font;
        return self;
    }

    function withDigitsColor(color as Graphics.ColorType) as ProgressBar {
        _digitsColor = color;
        return self;
    }

    function withDigitsFormat(format as String) as ProgressBar {
        _digitsFormat = format;
        return self;
    }

    function draw(dc as Graphics.Dc) as ProgressBar {
        return self;
    }

}


class HorizontalProgressBar extends ProgressBar {

    function initialize() {
        ProgressBar.initialize();
    }

    function withLength(length as Number) as HorizontalProgressBar {
        _width = length;
        return self;
    }

    function withBreadth(breadth as Number) as HorizontalProgressBar {
        _height = breadth;
        return self;
    }

    function draw(dc as Graphics.Dc) as ProgressBar {

        // Draw the remaining part covering the whole length of the bar
        dc.setColor(_remainingColor, Graphics.COLOR_TRANSPARENT);
        dc.fillRoundedRectangle(_atX, _atY, _width, _height, _radius);

        // Draw the elapsed part
        var progressWidth = (1.0 * _width * _elapsed / _total).toNumber();
        dc.setColor(_elapsedColor, Graphics.COLOR_TRANSPARENT);
        dc.fillRoundedRectangle(_atX, _atY, progressWidth, _height ,_radius);

        if (_withDigits) {
            var digits = _elapsed.format(_digitsFormat);
            var digitsX = (_atX + _width - DIGITS_SPACING_FACTOR * _height).toNumber();
            var digitsY = _atY + _height / 2;
            dc.setColor(_digitsColor, Graphics.COLOR_TRANSPARENT);
            dc.drawText(digitsX, digitsY, _digitsFont, digits, Graphics.TEXT_JUSTIFY_RIGHT | Graphics.TEXT_JUSTIFY_VCENTER);
        }

        return self;

    }

}

class VerticalProgressBar extends ProgressBar {

    function initialize() {
        ProgressBar.initialize();
    }

    function withLength(length as Number) as VerticalProgressBar {
        _height = length;
        return self;
    }

    function withBreadth(breadth as Number) as VerticalProgressBar {
        _width = breadth;
        return self;
    }

    function draw(dc as Graphics.Dc) as ProgressBar {

        // Draw the remaining part covering the whole length of the bar
        dc.setColor(_remainingColor, Graphics.COLOR_TRANSPARENT);
        dc.fillRoundedRectangle(_atX, _atY, _width, _height, _radius);

        // Draw the elapsed part
        var progressHeight = (1.0 * _height * _elapsed / _total).toNumber();
        dc.setColor(_elapsedColor, Graphics.COLOR_TRANSPARENT);
        dc.fillRoundedRectangle(_atX, _atY - _height + progressHeight, _width, progressHeight, _radius);

        if (_withDigits) {
            var digits = _elapsed.format(_digitsFormat);
            var digitsX = _atX + _width / 2;
            var digitsY = (_atY + _height - DIGITS_SPACING_FACTOR * _width).toNumber();
            dc.setColor(_digitsColor, Graphics.COLOR_TRANSPARENT);
            dc.drawText(digitsX, digitsY, _digitsFont, digits, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        }

        return self;

    }

}
