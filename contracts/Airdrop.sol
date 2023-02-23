pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TokenAirdrop {
    address public owner;
    IERC20 public token;

    constructor(IERC20 _token) {
        owner = msg.sender;
        token = _token;
    }

    function airdrop(address[] memory _recipients, uint256 _totalAmount) public {
        require(msg.sender == owner, "Only contract owner can airdrop tokens");
        require(_recipients.length > 0, "Recipient list must not be empty");
        require(_totalAmount > 0, "Total amount must be greater than 0");

        uint256 numRecipients = _recipients.length;
        uint256 quarter = numRecipients / 4;
        uint256[] memory amounts = new uint256[](4);

        amounts[0] = _totalAmount * 40 / 100;  
        amounts[1] = _totalAmount * 30 / 100;
        amounts[2] = _totalAmount * 20 / 100;
        amounts[3] = _totalAmount * 10 / 100;

        uint256 startIndex = 0;
        for (uint256 i = 0; i < 4; i++) {
            uint256 endIndex = startIndex + quarter;
            if (i == 3) {
                endIndex = numRecipients;
            }

            for (uint256 j = startIndex; j < endIndex; j++) {
                token.transfer(_recipients[j], amounts[i]);
            }

            startIndex = endIndex;
        }
    }
}
