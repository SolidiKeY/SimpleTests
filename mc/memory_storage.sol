// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

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
        assert(x == 1);
    }

    function testCopyArrayFromStorage() public {
        delete vS;
        vS.push(1);

        uint[] memory vM = vS;
        assert(vM[0] == 1);
    }

    function testCopyArrayFromMemory() public {
        delete vS;

        uint[] memory vM = new uint[](10);
        vM[0] = 1;

        vS = vM;

        assert(vS[0] == 1);
    }

    function testRemoveShallowCopy() public {
        delete vS;

        uint[] memory vM1 = new uint[](10);
        uint[] memory vM2 = new uint[](10);
        vM2 = vM1;

        vS.push(1);
        // vM1 = vS;
        // vS[0] = 2;
        
        // assert(vM1[0] == 1);
        assert(vM2[0] == 0);
    }

    Person carol;

    function testShallowCopy() public {
        delete carol;

        Person memory alice;
        Person memory bob;

        alice.account = bob.account;

        carol.account.balance = 10;

        alice.account = carol.account;

        assert(alice.account.balance == 10);
        assert(bob.account.balance == 0);
    }

}