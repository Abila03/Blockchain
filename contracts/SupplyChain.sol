// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SupplyChain {
    struct Product {
        uint id; 
        string name; 
        string location; 
        string status; 
        uint256 timestamp; 
        address owner; 
    }

    mapping(uint => Product) public products; 
    uint public productCount; 

    constructor() {
        productCount = 0; 
    }

    event ProductCreated(uint id, string name, address owner);
    event ProductUpdated(uint id, string status, string location, address owner);

    function createProduct(string memory _name, string memory _location) public {
        require(bytes(_name).length > 0, "Nama produk kosong");
        require(bytes(_location).length > 0, "Lokasi produk kosong");

        productCount++; 
        products[productCount] = Product(
            productCount,
            _name,
            _location,
            "Diproduksi",
            block.timestamp,
            msg.sender
        );

        emit ProductCreated(productCount, _name, msg.sender);
    }

    function updateProduct(uint _productId, string memory _status, string memory _location) public {
        require(_productId > 0 && _productId <= productCount, "ID produk tidak valid!");
        Product storage product = products[_productId];
        require(product.id > 0, "Produk tidak ditemukan!");
        require(msg.sender == product.owner, "Hanya pemilik yang bisa memperbarui!");

        product.status = _status;
        product.location = _location;
        product.timestamp = block.timestamp;

        emit ProductUpdated(_productId, _status, _location, msg.sender);
    }

    function getProduct(uint _productId) public view returns (
        uint id, 
        string memory name, 
        string memory location, 
        string memory status, 
        uint256 timestamp, 
        address owner
    ) {
        require(_productId > 0 && _productId <= productCount, "ID produk tidak valid!");
        Product memory product = products[_productId];
        return (product.id, product.name, product.location, product.status, product.timestamp, product.owner);
    }
}
