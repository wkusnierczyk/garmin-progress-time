using Toybox.Graphics;

import Toybox.Lang;


/**
 * Base class for progress bars with fluent configuration.
 *
 * Progress bars draw a filled "elapsed" segment on top of a "remaining"
 * background segment. This class manages sizing, colors, elapsed/total values,
 * and optional digits rendering. Subclasses implement orientation-specific
 * drawing.
 */
class ProgressBar {

    private static const DEFAULT_SCREEN_FRACTION_WIDTH = 0.7;
    private static const DEFAULT_SCREEN_FRACTION_HEIGHT = 0.15;
    private static const DEFAULT_ELAPSED = 50;
    private static const DEFAULT_TOTAL = 100;
    private static const DEFAULT_RADIUS_FRACTION = 0.1;
    
    private static const DEFAULT_ELAPSED_COLOR = Graphics.COLOR_WHITE;
    private static const DEFAULT_REMAINING_COLOR = Graphics.COLOR_LT_GRAY;
    
    private static const DEFAULT_WITH_OUTLINE = false;
    private static const DEFAULT_OUTLINE_COLOR = Graphics.COLOR_LT_GRAY;
    private static const DEFAULT_OUTLINE_THICKNESS = 2;

    private static const DEFAULT_WITH_DIGITS = false;
    private static const DEFAULT_DIGITS_FONT = Graphics.FONT_SMALL;
    private static const DEFAULT_DIGITS_COLOR = Graphics.COLOR_BLACK;
    private static const DEFAULT_DIGITS_FORMAT = "%2d";


    hidden var _atX as Number;
    hidden var _atY as Number;
    hidden var _width as Number;
    hidden var _height as Number;
    hidden var _elapsed as Number = DEFAULT_ELAPSED;
    hidden var _total as Number = DEFAULT_TOTAL;
    hidden var _radius;
    hidden var _elapsedColor as Graphics.ColorType = DEFAULT_ELAPSED_COLOR;
    hidden var _remainingColor as Graphics.ColorType = DEFAULT_REMAINING_COLOR;
    hidden var _withOutline as Boolean = DEFAULT_WITH_OUTLINE;
    hidden var _outlineColor as Graphics.ColorType = DEFAULT_OUTLINE_COLOR;
    hidden var _thickness as Number = DEFAULT_OUTLINE_THICKNESS;
    hidden var _withDigits as Boolean = DEFAULT_WITH_DIGITS;
    hidden var _digitsFont as Graphics.FontType= DEFAULT_DIGITS_FONT;
    hidden var _digitsColor as Graphics.ColorType = DEFAULT_DIGITS_COLOR;
    hidden var _digitsFormat as String = DEFAULT_DIGITS_FORMAT;


    /**
     * Initialize defaults based on device screen size.
     */
    hidden function initialize() {
        var settings = System.getDeviceSettings();
        _width = (DEFAULT_SCREEN_FRACTION_WIDTH * settings.screenWidth).toNumber();
        _height = (DEFAULT_SCREEN_FRACTION_HEIGHT * settings.screenHeight).toNumber();
        _atX = (settings.screenWidth - _width) / 2;
        _atY = (settings.screenHeight - _height) / 2;
        _radius = (DEFAULT_RADIUS_FRACTION * _height).toNumber();
    }

    /**
     * Set the top-left position of the bar in pixels.
     *
     * @param x The x-coordinate.
     * @param y The y-coordinate.
     * @return self for fluent chaining.
     */
    function at(x as Number, y as Number) as ProgressBar {
        _atX = x;
        _atY = y;
        return self;
    }

    /**
     * Set the bar width in pixels.
     *
     * @param width The desired width.
     * @return self for fluent chaining.
     */
    hidden function withWidth(width as Number) as ProgressBar {
        _width = width;
        return self;
    }

    /**
     * Set the bar height in pixels.
     *
     * @param height The desired height.
     * @return self for fluent chaining.
     */
    hidden function withHeight(height as Number) as ProgressBar {
        _height = height;
        return self;
    }

