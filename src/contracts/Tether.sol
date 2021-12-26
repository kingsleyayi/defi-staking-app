pragma solidity ^0.5.0;

contract Tether{
   string public name = 'mock Tether token';
    string public symbol = 'mUSDT';
    uint256 public totalSupply = 1000000000000000000000000;
    uint8 decimals = 18;

    event Transfer(
        address indexed _from,
        address indexed _to,
        uint _value

    );

    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint _value
    );

    mapping(address => uint256) public balanceof;
   mapping(address => mapping(address => uint256)) public allowance;

    constructor() public{
        balanceof[msg.sender] = totalSupply;
    }

    function transfer(address _to, uint _value) public returns (bool success){
        require(balanceof[msg.sender] >= _value);
        balanceof[msg.sender] -= _value;
        balanceof[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value)public returns (bool success){
        allowance[msg.sender][_spender] = _value;
        emit  Approval(msg.sender, _spender, _value);
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success){
        require(_value <= balanceof[_from]);
        require(_value <= allowance[_from][msg.sender]);
        balanceof[_to] += _value;
        balanceof[_from] -= _value;
        emit Transfer(_from, _to, _value);
        return true;
    }
}

