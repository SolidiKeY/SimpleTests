pragma solidity ^0.5.10;

library Verification {
    function Assert  (bool b) public;
    function Assume  (bool b) public;
    function CexPrinti  (uint i) public;
}

contract DeleteStorageTest {
    int[] v;

    function testDeletePush() public {
        Verification.Assume(v.length == 0);

        v.push(1);
        v.pop();
        // solc does not compile
        v.push();

        Verification.Assert(v[0] == 0);
    }    
}
