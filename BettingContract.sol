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

//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/AccessControl.sol";
//import "https://github.com/dpball/supremecourt/blob/main/SupremeCourtArbitrator.sol";






contract BettingContract is IArbitrable {

    //set the SupremeCourtArbitrator as owner
    address public owner = msg.sender;
    IArbitrator public arbitrator;
    
    uint256[][] betOptions;
    uint256 numberOfbetOptions;


    constructor(

    ) {
        numberOfbetOptions = 3;
    }

    
    function rule(uint256 _disputeID, uint256 _ruling) public override {
        
    }

}