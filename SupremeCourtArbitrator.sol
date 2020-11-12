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

    constructor(

    )


function createBet(string[] _rulingOptions, string _betName) is Ownable {
    /*
       Function to create a new bet contract
    
        params:
            string[] _rulingOptions: The different outcomes of the bet
            string betName: the name of the bet, eg: Manchester United - Liverpool 2020.01.03
    */
    bet = new BettingContract(_rulingOptions, _betName)

}


}