// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import "remix_tests.sol"; // this import is automatically injected by Remix.
import "hardhat/console.sol";
import "../contracts/Storage.sol";

contract MemoryStorageTest {
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
        Assert.equal(x, 1, "Storage value");
    }

    function testCopyArrayFromStorage() public {
        delete vS;
        vS.push(1);

        uint[] memory vM = vS;
        Assert.equal(vM[0], 1, "Memory copy");
    }

    function testCopyArrayFromMemory() public {
        delete vS;

        uint[] memory vM = new uint[](10);
        vM[0] = 1;

        vS = vM;

        Assert.equal(vS[0], 1, "Storage copy");
    }

    function testRemoveShallowCopy() public {
        delete vS;

        uint[] memory vM1 = new uint[](10);
        uint[] memory vM2 = new uint[](10);
        vM2 = vM1;

        vS.push(1);
        vM1 = vS;
        vS[0] = 2;
        
        Assert.equal(vM1[0], 1, "Does not shallow storage");
        Assert.equal(vM2[0], 0, "Removed shallow copy");
    }

    Person carol;

    function testShallowCopy() public {
        delete carol;

        Person memory alice;
        Person memory bob;

        alice.account = bob.account;

        carol.account.balance = 10;

        alice.account = carol.account;

        Assert.equal(alice.account.balance, 10, "Copied storage");
        Assert.equal(bob.account.balance, 0, "Copied storage");
    }

}