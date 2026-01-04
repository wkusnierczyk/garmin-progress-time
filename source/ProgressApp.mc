using Toybox.Application;


/**
 * Entry point for the Progress Time app.
 *
 * Handles app lifecycle, initial view creation, and settings change updates.
 */

class ProgressApp extends Application.AppBase {

    /**
     * Initialize the application base class.
     */
    function initialize() {
        AppBase.initialize();
    }

    /**
     * Provide the initial view stack shown at launch.
     *
     * @return Array<View> the initial view stack.
     */
    function getInitialView() {
        return [ new ProgressView() ];
    }

    /**
     * Respond to settings changes by requesting a UI refresh.
     */
    function onSettingsChanged() as Void {
        WatchUi.requestUpdate();
    }

    /**
     * Provide the settings view and delegate for the settings menu.
     *
     * @return Array<WatchUi.View> the settings view and its delegate.
     */
    function getSettingsView() {
        return [ new ProgressMenu(), new ProgressDelegate() ];
    }

}
