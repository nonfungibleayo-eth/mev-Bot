var flashLoan = artifacts.require('flashLoan');

module.exports = function (deployer) {  
deployer.deploy(flashLoan, 0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f, 0xd9e1cE17f2641f24aE83637ab66a2cca9C378B9F);
 }