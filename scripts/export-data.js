const fs = require('fs');
const hre = require('hardhat');

async function main() {
    const CONTRACT_ADDRESS = "0x914d309524dC235D75FfAf14427bC353eCee0f48";
    
    console.log("Menghubungkan ke jaringan Ritual dan mengambil data...");
    
    // ABI untuk fungsi getAllGallery
    const ABI = [
        "function getAllGallery() external view returns (tuple(address owner, string xHandle, string discordHandle, string imageLink, bool isClaimed)[])"
    ];
    
    const provider = hre.ethers.provider;
    const contract = new hre.ethers.Contract(CONTRACT_ADDRESS, ABI, provider);
    
    try {
        const gallery = await contract.getAllGallery();
        
        let csvContent = "Slot Number,Owner Address,X (Twitter) Handle,Discord Handle,Genesis Link\n";
        let count = 0;
        
        for (let i = 0; i < gallery.length; i++) {
            const item = gallery[i];
            if (item.isClaimed) {
                const slotNo = i + 1;
                // Bersihkan data dari koma atau kutip agar tidak merusak format CSV
                const xHandle = item.xHandle.replace(/"/g, '""');
                const discordHandle = item.discordHandle.replace(/"/g, '""');
                const imageLink = item.imageLink.replace(/"/g, '""');
                
                csvContent += `${slotNo},${item.owner},"${xHandle}","${discordHandle}","${imageLink}"\n`;
                count++;
            }
        }
        
        const fileName = "Data_Genesis_Gallery.csv";
        fs.writeFileSync(fileName, csvContent);
        
        console.log(`\n✅ SUKSES! Berhasil mengekstrak ${count} data slot yang sudah diklaim.`);
        console.log(`📂 File tersimpan sebagai: ${fileName} (Bisa dibuka langsung menggunakan Excel/Google Sheets)`);
    } catch (error) {
        console.error("Gagal mengambil data dari blockchain:", error);
    }
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
