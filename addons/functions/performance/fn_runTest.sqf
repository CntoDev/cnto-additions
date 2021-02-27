scriptName "cnto_fnc_runTest";
/* ----------------------------------------------------------------------------
Function: cnto_fnc_runTest
Description:
    Runs a test specified in _code for several times and logs average FPS and 
    time in the logs with CNTO_Test_Start and CNTO_Test_End tags for easier
    reporting. 
Parameters:
    _test    - Test name <STRING>
    _code    - Test code to execute <CODE>
    _retries - Number of test runs (optional, default: 1) <INTEGER>
    _setup   - Setup code ran before each test. Doesn't affect test measure. (optional, default: {}) <CODE>
    _teardown- Setup code ran after each test. Doesn't affect test measure. (optional, default: {}) <CODE>
Returns:
    Filtered array <ARRAY>
Examples:
    (begin example)
        [
            "Open Zeus", // Test name
            { 
                openCuratorInterface;
                (allCurators#0) addCuratorEditableObjects [entities "", true];
            }, // Test code
            5, // Retries
            {}, // Test setup code
            {
                (allCurators#0) removeCuratorEditableObjects [entities "" - [player], true];    
                findDisplay 312 closeDisplay 2;
                sleep 10;
            } // Test teardown code
        ] call cnto_fnc_runTest;
    (end)
Author:
    Highway
---------------------------------------------------------------------------- */
params ["_test", "_code", ["_retries", 1], ["_setup", {}], ["_teardown", {}]];
diag_log ["CNTO_Test_Start", missionName, _test];

private _runs = [];

for "_i" from 1 to _retries do {
    [] call _setup;
    
    private _startTime = diag_tickTime;
    private _startFrame = diag_frameNo;

    [] call _code;
    
    private _endTime = diag_tickTime;
    private _endFrame = diag_frameNo;
    
    _runs pushBack [(_endFrame-_startFrame)/(_endTime-_startTime), _endTime-_startTime];    
    [] call _teardown;
};

private _totalFps = 0;
private _totalTime = 0;
private _noRuns = count _runs;

{
    _totalFps = _totalFps + (_x#0);
    _totalTime = _totalTime + (_x#1);
} forEach _runs;

diag_log ["CNTO_Test_End", missionName, _test, format ["Average %1 fps, %2 s after %3 runs.", _totalFps/_noRuns, _totalTime/_noRuns, _noRuns]];