    /**
     * Set the color used for the elapsed portion.
     *
     * @param color The elapsed segment color.
     * @return self for fluent chaining.
     */
    function withElapsedColor(color as Graphics.ColorType) as ProgressBar {
        _elapsedColor = color;
        return self;
    }

    /**
     * Set the color used for the remaining background.
     *
     * @param color The remaining segment color.
     * @return self for fluent chaining.
     */
    function withRemainingColor(color as Graphics.ColorType) as ProgressBar {
        _remainingColor = color;
        return self;
    }

    /**
     * Set the elapsed value used to compute progress.
     *
     * @param elapsed The elapsed amount.
     * @return self for fluent chaining.
     */
    function withElapsed(elapsed as Number) as ProgressBar {
        _elapsed = elapsed;
        return self;
    }

    /**
     * Set the total value used to compute progress.
     *
     * @param total The total amount.
     * @return self for fluent chaining.
     */
    function withTotal(total as Number) as ProgressBar {
        _total = total;
        return self;
    }

    /**
     * Enable drawing an outline around the bar.
     *
     * @return self for fluent chaining.
     */
    function withOutline() as ProgressBar {
        _withOutline = true;
        return self;
    }

    /**
     * Disable drawing an outline around the bar.
     *
     * @return self for fluent chaining.
     */
    function withoutOutline() as ProgressBar {
        _withOutline = false;
        return self;
    }   

    /**
     * Toggle outline drawing on or off.
     *
     * @param boolean True to draw an outline, false to hide it.
     * @return self for fluent chaining.
     */
    function toggleOutline(boolean as Boolean) as ProgressBar {
        _withOutline = boolean;
        return self;
    }

    /**
     * Set the outline color.
     *
     * @param color The outline color.
     * @return self for fluent chaining.
     */
    function withOutlineColor(color as Graphics.ColorType) as ProgressBar {
        _outlineColor = color;
        return self;
    }
    
    /**
     * Enable digits display using the current font/color/format.
     *
     * @return self for fluent chaining.
     */
    function withDigits() as ProgressBar {
        _withDigits = true;
        return self;
    }

    /**
     * Disable digits display.
     *
     * @return self for fluent chaining.
     */
    function withoutDigits() as ProgressBar {
        _withDigits = false;
        return self;
    }

    /**
     * Toggle digits display on or off.
     *
     * @param boolean True to show digits, false to hide.
     * @return self for fluent chaining.
     */
    function toggleDigits(boolean as Boolean) as ProgressBar {
        _withDigits = boolean;
        return self;
    }

    /**
     * Set the font used for digits.
     *
     * @param font The font to use.
     * @return self for fluent chaining.
     */
    function withDigitsFont(font as Graphics.FontType) as ProgressBar {
        _digitsFont = font;
        return self;
    }

    /**
     * Set the color used for digits.
     *
     * @param color The digits color.
     * @return self for fluent chaining.
     */
    function withDigitsColor(color as Graphics.ColorType) as ProgressBar {
        _digitsColor = color;
        return self;
    }

    /**
     * Set the format string used for digits.
     *
     * @param format A format string compatible with Number.format.
     * @return self for fluent chaining.
     */
    function withDigitsFormat(format as String) as ProgressBar {
        _digitsFormat = format;
        return self;
    }

    /**
     * Draw the progress bar into the provided device context.
     *
     * Subclasses should override this method to provide orientation-specific
     * rendering.
     *
     * @param dc The drawing context.
     * @return self for fluent chaining.
     */
    function draw(dc as Graphics.Dc) as ProgressBar {

        // Draw the remaining part covering the whole length of the bar
        dc.setColor(_remainingColor, Graphics.COLOR_TRANSPARENT);
        dc.fillRoundedRectangle(_atX, _atY, _width, _height, _radius);

        // Draw outline
        if (_withOutline) {
            dc.setColor(_outlineColor, Graphics.COLOR_TRANSPARENT);
            dc.drawRoundedRectangle(_atX, _atY, _width, _height, _radius);
        }

        return self;
    }

}


