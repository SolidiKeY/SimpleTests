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
    }

    function testDeletePushArray() public {
        v.push(1);

        delete v;

        v.push();

        Assert.equal(v[0], 0, "v should be deleted");
    }

    function testDeleteStructArrayStorage() public {
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
    
    uint[][] s;

    function testRemoveMatrix() public {
        delete s;

        s.push();
        // Stores a pointer to the last array element of s.
        uint[] storage ptr = s[s.length - 1];
        // Removes the last array element of s.
        s.pop();
        // Writes to the array element that is no longer within the array.
        ptr.push(0x42);
        // Adding a new element to ``s`` now will not add an empty array, but
        // will result in an array of length 1 with ``0x42`` as element.
        s.push();
        Assert.equal(s[s.length - 1][0], 0x42, "same value as before");
    }

    function testDeleteMatrix() public {
        delete s;

        s.push();
        // Stores a pointer to the last array element of s.
        uint[] storage ptr = s[s.length - 1];
        // Delete s.
        delete s;
        // Writes to the array element that is no longer within the array.
        ptr.push(0x42);
        // Adding a new element to ``s`` now will not add an empty array, but
        // will result in an array of length 1 with ``0x42`` as element.
        s.push();
        Assert.equal(s[s.length - 1][0], 0x42, "same value as before");
    }
}
