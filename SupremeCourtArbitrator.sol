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

import "https://github.com/kleros/erc-792/blob/master/contracts/IArbitrable.sol";
import "https://github.com/kleros/erc-792/blob/master/contracts/IArbitrator.sol";

import "https://github.com/dpball/supremecourt/blob/main/BettingContract.sol";


/*
* This contract is used to compile the individual betting contracts
* 
*/
contract SupremeCourtArbitrator is IArbitrable {

    //status of a bet
    enum Status {Initial, Reclaimed, Disputed, Resolved}
    Status public status;


    //Access Control
    //JUDGE can dispute bets, set them on pause, its the default admin role and can set the roles of others
    bytes32 public constant JUDGE = keccak256("JUDGE_ROLE");
    //BOOKIE is the BettingContract, it can mint betting tokens
    bytes32 public constant BOOKIE = keccak256("BOOKIE_ROLE");



    /* The different ruling options when a contract is disputed
    *   RefusedToArbitrate: the standard 0 position
    *   PayOutOriginal: the bet should be concluded as reported in API/other means
    *   Refund: Something happened and the bet should be called off, participants refunded according to some principle
    *   reversePayout: The API/other reported false result
    */
    enum RulingOptions {RefusedToArbitrate, PayOutOriginal, Refund, ReversePayout}


    constructor(
        
    ) {
        
    }

    function createBet(uint256[][] _betOptions, uint256 _betName) {
    /*
    Function to create a new bet contract
    
    params:
        uint256[][] _betOptions: The different outcomes of the bet and their initial distribution of 100%
            _betOptions[Win][65]
            _betOptions[Loose][30]
            _betOptions[Draw][4]
            _betOptions[Cancelled][1]
        uint256 betName: the name of the bet, eg: Manchester United - Liverpool 2020.01.03
    */
        bet = new BettingContract(_betOptions, _betName);


    }


    function disputeBet(address disputed){
        //function to dispute a bet using its contract address


    }

}