/**
 * Horizontal progress bar that fills left to right.
 */
class HorizontalProgressBar extends ProgressBar {

    private static const HORIZONTAL_DIGITS_SPACING_FACTOR = 0.25;

    /**
     * Initialize defaults using the base implementation.
     */
    function initialize() {
        ProgressBar.initialize();
    }

    /**
     * Set the bar length (width) in pixels.
     *
     * @param length The desired length.
     * @return self for fluent chaining.
     */
    function withLength(length as Number) as HorizontalProgressBar {
        _width = length;
        return self;
    }

    /**
     * Set the bar breadth (height) in pixels.
     *
     * @param breadth The desired breadth.
     * @return self for fluent chaining.
     */
    function withBreadth(breadth as Number) as HorizontalProgressBar {
        _height = breadth;
        return self;
    }

    /**
     * Draw a horizontal progress bar.
     *
     * @param dc The drawing context.
     * @return self for fluent chaining.
     */
    function draw(dc as Graphics.Dc) as ProgressBar {

        ProgressBar.draw(dc);

        // Draw the elapsed part
        var progressWidth = (1.0 * _width * _elapsed / _total).toNumber();
        dc.setColor(_elapsedColor, Graphics.COLOR_TRANSPARENT);
        dc.fillRoundedRectangle(_atX, _atY, progressWidth, _height ,_radius);

        if (_withDigits) {
            var digits = _elapsed.format(_digitsFormat);
            var digitsX = (_atX + _width - HORIZONTAL_DIGITS_SPACING_FACTOR * _height).toNumber();
            var digitsY = _atY + _height / 2;
            dc.setColor(_digitsColor, Graphics.COLOR_TRANSPARENT);
            dc.drawText(digitsX, digitsY, _digitsFont, digits, Graphics.TEXT_JUSTIFY_RIGHT | Graphics.TEXT_JUSTIFY_VCENTER);
        }

        return self;

    }

}

/**
 * Vertical progress bar that fills bottom to top.
 */
class VerticalProgressBar extends ProgressBar {

    private static const VERTICAL_DIGITS_SPACING_FACTOR = 0.5;

    /**
     * Initialize defaults using the base implementation.
     */
    function initialize() {
        ProgressBar.initialize();
    }

    /**
     * Set the bar length (height) in pixels.
     *
     * @param length The desired length.
     * @return self for fluent chaining.
     */
    function withLength(length as Number) as VerticalProgressBar {
        _height = length;
        return self;
    }

    /**
     * Set the bar breadth (width) in pixels.
     *
     * @param breadth The desired breadth.
     * @return self for fluent chaining.
     */
    function withBreadth(breadth as Number) as VerticalProgressBar {
        _width = breadth;
        return self;
    }

    /**
     * Draw a vertical progress bar.
     *
     * @param dc The drawing context.
     * @return self for fluent chaining.
     */
    function draw(dc as Graphics.Dc) as ProgressBar {

        ProgressBar.draw(dc);

        // Draw the elapsed part
        var progressHeight = (1.0 * _height * _elapsed / _total).toNumber();
        dc.setColor(_elapsedColor, Graphics.COLOR_TRANSPARENT);
        dc.fillRoundedRectangle(_atX, _atY + _height - progressHeight, _width, progressHeight, _radius);

        if (_withDigits) {
            var digits = _elapsed.format(_digitsFormat);
            var digitsX = _atX + _width / 2;
            var digitsY = (_atY + _height - VERTICAL_DIGITS_SPACING_FACTOR * _width).toNumber();
            dc.setColor(_digitsColor, Graphics.COLOR_TRANSPARENT);
            dc.drawText(digitsX, digitsY, _digitsFont, digits, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        }

        return self;

    }

}
