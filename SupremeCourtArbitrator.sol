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
*       We will mostly use CentralizedArbitratorWithAppeal for this
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

    

    address public owner = msg.sender;
    uint256 constant appealWindow = 3 minutes;
    uint256 internal arbitrationFee = 1e15;

    struct Dispute {
        IArbitrable arbitrated;
        uint256 choices;
        uint256 ruling;
        DisputeStatus status;
        uint256 appealPeriodStart;
        uint256 appealPeriodEnd;
        uint256 appealCount;
    }

    Dispute[] public disputes;

    function arbitrationCost(bytes memory _extraData) public override view returns (uint256) {
        return arbitrationFee;
    }

    function appealCost(uint256 _disputeID, bytes memory _extraData) public override view returns (uint256) {
        return arbitrationFee * (2**(disputes[_disputeID].appealCount));
    }

    function setArbitrationCost(uint256 _newCost) public {
        arbitrationFee = _newCost;
    }

    function createDispute(uint256 _choices, bytes memory _extraData)
        public
        override
        payable
        returns (uint256 disputeID)
    {
        require(msg.value >= arbitrationCost(_extraData), "Not enough ETH to cover arbitration costs.");

        disputes.push(
            Dispute({
                arbitrated: IArbitrable(msg.sender),
                choices: _choices,
                ruling: uint256(-1),
                status: DisputeStatus.Waiting,
                appealPeriodStart: 0,
                appealPeriodEnd: 0,
                appealCount: 0
            })
        );

        emit DisputeCreation(disputeID, IArbitrable(msg.sender));

        disputeID = disputes.length - 1;
    }

    function disputeStatus(uint256 _disputeID) public override view returns (DisputeStatus status) {
        Dispute storage dispute = disputes[_disputeID];
        if (disputes[_disputeID].status == DisputeStatus.Appealable && block.timestamp >= dispute.appealPeriodEnd)
            return DisputeStatus.Solved;
        else return disputes[_disputeID].status;
    }

    function currentRuling(uint256 _disputeID) public override view returns (uint256 ruling) {
        ruling = disputes[_disputeID].ruling;
    }

    function giveRuling(uint256 _disputeID, uint256 _ruling) public {
        require(msg.sender == owner, "Only the owner of this contract can execute rule function.");

        Dispute storage dispute = disputes[_disputeID];

        require(_ruling <= dispute.choices, "Ruling out of bounds!");
        require(dispute.status == DisputeStatus.Waiting, "Dispute is not awaiting arbitration.");

        dispute.ruling = _ruling;
        dispute.status = DisputeStatus.Appealable;
        dispute.appealPeriodStart = block.timestamp;
        dispute.appealPeriodEnd = dispute.appealPeriodStart + appealWindow;

        emit AppealPossible(_disputeID, dispute.arbitrated);
    }

    function executeRuling(uint256 _disputeID) public {
        Dispute storage dispute = disputes[_disputeID];
        require(dispute.status == DisputeStatus.Appealable, "The dispute must be appealable.");
        require(
            block.timestamp > dispute.appealPeriodEnd,
            "The dispute must be executed after its appeal period has ended."
        );

        dispute.status = DisputeStatus.Solved;
        dispute.arbitrated.rule(_disputeID, dispute.ruling);
    }

    function appeal(uint256 _disputeID, bytes memory _extraData) public override payable {
        Dispute storage dispute = disputes[_disputeID];
        dispute.appealCount++;

        require(msg.value >= appealCost(_disputeID, _extraData), "Not enough ETH to cover appeal costs.");

        require(dispute.status == DisputeStatus.Appealable, "The dispute must be appealable.");
        require(
            block.timestamp < dispute.appealPeriodEnd,
            "The appeal must occur before the end of the appeal period."
        );

        dispute.status = DisputeStatus.Waiting;

        emit AppealDecision(_disputeID, dispute.arbitrated);
    }

    function appealPeriod(uint256 _disputeID) public override view returns (uint256 start, uint256 end) {
        Dispute storage dispute = disputes[_disputeID];

        return (dispute.appealPeriodStart, dispute.appealPeriodEnd);
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
        /*
        *   function used to dispute bets in case someone thinks the API result was faulty
        *   function freezes the bet and opens a kleros dispute
        *   anyone can call it
        *
        *   params:
        *       disputed: the address of the contract that we wish to dispute
        *    
        */

        //psyudocode OurOwnPauseFunction(disputed);




/*

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

*/
}