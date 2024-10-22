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
    int vStorage;

    function testStoragePath() public {
        // int storage vStorageP = vStorage;
        // Code does not work
    }

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
        uint[] storage ptr = s[0];
        // Add more to ptr
        ptr.push(41);
        // Removes the last array element of s.
        s.pop();
        // st = store(store(st, s.length, 0), s, empty)

        Assert.equal(ptr.length, 0, "deleted ptr");
        // Writes to the array element that is no longer within the array.
        ptr.push(42);

        // st = store(store(st, s, empty), s.at(0).at(0), 42)

        // Adding a new element to ``s`` now will not add an empty array, but
        // will result in an array of length 1 with ``0x42`` as element.
        s.push();
        // st = store(store(store(st, s, empty), s.at(0).at(0), 42), s.length, 1) 

        Assert.equal(s[0][0], 42, "same value as before");
    }

    function testDeleteMatrix() public {
        delete s;

        s.push();
        // Stores a pointer to the last array element of s.
        uint[] storage ptr = s[0];
        // Delete s.
        delete s;
        // Writes to the array element that is no longer within the array.
        ptr.push(42);
        // Adding a new element to ``s`` now will not add an empty array, but
        // will result in an array of length 1 with 42 as element.
        s.push();
        Assert.equal(s[0][0], 42, "same value as before");
    }

    function testRemoveMatrixNoPath() public {
        delete s;

        s.push();
        s[0].push(41);
        s.pop();
        // s[0].push(42);
        // Code does not work because it reverts
    }

    function testAddToArray() public {
        delete v;

        v.push(0x41);
        v.pop();
        // int u = v[0];
        // Code does not work because index out of bound
    }

    function testRemoveMatrixNoPointer() public {
        delete s;

        s.push();
        s[0].push(42);
        s.pop();
        s.push();

        Assert.equal(s[0].length, 0, "array is erased");
    }
    
    function testRemoveMatrixPushBefore() public {
        delete s;

        s.push();
        uint[] storage ptr = s[0];
        ptr.push(0x42);
        s.pop();
        s.push();

        Assert.equal(s[0].length, 0, "array is erased");
        Assert.equal(ptr.length, 0, "ptr should be deleted");
    }

    uint[][][] sm;

    function testBigMatrix() public {
        delete sm;

        sm.push();
        sm[0].push();
        sm[0][0].push();

        uint[] storage smP = sm[0][0];
        sm.pop();
        smP.push(2);

        sm.push();
        sm[0].push();

        Assert.equal(sm[0][0][0], 2, "it is the same value");
    }

    function testBigMatrix2() public {
        delete sm;

        sm.push();
        sm[0].push();
        sm[0][0].push(1);

        uint[] storage smP = sm[0][0];
        sm.pop();
        Assert.equal(smP.length, 0, "Deleted everything");
        smP.push(2);

        sm.push();
        sm[0].push();

        Assert.equal(sm[0][0][0], 2, "it is the same value");
    }
}
