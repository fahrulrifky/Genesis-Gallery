// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract RitualGenesisGallery {
    
    struct GenesisCard {
        address owner;
        string xHandle;
        string discordHandle;
        string imageLink;
        bool isClaimed;
    }

    // Maksimal slot Genesis
    uint256 public constant MAX_GENESIS = 1000;

    // Mapping nomor genesis ke datanya
    mapping(uint256 => GenesisCard) public gallery;

    // Event yang terpancar ketika slot diklaim
    event SlotClaimed(uint256 indexed genesisNo, address indexed owner, string xHandle, string discordHandle);

    /**
     * @dev Fungsi untuk mengklaim atau memperbarui slot Genesis
     * @param _genesisNo Nomor Genesis (1 - 1000)
     * @param _xHandle Akun X / Twitter
     * @param _discordHandle Akun Discord
     * @param _imageLink Link gambar/bukti
     */
    function claimSlot(
        uint256 _genesisNo,
        string memory _xHandle,
        string memory _discordHandle,
        string memory _imageLink
    ) external {
        require(_genesisNo > 0 && _genesisNo <= MAX_GENESIS, "Invalid Genesis Number");
        
        GenesisCard storage card = gallery[_genesisNo];
        
        // Memastikan slot belum diklaim ATAU yang klaim adalah pemilik sebelumnya (jika ingin update)
        require(!card.isClaimed || card.owner == msg.sender, "Slot already claimed by another user");

        card.owner = msg.sender;
        card.xHandle = _xHandle;
        card.discordHandle = _discordHandle;
        card.imageLink = _imageLink;
        card.isClaimed = true;

        emit SlotClaimed(_genesisNo, msg.sender, _xHandle, _discordHandle);
    }

    /**
     * @dev Mengambil semua data Genesis sekaligus (Berguna untuk frontend galeri)
     * CATATAN: Ini akan memakan memori, sebaiknya panggil via 'staticCall' (view) di frontend.
     */
    function getAllGallery() external view returns (GenesisCard[] memory) {
        GenesisCard[] memory allCards = new GenesisCard[](MAX_GENESIS);
        for (uint256 i = 1; i <= MAX_GENESIS; i++) {
            allCards[i - 1] = gallery[i];
        }
        return allCards;
    }
}
