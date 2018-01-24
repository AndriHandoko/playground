pragma solidity ^0.4.19;

import 'zeppelin-solidity/math/SafeMath.sol';
import './Playground20Token.sol';

contract Playground20TokenGenerator {
	
	using SafeMath for uint256;

	// 発行するトークン
	Playground20Token public token;

	// Ether とトークンのベース交換レート
	uint256 constant public rate;		// todo レートは固定じゃないほうが楽しいかも

	// トークン発行数のキャップ
	uint256 constant public cap;		// todo 21000000 * 10*18 

	// トークン発行時に送付された Ether を受け取る wallet
	address constant wallet = "0xac82f34a1a287B2206982A9220e7b68846C645dF";
	
 	event TokenPurchase(address indexed purchaser, address indexed beneficiary, uint256 value, uint256 amount);

	// コンストラクタ
	function Playground20TokenGenerator() {
		token = new Playground20Token();
	}

	function () external payable {
		buyTokens(msg.sender);
	}

	function buyTokens(address beneficiary) public payable {
		require(beneficiary != address(0));
		require(msg.value != 0);
	    uint256 weiAmount = msg.value;
        uint256 tokenAmount = weiAmount.mul(rate);
        // todo capを確認する
        token.mint(beneficiary, tokenAmount);
        TokenPurchase(msg.sender, beneficiary, weiAmount, tokenAmount);
        wallet.transfer(msg.value);
	}
	
}