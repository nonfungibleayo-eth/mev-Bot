var flashLoan = artifacts.require('flashLoan.sol');

module.exports = function (deployer) {  
deployer.deploy(flashLoan, '0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f','0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D');
 }