const hre = require("hardhat");

async function main() {

    const ERC20 = await hre.ethers.getContractFactory("AURA");
    const erc20 = await ERC20.deploy("Sohaib", "S");

    const TokenAirdrop = await hre.ethers.getContractFactory("TokenAirdrop");
    const tokenAirdrop = await TokenAirdrop.deploy(erc20.address);

   console.log("ERC20 Address   " + erc20.address) //0x7c14752B1f81ff60F2F30997Fc66ea24be94Dee6
   console.log("Token Air Drop Address    " + tokenAirdrop.address) //0xDd81c64B1f0ab7f7812A65E303d6137FF2fe7104
  }
  

  main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });
  