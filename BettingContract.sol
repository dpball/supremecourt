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

import "SupremeCourtArbitrator.sol"

contract BettingContract is IArbitable, Ownable {

    //set the SupremeCourtArbitrator as owner
    address public owner = msg.sender;
    IArbitrator public arbitrator;
    
    uint256 RulingOptions;
    uint256 constant numberOfRulingOptions;


    constructor(
        IArbitrator _arbitrator,
        // -1 because 0 is reserved for RefusedToArbitrate
        numberOfRulingOptions = _rulingOptions.length-1;
    )
}