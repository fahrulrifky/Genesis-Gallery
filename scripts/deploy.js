const hre = require("hardhat");

async function main() {
  console.log("Mendeploy RitualGenesisGallery...");

  const Gallery = await hre.ethers.getContractFactory("RitualGenesisGallery");
  const gallery = await Gallery.deploy();

  await gallery.waitForDeployment();
  const address = await gallery.getAddress();

  console.log(`RitualGenesisGallery berhasil di-deploy ke alamat: ${address}`);
  console.log("Silakan salin alamat ini dan tempelkan pada variabel CONTRACT_ADDRESS di index.html");
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
