//SPDX-License-Identifier: MIT

pragma solidity 0.8.14;

contract WillThrow {
    error NotAllowedError(string);
    function errorFunction() public pure {
        // require(false, "Error message");
        // assert(false);
        revert NotAllowedError("You are not allowed");
    }

}

contract ErrorHnadling {
    event ErrorLogging(string reason);
    event ErrorLogCode(uint code);
    event ErrorLogByte(bytes lowLevelData);
    function catchTheError() public {
        WillThrow will = new WillThrow();
        try will.errorFunction() {
            // add code here if it works
        } catch Error(string memory reason) {
            emit ErrorLogging(reason);
        } catch Panic(uint errorCode) {
            emit ErrorLogCode(errorCode);
        } catch (bytes memory lowLevelData) {
            emit ErrorLogByte(lowLevelData);
        }
    }
}
