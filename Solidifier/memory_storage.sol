pragma solidity ^0.5.10;

library Verification {
    function Assert  (bool b) public;
    function Assume  (bool b) public;
    function CexPrinti  (uint i) public;
}

contract MemoryStorage {
    uint xS;
    uint[] vS;

    struct Account {
        int balance;
    }

    struct Person {
        int age;
        Account account;
    }

    function testSimpleCopyFromStorage() public {
        xS = 1;

        uint x = xS;
        Verification.Assert(x == 1);
    }

    function testCopyArrayFromStorage() public {
        Verification.Assume(vS.length == 0);

        vS.push(1);

        uint[] memory vM = vS;
        Verification.Assert(vM[0] == 1);
    }

    function testCopyArrayFromMemory() public {
        Verification.Assume(vS.length == 0);

        uint[] memory vM = new uint[](10);
        vM[0] = 1;

        vS = vM;

        Verification.Assert(vS[0] == 1);
    }

    function testRemoveShallowCopy() public {
        Verification.Assume(vS.length == 0);

        uint[] memory vM1 = new uint[](10);
        uint[] memory vM2 = new uint[](10);
        vM2 = vM1;

        vS.push(1);
        vM1 = vS;
        vS[0] = 2;
        
        Verification.Assert(vM1[0] == 1);
    }

    Person carol;

    function testShallowCopy() public {
        Person memory alice;
        Person memory bob;

        alice.account = bob.account;

        carol.account.balance = 10;

        alice.account = carol.account;

        Verification.Assert(alice.account.balance == 10);
        Verification.Assert(bob.account.balance == 0);
    }

}