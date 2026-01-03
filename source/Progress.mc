using Toybox.Graphics;
using Toybox.Graphics;
using Toybox.System;

import Toybox.Lang;


class Progress {

    private static const DEFAULT_ELAPSED_COLOR = Graphics.COLOR_WHITE;
    private static const DEFAULT_REMAINING_COLOR = Graphics.COLOR_LT_GRAY;
    private static const DEFAULT_SCREEN_FRACTION_WIDTH = 0.7;
    private static const DEFAULT_SCREEN_FRACTION_HEIGHT = 0.1;
    private static const DEFAULT_ELAPSED = 50;
    private static const DEFAULT_TOTAL = 100;
    private static const DEFAULT_RADIUS_FRACTION = 0.5;

    private var _atX as Number;
    private var _atY as Number;
    private var _width as Number;
    private var _height as Number;
    private var _elapsedColor as Graphics.ColorType = DEFAULT_ELAPSED_COLOR;
    private var _remainingColor as Graphics.ColorType = DEFAULT_REMAINING_COLOR;
    private var _elapsed as Number = DEFAULT_ELAPSED;
    private var _total as Number = DEFAULT_TOTAL;
    private var _radius;

    function initialize() {
        var settings = System.getDeviceSettings();
        _width = (DEFAULT_SCREEN_FRACTION_WIDTH * settings.screenWidth).toNumber();
        _height = (DEFAULT_SCREEN_FRACTION_HEIGHT * settings.screenHeight).toNumber();
        _atX = (settings.screenWidth - _width) / 2;
        _atY = (settings.screenHeight - _height) / 2;
        _radius = (DEFAULT_RADIUS_FRACTION * _height).toNumber();
    }

    function withWidth(width as Number) as Progress {
        _width = width;
        return self;
    }

    function withLength(length as Number) as Progress {
        _height = length;
        return self;
    }

    function withElapsedColor(color as Graphics.ColorType) as Progress {
        _elapsedColor = color;
        return self;
    }

    function withRemainingColor(color as Graphics.ColorType) as Progress {
        _remainingColor = color;
        return self;
    }

    function withTotal(total as Number) as Progress {
        _total = total;
        return self;
    }

    function withElapsed(elapsed as Number) as Progress {
        _elapsed = elapsed;
        return self;
    }
    
    function draw(dc as Graphics.Dc) as Progress {
        dc.setColor(_remainingColor, Graphics.COLOR_TRANSPARENT);
        dc.fillRoundedRectangle(_atX, _atY, _width, _height, _radius);
        dc.setColor(_elapsedColor, Graphics.COLOR_TRANSPARENT);
        var progressWidth = (1.0 * _width * _elapsed / _total).toNumber();
        if (progressWidth < _height) {
            var radius = progressWidth / 2;
            dc.fillCircle(_atX + radius, _atY + _height / 2, radius);
        } else {
            dc.fillRoundedRectangle(_atX, _atY, progressWidth, _height ,_radius);
        }
        return self;
    }

}
