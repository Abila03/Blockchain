const SupplyChain = artifacts.require("SupplyChain");

module.exports = async function (deployer) {
  try {
    await deployer.deploy(SupplyChain);
    console.log("✅ Kontrak SupplyChain berhasil dideploy!");
  } catch (error) {
    console.error("❌ Gagal Deploy Kontrak SupplyChain:", error);
  }
};
