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

import "https://github.com/dpball/supremecourt/blob/main/node_modules/%40openzeppelin/contracts/access/AccessControl.sol";
import "https://github.com/dpball/supremecourt/blob/main/node_modules/%40openzeppelin/contracts/token/ERC20/ERC20.sol";
//import "https://github.com/dpball/supremecourt/blob/main/SupremeCourtArbitrator.sol";
import "https://github.com/dpball/supremecourt/blob/main/node_modules/%40openzeppelin/contracts/token/ERC20/ERC20Pausable.sol";






contract BettingContract is IArbitrable, AccessControl, ERC20, Pausable {

    //set the SupremeCourtArbitrator as owner
    address public owner = msg.sender;
    IArbitrator public arbitrator;
    
    uint256[][] betOptions;
    uint256 numberOfbetOptions = 3;

    //right management under AccessControll
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");


    constructor(
        string memory name_,
        string memory symbol_
    ) {
        //set up minter role to itself
        _setupRole(MINTER_ROLE, address(this));
        //set up admin role for the SupremeCourtArbitrator
        _setupRole(ADMIN_ROLE, msg.sender)
    }

    
    function rule(uint256 _disputeID, uint256 _ruling) public override {
        
    }

    function mintPools() internal{
    /*
    *   Function for minting the pools
    *   function takes the odds from betOptions[][X]
    *  
    */
        require(hasRole(MINTER_ROLE)

    }



}