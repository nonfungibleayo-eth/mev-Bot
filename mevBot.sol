/// SPDX-License-Identifier: UNLICENSED;
pragma solidity =0.6.6;

import '@uniswap/v2-periphery/contracts/libraries/UniswapV2Library.sol';
import '@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol';
import '@uniswap/v2-core/contracts/interfaces/IUniswapV2Pair.sol';
import '@uniswap/v2-core/contracts/interfaces/IERC20.sol';
import '@uniswap/v2-core/contracts/interfaces/IUniswapV2Factory.sol';





contract flashLoan {
    address immutable factory;
    uint constant deadline = 10 days;
    IUniswapV2Router02 immutable sushirouter;

    address private constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

    constructor(address _factory, address _unirouter, address _sushirouter) public {
        factory = _factory;
        sushirouter = IUniswapV2Router02(_sushirouter);
    }

    function flashSwap(address _tokenBorrow, uint amount) external {
        address pair = IUniswapV2Factory(factory).getPair(_tokenBorrow, WETH);
        require(pair != address(0), 'not pair');

        address token0 = IUniswapV2Pair(pair).token0();
        address token1 = IUniswapV2Pair(pair).token1();

        uint amount0 = _tokenBorrow == token0 ? amount : 0;
        uint amount1 = _tokenBorrow == token1 ? amount : 0; 

        IUniswapV2Pair(pair).swap(amount0, amount1, address(this), "");
    }

    function UniswapV2Call(address _sender, uint _amount0, uint _amount1, bytes calldata data) external {

        address[] memory path = new address[] (2);
        uint amountToken = _amount0 == 0 ? _amount1 : _amount0;

        address token0 = IUniswapV2Pair(msg.sender).token0();
        address token1 = IUniswapV2Pair(msg.sender).token1();

        address pair = IUniswapV2Factory(factory).getPair(token0,token1);
        require(msg.sender == pair, "Not Pair");

        path[0] = _amount0 == 0 ? token1 : token0;
        path[1] = _amount0 == 0 ? token0 : token1;

        IERC20 token = IERC20(_amount0 == 0 ? token1 : token0);

        token.approve(address(sushirouter), amountToken);

        uint amountRequired = UniswapV2Library.getAmountsIn(factory, amountToken, path)[0];
        uint amountRecieved = sushirouter.swapExactTokensForTokens(amountToken, amountRequired, path, msg.sender, deadline)[1];

        

    }
}
