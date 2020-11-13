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

import "https://github.com/kleros/erc-792/blob/master/contracts/IArbitrator.sol";
import "https://github.com/dpball/supremecourt/blob/main/node_modules/%40openzeppelin/contracts/access/AccessControl.sol";

import "https://github.com/dpball/supremecourt/blob/main/BettingContract.sol";


/*
* This contract is used to compile the individual betting contracts
* 
*/
contract SupremeCourtArbitrator is IArbitrator, AccessControl {

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


    constructor(
        
    ) {
        
    }

    function createBet(uint256[][] memory _betOptions, uint256 _betName) public {
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
        new BettingContract();


    }


    function disputeBet(address disputed) public {
        //function to dispute a bet using its contract address


    }
    
    function createDispute(uint256 _choices, bytes calldata _extraData) public override payable returns (uint256 disputeID){
        
    }

    function arbitrationCost(bytes calldata _extraData) public override pure returns (uint256 cost){

    }

    function appeal(uint256 _disputeID, bytes memory _extraData) public override payable {

    }

    function appealCost(uint256 _disputeID, bytes memory _extraData) public override pure returns (uint256){

    }

    function appealPeriod(uint256 _disputeID) public override pure returns (uint256 start, uint256 end){

    }

    function disputeStatus(uint256 _disputeID) public override view returns (DisputeStatus status){

    }

    function currentRuling(uint256 _disputeID) public override view returns (uint256 ruling){
        
    }

}