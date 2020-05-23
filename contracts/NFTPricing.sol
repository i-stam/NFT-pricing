/**
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version, see <https://www.gnu.org/licenses/>.
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY;
 */

pragma solidity ^0.6.7;

import "openzeppelin-solidity/contracts/access/Ownable.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "openzeppelin-solidity/contracts/token/ERC721/ERC721.sol";

contract  NFTPricing is Ownable, ERC721 {

    uint256 public NFTPrice;
    uint256 public NFTsIssued;

    constructor(uint256 _startPrice) public ERC721("nifty", "nft") {
        require(_startPrice != 0, "Starting price should not be 0");
        NFTPrice = _startPrice;
    }

    function acquireNFT() payable external {
        require(NFTPrice == msg.value, "Value does not match current price");
        _safeMint(msg.sender, NFTsIssued);
        NFTPrice = NFTPrice.mul(2);
        NFTsIssued += 1;
    }

    function balance() external view returns(uint256) {
        return address(this).balance;
    }

    function withdraw(address payable _to, uint256 _amount) external onlyOwner {
        _to.transfer(_amount);
    }
}