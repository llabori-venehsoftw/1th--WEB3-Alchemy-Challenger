// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts@4.8.0/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.8.0/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts@4.8.0/token/ERC721/extensions/ERC721URIStorage.sol";
// Para que es NFT sea minteado solo por la cuenta que deploya en SmartContract
// activamos la siguiente linea de codigo
// import "@openzeppelin/contracts@4.8.0/access/Ownable.sol";
import "@openzeppelin/contracts@4.8.0/utils/Counters.sol";

// Para que el NFT puede ser minteado solo por la direccion que lo deploya
// se debe incluir Ownable luego de ERC721URIStorage
contract VenehsoftwNFT is ERC721, ERC721Enumerable, ERC721URIStorage {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    // Establecemos la cantidad maxima de NFT posibles a ser Minteados
    uint256 MAX_SUPPLY = 100000;

    constructor() ERC721("VenehsoftwNFT", "VHN") {}

    // Para que el NFT puede ser minteado solo por la direccion que lo deploya
    // se debe incluir onlyOwner luego de public
    function safeMint(address to, string memory uri) public {
        // Verificamos si ya se mintearon todos los NFT posibles
        require(_tokenIdCounter.current() <= MAX_SUPPLY, "I'm sorry we reached the cap");
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    // The following functions are overrides required by Solidity.

    // Onchain enumeration of all token or token by account
    function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }
    ///////////////////////////////////////////////////////
   
    // Posibilidad de asociar un URI's al NFT
    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
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
    /////////////////////////////////////////

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}