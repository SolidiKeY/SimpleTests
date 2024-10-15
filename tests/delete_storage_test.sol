// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import "remix_tests.sol"; // this import is automatically injected by Remix.
import "hardhat/console.sol";
import "../contracts/storage.sol";

contract DeleteStorageTest {
    struct Account {
        int balance;
    }

    struct Person {
        int age;
        bool isMale;
        string[10] friends;
        Account account;
    }

    Person[] people;
    int[] v;
    Person p;

    function testDeleteArrayStorage() public {
        v.push(1);
        v.push(2);

        delete v[1];
        delete v;

        Assert.equal(v.length, 0, "v length should be zero");

        p.friends[0] = "alice";

        delete p.friends;
        Assert.equal(p.friends.length, 10, "length should be the same as before");
        Assert.equal(p.friends[0], "", "delete should delete everything");
    }

    function testDeletePush() public {
        v.push(1);
        v.pop();
        v.push();

        Assert.equal(v[0], 0, "It should erase array");
    }
}
