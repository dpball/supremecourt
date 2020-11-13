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
*   "ERC 792 Arbitrator" and "Arbitrable" & "ERC1497 Evidence"  https://github.com/kleros/erc-792/tree/master/contracts 
*   Also using code mostly from https://developer.kleros.io/en/latest/implementing-an-arbitrable.html tutorial
*                       !!this is not production safe!!
*
*
*/

import "https://github.com/kleros/erc-792/blob/master/contracts/IArbitrable.sol";
import "https://github.com/kleros/erc-792/blob/master/contracts/IArbitrator.sol";

import "https://github.com/dpball/supremecourt/blob/main/node_modules/%40openzeppelin/contracts/access/AccessControl.sol";
//import "https://github.com/dpball/supremecourt/blob/main/SupremeCourtArbitrator.sol";
import "https://github.com/dpball/supremecourt/blob/main/node_modules/%40openzeppelin/contracts/token/ERC20/ERC20Pausable.sol";






contract BettingContract is IArbitrable, AccessControl {


    address payable public payer = msg.sender;
    address payable public payee;
    uint256 public value;
    IArbitrator public arbitrator;
    string public agreement;
    uint256 public createdAt;
    uint256 public constant reclamationPeriod = 3 minutes;
    uint256 public constant arbitrationFeeDepositPeriod = 3 minutes;

    enum Status {Initial, Reclaimed, Disputed, Resolved}
    Status public status;

    uint256 public reclaimedAt;

    enum RulingOptions {RefusedToArbitrate, PayerWins, PayeeWins}

    uint256 constant numberOfRulingOptions = 2; // Notice that option 0 is reserved for RefusedToArbitrate


    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");

    constructor(
        address payable _payee,
        IArbitrator _arbitrator,
        string memory _agreement,

        string memory betName
    ) payable {
        //set up minter role to itself
        _setupRole(MINTER_ROLE, address(this));
        //set up admin role for the SupremeCourtArbitrator
        _setupRole(ADMIN_ROLE, msg.sender)
        //set up information regarding the bet
        betName = _name;

        value = msg.value;
        payee = _payee;
        arbitrator = _arbitrator;
        agreement = _agreement;
        createdAt = block.timestamp;
    }

    function releaseFunds() public {
        require(status == Status.Initial, "Transaction is not in Initial state.");

        if (msg.sender != payer)
            require(block.timestamp - createdAt > reclamationPeriod, "Payer still has time to reclaim.");

        status = Status.Resolved;
        payee.send(value);
    }

    function reclaimFunds() public payable {
        require(
            status == Status.Initial || status == Status.Reclaimed,
            "Transaction is not in Initial or Reclaimed state."
        );
        require(msg.sender == payer, "Only the payer can reclaim the funds.");

        if (status == Status.Reclaimed) {
            require(
                block.timestamp - reclaimedAt > arbitrationFeeDepositPeriod,
                "Payee still has time to deposit arbitration fee."
            );
            payer.send(address(this).balance);
            status = Status.Resolved;
        } else {
            require(block.timestamp - createdAt <= reclamationPeriod, "Reclamation period ended.");
            require(
                msg.value == arbitrator.arbitrationCost(""),
                "Can't reclaim funds without depositing arbitration fee."
            );
            reclaimedAt = block.timestamp;
            status = Status.Reclaimed;
        }
    }

    function depositArbitrationFeeForPayee() public payable {
        require(status == Status.Reclaimed, "Transaction is not in Reclaimed state.");
        arbitrator.createDispute{value: msg.value}(numberOfRulingOptions, "");
        status = Status.Disputed;
    }

    function rule(uint256 _disputeID, uint256 _ruling) public override {
        require(msg.sender == address(arbitrator), "Only the arbitrator can execute this.");
        require(status == Status.Disputed, "There should be dispute to execute a ruling.");
        require(_ruling <= numberOfRulingOptions, "Ruling out of bounds!");

        status = Status.Resolved;
        if (_ruling == uint256(RulingOptions.PayerWins)) payer.send(address(this).balance);
        else if (_ruling == uint256(RulingOptions.PayeeWins)) payee.send(address(this).balance);
        emit Ruling(arbitrator, _disputeID, _ruling);
    }

    function remainingTimeToReclaim() public view returns (uint256) {
        if (status != Status.Initial) revert("Transaction is not in Initial state.");
        return
            (createdAt + reclamationPeriod - block.timestamp) > reclamationPeriod
                ? 0
                : (createdAt + reclamationPeriod - block.timestamp);
    }

    function remainingTimeToDepositArbitrationFee() public view returns (uint256) {
        if (status != Status.Reclaimed) revert("Transaction is not in Reclaimed state.");
        return
            (reclaimedAt + arbitrationFeeDepositPeriod - block.timestamp) > arbitrationFeeDepositPeriod
                ? 0
                : (reclaimedAt + arbitrationFeeDepositPeriod - block.timestamp);
    }


    string public betName;
    uint256[][] betOptions;
    uint256 numberOfbetOptions = 3;


    
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