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
contract VenehsoftwNFTUpdate is ERC721, ERC721Enumerable, ERC721URIStorage {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    // Establecemos la cantidad maxima de NFT posibles a ser Minteados
    uint256 MAX_SUPPLY = 100000;
    uint8 MAX_QUANTITY_MINT = 5;

    // Declare Quantities structure
    struct Quantity 
    {
        uint8 mintcount; // Quantity of NFT Mint for xx address
        uint8 burncount; // Quantity of NFT Burn for xx address
    }
      
    // Creating a mapping for address and Quantities
    mapping (address => Quantity) quantities;
    address[] public AddressArray;

    constructor() ERC721("VenehsoftwNFTUpd", "VHNUP") {}

    // Para que el NFT puede ser minteado solo por la direccion que lo deploya
    // se debe incluir onlyOwner luego de public
    function safeMint(address to, string memory uri) public {

        // count the NFT Minted by account
        uint8 _mincount;
        _mincount = quantities[to].mintcount;
        // Verificamos si ya se mintearon todos los NFT posibles
        require(_tokenIdCounter.current() <= MAX_SUPPLY, "I'm sorry we reached the cap");
        // Verify that address isn't on the AddressArray
        if (_verf_address(to) == false)
        {
            _add_address(to);
        }
        // Verify that address to do Minted de MAX_QUANTITY_MINT
        require(quantities[to].mintcount < MAX_QUANTITY_MINT, "I'm sorry you reached the MAX Mint possible");
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
        // increment the count of NFT Minted
        quantities[to].mintcount = _mincount+1;
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
    function _burn(uint256 tokenId) 
        internal 
        override(ERC721, ERC721URIStorage) 
    {
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

    // Verify if a address is on the AddressArray
    function _verf_address(address key) 
        private 
        returns (bool)
    {   
        bool band;
        if (AddressArray.length == 0)
        {
            band = false;
        }
        else
        {
            band = false;
            for (uint i=0; i<(AddressArray.length); i++)
            {
                if (AddressArray[i] == key)
                {
                    band = true;
                    break;
                }
            }
        } 
        return band;
    }
    ////////////////////////////////////////

    // Add a new address to quantitiesArray
    function _add_address(address key) 
        private 
    {   
        uint256 _index;
        AddressArray.push(key);
        _index = AddressArray.length-1;
        quantities[key].mintcount = 0;
        quantities[key].burncount = 0;
        assert(AddressArray[_index] == key);            
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