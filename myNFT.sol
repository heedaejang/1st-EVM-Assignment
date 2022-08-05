// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

// TokenId는 한 번 민팅 할때마다 자동으로 1씩 증가하게
// itemMint라는 함수 생성
// 이 함수는 오직 TokenURI 데이터만을 받는 함수
// 이 함수를 호출한 사람의 주소로 nft가 민팅
// 한 번 민팅될 때 수수료를 제외하고 0.001 이더가 같이 차감되게 설정
// 민팅은 누구나 가능하지만, 최대 1번까지 민팅 가능


contract myNFT is ERC721, ERC721URIStorage, Ownable{
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    constructor(string memory name, string memory symbol) ERC721(name, symbol){}
    
    // itemMint라는 함수 생성
    function itemMint(address to, uint256 tokenId, string memory uri) public virtual payable {

        require(msg.value >= 10000000, "Not enough ETH sent; check price!");
        _tokenIdCounter.increment(); //TokenId 1씩 증가
        uint256 tokenId = _tokenIdCounter.current();
        _mint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    function _burn(uint256, tokenID) internal ovveride(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

}