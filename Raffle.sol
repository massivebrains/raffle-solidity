// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

/**
* @title Raffle Contract
* @author massivebrains <Olaiya Segun>
* @notice Handles raffle implementation using ChainLink VRFv2.5
*/
contract Raffle {

	uint256 private immutable fee;
	uint256 private immutable interval;
	uint256 private lastRunAt;
	address payable[] private players;

	event NewPlayerEvent(address indexed player);

	error InsufficientETHException();

	constructor(uint256 _fee, uint256 _internval) {
		fee = _fee;
		interval = _internval;
		lastRunAt = block.timestamp;
	}

	function getFee() external view returns (uint256) {
		return fee;
	}

	function register() external payable {
		if (msg.value < fee) {
			revert InsufficientETHException();
		}

		players.push(payable(msg.sender));
		emit NewPlayerEvent((msg.sender));
	}

	function run() external {
		if (interval > (block.timestamp - lastRunAt)) {
			revert();
		}
	}
}
