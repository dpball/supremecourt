pragma solidity >=0.7;


/*
*  ___ _   _ _ __  _ __ ___ _ __ ___   ___  
* / __| | | | '_ \| '__/ _ \ '_ ` _ \ / _ \
* \__ \ |_| | |_) | | |  __/ | | | | |  __/
* |___/\__,_| .__/|_|  \___|_| |_| |_|\___|
*           | |                            
*           |_|     
*           
*     ____ ___  _   _ ____ _____ 
*    / ___/ _ \| | | |  _ \_   _|
*   | |  | | | | | | | |_) || |  
*   | |__| |_| | |_| |  _ < | |  
*    \____\___/ \___/|_| \_\|_|  
*
*
*   "ERC 792 Arbitrator" and "Arbitrable" & "ERC1497 Evidence" from https://github.com/kleros/erc-792/tree/master/contracts 
*       Found under supremecourt/supremecourt/node_modules/@kleros/erc-792
*
*                                   
*
*/

import "node_modules/@kleros/erc-792/IArbitrable.sol"
import "node_modules/@kleros/erc-792/IArbitrator.sol"

import "BettingContract.sol"


/*
* This contract is used to compile the individual betting contracts
* 
*/
contract SupremeCourtArbitrator is IArbitrable {

    //status of a bet
    enum Status {Initial, Reclaimed, Disputed, Resolved}
    Status public status;

    /* The different ruling options when a contract is disputed
    *   RefusedToArbitrate: the standard 0 position
    *   PayOutOriginal: the bet should be concluded as reported in API/other means
    *   Refund: Something happened and the bet should be called off, participants refunded according to some principle
    *   reversePayout: The API/other reported false result
    */
    enum RulingOptions {RefusedToArbitrate, PayOutOriginal, Refund, ReversePayout}


    function createBet(uint256[][] _rulingOptions, uint256 _betName) is Ownable {
    /*
    Function to create a new bet contract
    
    params:
        uint256[][] _rulingOptions: The different outcomes of the bet and their initial distribution of 100%
            _rulingOptions[Win][65]
            _rulingOptions[Loose][30]
            _rulingOptions[Draw][4]
            _rulingOptions[Cancelled][1]
        uint256 betName: the name of the bet, eg: Manchester United - Liverpool 2020.01.03
    */
        bet = new BettingContract(_rulingOptions, _betName)

    }


    function rule()
}