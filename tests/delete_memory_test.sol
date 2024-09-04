// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import "remix_tests.sol"; // this import is automatically injected by Remix.
import "hardhat/console.sol";
import "../contracts/storage.sol";

contract DeleteMemoryTest {
    struct Account {
        int balance;
    }

    struct Person {
        int age;
        bool isMale;
        string[10] friends;
        Account account;
    }

    function testDeleteArray() public {
        int[] memory u = new int[](10);
        int[] memory v;

        v = u;

        u[1] = 10;

        Assert.equal(v[1], 10, "Should shallow copy");

        delete u;

        Assert.equal(v[1], 10, "Should not destroy v");
    }

    function testDeletePerson() public {
        Person memory alice;
        Person memory bob;

        bob = alice;

        alice.account.balance = 10;
        alice.age = 20;

        delete alice;

        Assert.equal(bob.age, 20, "Should not destroy bob");
        Assert.equal(bob.account.balance, 10, "Should not destroy bob");
    }
}
