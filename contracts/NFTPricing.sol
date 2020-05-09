pragma solidity ^0.6.7;

import "openzeppelin-solidity/contracts/access/Ownable.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "openzeppelin-solidity/contracts/token/ERC721/ERC721.sol";

contract  NFTPricing is Ownable, ERC721 {

    uint256 NFTPrice;
    uint256 NFTsIssued;

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
}